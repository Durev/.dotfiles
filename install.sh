#!/usr/bin/env bash
# macOS bootstrap install script for dotfiles
# - Installs Homebrew
# - Installs packages from Brewfile
# - Installs rbenv and latest stable Ruby, sets global, installs bundler
# - Configures iTerm2 to load preferences from repo; installs dynamic profile and remaps ⌘P -> Ctrl-P
# - Installs fonts via Brewfile
# - Symlinks config with GNU stow
# - Ensures lf previewer is executable
# - Idempotent and logged

set -euo pipefail

# Globals
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS_NAME="$(uname -s || true)"
TIMESTAMP() { date +"%Y-%m-%d %H:%M:%S"; }

# Logging
log()   { printf "[%s] [INFO ] %s\n"  "$(TIMESTAMP)" "$*"; }
warn()  { printf "[%s] [WARN ] %s\n"  "$(TIMESTAMP)" "$*" >&2; }
error() { printf "[%s] [ERROR] %s\n"  "$(TIMESTAMP)" "$*" >&2; }
hr()    { printf -- "------------------------------------------------------------\n"; }

require_macos() {
  if [[ "${OS_NAME}" != "Darwin" ]]; then
    error "This script is intended for macOS (Darwin). Detected: ${OS_NAME}"
    exit 1
  fi
}

# ————————————————————————————————————————————————————————————————————————
# Homebrew
# ————————————————————————————————————————————————————————————————————————
ensure_homebrew() {
  local brew_bin=""

  # 1. Try current PATH first
  if command -v brew >/dev/null 2>&1; then
    brew_bin="$(command -v brew)"
    log "Homebrew detected in PATH at: ${brew_bin}"
  else
    # 2. Probe known default locations (Apple Silicon + Intel)
    local candidates=(
      "/opt/homebrew/bin/brew"
      "/usr/local/bin/brew"
    )
    for c in "${candidates[@]}"; do
      if [[ -x "${c}" ]]; then
        brew_bin="${c}"
        log "Homebrew detected at standard location: ${brew_bin} (was not in PATH yet)"
        break
      fi
    done
  fi

  # 3. Install only if still not found
  if [[ -z "${brew_bin}" ]]; then
    log "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ -x "/opt/homebrew/bin/brew" ]]; then
      brew_bin="/opt/homebrew/bin/brew"
    elif [[ -x "/usr/local/bin/brew" ]]; then
      brew_bin="/usr/local/bin/brew"
    else
      error "Homebrew installation did not place brew in expected locations."
      exit 1
    fi
    log "Homebrew installed at: ${brew_bin}"
  fi

  # 4. Evaluate shellenv (ensures PATH + related vars for remainder of script)
  if ! eval "$("${brew_bin}" shellenv)"; then
    error "Failed to evaluate 'brew shellenv' from ${brew_bin}"
    exit 1
  fi

  # 5. Idempotently persist shellenv in ~/.zprofile using canonical path
  local zprofile="${HOME}/.zprofile"
  [[ -f "${zprofile}" ]] || touch "${zprofile}"
  local canonical_shellenv_line="eval \"\$(${brew_bin} shellenv)\""
  if ! grep -Fq "${canonical_shellenv_line}" "${zprofile}"; then
    printf '\n# Set Homebrew environment\n%s\n' "${canonical_shellenv_line}" >> "${zprofile}"
    log "Appended Homebrew shellenv to ${zprofile}"
  else
    log "Homebrew shellenv already present in ${zprofile}"
  fi
}

# ————————————————————————————————————————————————————————————————————————
# Brewfile packages
# ————————————————————————————————————————————————————————————————————————
install_brew_bundle() {
  if ! command -v brew >/dev/null 2>&1; then
    error "brew command not found; ensure_homebrew must run first."
    exit 1
  fi
  if [[ ! -f "${DOTFILES_DIR}/Brewfile" ]]; then
    warn "Brewfile not found at ${DOTFILES_DIR}/Brewfile - skipping brew bundle."
    return 0
  fi

  log "Checking Brewfile bundle state..."
  if brew bundle check --file="${DOTFILES_DIR}/Brewfile" >/dev/null 2>&1; then
    log "All Brewfile dependencies are already satisfied."
  else
    log "Installing Brewfile dependencies..."
    # Avoid auto-updating to reduce time/noise on re-runs
    HOMEBREW_NO_AUTO_UPDATE=1 brew bundle --file="${DOTFILES_DIR}/Brewfile"
    log "Brewfile dependencies installed."
  fi
}

# ————————————————————————————————————————————————————————————————————————
# iTerm2
# ————————————————————————————————————————————————————————————————————————
configure_iterm2_prefs() {
  # Log if iTerm app is missing
  if [[ ! -d "/Applications/iTerm.app" && ! -d "${HOME}/Applications/iTerm.app" ]]; then
    error "iTerm2 app not found in /Applications or ~/Applications. Please install iTerm2 manually."
  else
    log "iTerm2 app detected."
  fi

  # Point iTerm to load preferences from repo
  log "Configuring iTerm2 to load preferences from ${DOTFILES_DIR}/iTerm"
  defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${DOTFILES_DIR}/iTerm"
  defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
  log "iTerm2 preferences folder set. Some settings may apply after iTerm restart."

  # Install/refresh dynamic profile
  local dp_dir="${HOME}/Library/Application Support/iTerm2/DynamicProfiles"
  local repo_profile="${DOTFILES_DIR}/iTerm/profile.json"
  local out_profile="${dp_dir}/dotfiles-profile.json"

  mkdir -p "${dp_dir}"

  if [[ ! -f "${repo_profile}" ]]; then
    warn "Dynamic profile source not found at ${repo_profile}; skipping profile installation."
    return 0
  fi

  # Read source profile content
  local src
  src="$(cat "${repo_profile}")"

  # Determine if source already a dynamic profiles container (has top-level "Profiles")
  local prepared
  if printf "%s" "${src}" | grep -q '"Profiles"'; then
    prepared="${src}"
  else
    # Wrap single profile dict into a dynamic profiles container
    prepared=$(printf '{ "Profiles": [ %s ] }' "${src}")
  fi

  # Ensure the Keyboard Map contains mapping for Command-P -> Ctrl-P
  # Key: "0x23-0x100000" => Action 11 (send text), Text "0x10" (Ctrl-P)
  if printf "%s" "${prepared}" | grep -q '"0x23-0x100000"'; then
    log "Cmd-P to Ctrl-P mapping already present in dynamic profile."
  else
    # If empty Keyboard Map, replace {} with the mapping
    if printf "%s" "${prepared}" | grep -Eq '"Keyboard Map"\s*:\s*\{\s*\}'; then
      prepared="$(printf "%s" "${prepared}" | sed -E \
        's/"Keyboard Map"\s*:\s*\{\s*\}/"Keyboard Map" : { "0x23-0x100000" : { "Action" : 11, "Text" : "0x10" } }/')"
    # Else insert at the beginning of the Keyboard Map dict
    elif printf "%s" "${prepared}" | grep -q '"Keyboard Map"'; then
      prepared="$(printf "%s" "${prepared}" | awk '
        BEGIN { inserted=0 }
        {
          if (!inserted && match($0, /"Keyboard Map"[[:space:]]*:[[:space:]]*{/)) {
            # Print the line, then insert our mapping line followed by a comma
            print $0
            print "    \"0x23-0x100000\" : { \"Action\" : 11, \"Text\" : \"0x10\" },"
            inserted=1
          } else {
            print $0
          }
        }')"
    else
      # No Keyboard Map found: insert one at the beginning of the profile object
      prepared="$(printf "%s" "${prepared}" | awk '
        BEGIN { inserted=0 }
        {
          if (!inserted && $0 ~ /^{/) {
            print "{"
            print "  \"Keyboard Map\" : { \"0x23-0x100000\" : { \"Action\" : 11, \"Text\" : \"0x10\" } },"
            inserted=1
          } else {
            print $0
          }
        }')"
    fi
    log "Ensured Cmd-P to Ctrl-P mapping in dynamic profile."
  fi

  # Write if changed (idempotent)
  local tmp_out
  tmp_out="$(mktemp)"
  printf "%s\n" "${prepared}" > "${tmp_out}"

  # Normalize JSON (optional) if jq exists
  if command -v jq >/dev/null 2>&1; then
    if jq . "${tmp_out}" >/dev/null 2>&1; then
      jq . "${tmp_out}" > "${tmp_out}.fmt" && mv "${tmp_out}.fmt" "${tmp_out}"
    fi
  fi

  if [[ -f "${out_profile}" ]]; then
    if command -v shasum >/dev/null 2>&1; then
      local new_hash old_hash
      new_hash="$(shasum -a 256 "${tmp_out}" | awk '{print $1}')"
      old_hash="$(shasum -a 256 "${out_profile}" | awk '{print $1}')"
      if [[ "${new_hash}" == "${old_hash}" ]]; then
        log "Dynamic profile already up to date at ${out_profile}"
        rm -f "${tmp_out}"
        return 0
      fi
    else
      # Fallback naive comparison
      if cmp -s "${tmp_out}" "${out_profile}"; then
        log "Dynamic profile already up to date at ${out_profile}"
        rm -f "${tmp_out}"
        return 0
      fi
    fi
  fi

  mv -f "${tmp_out}" "${out_profile}"
  log "Installed/updated iTerm2 dynamic profile: ${out_profile}"
}

# ————————————————————————————————————————————————————————————————————————
# Ruby & rbenv
# ————————————————————————————————————————————————————————————————————————
ensure_rbenv_and_ruby() {
  # Ensure rbenv is available (Brewfile should have installed it)
  if ! command -v rbenv >/dev/null 2>&1; then
    warn "rbenv not found. Attempting to install via Homebrew..."
    brew install rbenv ruby-build
  fi

  # Initialize rbenv in this shell
  if command -v rbenv >/dev/null 2>&1; then
    eval "$(rbenv init - bash)"
  else
    error "rbenv is still not available after attempting installation."
    return 1
  fi

  # Determine latest stable Ruby version (filter out pre-releases)
  local latest
  latest="$(rbenv install -l | sed 's/^  *//' | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | tail -1 || true)"
  if [[ -z "${latest:-}" ]]; then
    error "Unable to determine latest stable Ruby version from rbenv."
    return 1
  fi
  log "Latest stable Ruby detected: ${latest}"

  # Install if not already installed
  if ! rbenv versions --bare | grep -qx "${latest}"; then
    log "Installing Ruby ${latest} (this can take a while)..."
    RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3 || true)" rbenv install -s "${latest}"
    log "Ruby ${latest} installed."
  else
    log "Ruby ${latest} already installed."
  fi

  # Set global version if not already set
  local current_global=""
  if [[ -f "${HOME}/.rbenv/version" ]]; then
    current_global="$(cat "${HOME}/.rbenv/version" || true)"
  fi
  if [[ "${current_global}" != "${latest}" ]]; then
    rbenv global "${latest}"
    log "Set global Ruby to ${latest}"
  else
    log "Global Ruby already set to ${latest}"
  fi

  # Ensure bundler installed in the selected Ruby
  eval "$(rbenv init - bash)"
  if ! gem list -i bundler >/dev/null 2>&1; then
    log "Installing bundler gem..."
    gem install bundler --no-document
    rbenv rehash || true
    log "Bundler installed."
  else
    log "Bundler already installed."
  fi
}

# ————————————————————————————————————————————————————————————————————————
# GNU stow
# ————————————————————————————————————————————————————————————————————————
run_stow() {
  if ! command -v stow >/dev/null 2>&1; then
    warn "GNU stow not found; attempting to install via Homebrew..."
    brew install stow
  fi
  if ! command -v stow >/dev/null 2>&1; then
    error "GNU stow not available. Skipping symlink step."
    return 0
  fi

  # Package directories = all first-level directories in DOTFILES_DIR,
  # excluding some that should not be stowed.
  local excludes=("iTerm" "tmp" ".git")
  local pkg
  local -a to_stow=()

  while IFS= read -r -d '' pkg; do
    pkg="$(basename "$pkg")"
    local skip=0
    for ex in "${excludes[@]}"; do
      if [[ "${pkg}" == "${ex}" ]]; then
        skip=1; break
      fi
    done
    if [[ "${skip}" -eq 0 ]]; then
      to_stow+=("${pkg}")
    fi
  done < <(find "${DOTFILES_DIR}" -mindepth 1 -maxdepth 1 -type d -print0)

  if [[ "${#to_stow[@]}" -eq 0 ]]; then
    warn "No directories found to stow."
    return 0
  fi

  log "Stowing packages: ${to_stow[*]}"
  local any_fail=0
  for pkg in "${to_stow[@]}"; do
    # Run stow for each package; continue on error (e.g., conflicts)
    if stow -d "${DOTFILES_DIR}" -t "${HOME}" -R "${pkg}"; then
      log "Stowed: ${pkg}"
    else
      any_fail=1
      warn "Stow encountered conflicts for package '${pkg}'."
      warn "You may need to remove or back up conflicting files in \$HOME before re-running."
    fi
  done

  if [[ "${any_fail}" -ne 0 ]]; then
    warn "Some packages failed to stow due to conflicts. Review warnings above."
  fi
}

# ————————————————————————————————————————————————————————————————————————
# lf previewer executable
# ————————————————————————————————————————————————————————————————————————
ensure_lf_previewer_exec() {
  local previewer="${DOTFILES_DIR}/lf/.config/lf/previewer.sh"
  if [[ -f "${previewer}" ]]; then
    if [[ ! -x "${previewer}" ]]; then
      chmod +x "${previewer}"
      log "Made executable: ${previewer}"
    else
      log "Already executable: ${previewer}"
    fi
  else
    warn "lf previewer not found at ${previewer}"
  fi
}

# ————————————————————————————————————————————————————————————————————————
# Main
# ————————————————————————————————————————————————————————————————————————
main() {
  hr
  log "Starting dotfiles bootstrap"
  hr
  require_macos
  ensure_homebrew
  install_brew_bundle
  configure_iterm2_prefs
  ensure_rbenv_and_ruby
  run_stow
  ensure_lf_previewer_exec

  hr
  log "Bootstrap complete."
  log "Notes:"
  log "- If iTerm2 was open, please restart it to ensure preferences and dynamic profile are applied."
  log "- If stow reported conflicts, resolve them and re-run this script safely."
  hr
}

main "$@"
