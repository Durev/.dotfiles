#!/usr/bin/env bash
# macOS bootstrap install script for dotfiles
# - Installs Homebrew
# - Installs packages from Brewfile
# - Installs rbenv and latest stable Ruby, sets global, installs bundler
# - Configures iTerm2 to load preferences from repo
# - Configures macOS keyboard settings
# - Installs fonts via Brewfile
# - Symlinks config with GNU stow
# - Ensures lf previewer is executable
# - Idempotent and logged
#
# WARNING: Do not run this script from within iTerm2!
# This script will quit iTerm2 to configure its preferences properly.
# Run from Terminal.app or another terminal emulator instead.

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

  # Check if iTerm is currently running and force quit if needed
  if pgrep -f "iTerm" >/dev/null 2>&1; then
    warn "iTerm2 is currently running. Forcing quit to ensure preferences apply properly..."
    osascript -e 'tell application "iTerm2" to quit' 2>/dev/null || true
    sleep 2
    # Kill any remaining iTerm processes
    pkill -f "iTerm" 2>/dev/null || true
    sleep 1
    log "iTerm2 has been quit. Preferences will now be configured."
  fi

  # Point iTerm to load preferences from repo
  log "Configuring iTerm2 to load preferences from ${DOTFILES_DIR}/iTerm"

  # Kill any remaining preference synchronization
  defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool false
  defaults write com.googlecode.iterm2 PrefsCustomFolder -string ""
  sleep 1

  # Now set the correct preferences
  if ! defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${DOTFILES_DIR}/iTerm"; then
    error "Failed to set PrefsCustomFolder. Permissions issue."
    return 1
  fi
  if ! defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true; then
    error "Failed to set LoadPrefsFromCustomFolder. Permissions issue."
    return 1
  fi

  # Force preferences synchronization
  defaults write com.googlecode.iterm2 NoSyncSuppressRestartAnnouncement -bool true

  # Verify the settings were applied
  local actual_folder actual_load
  actual_folder="$(defaults read com.googlecode.iterm2 PrefsCustomFolder 2>/dev/null || echo "UNSET")"
  actual_load="$(defaults read com.googlecode.iterm2 LoadPrefsFromCustomFolder 2>/dev/null || echo "UNSET")"

  if [[ "${actual_folder}" == "${DOTFILES_DIR}/iTerm" && "${actual_load}" == "1" ]]; then
    log "iTerm2 preferences configured successfully."
    log "Launch iTerm2 to load your custom profile with correct colors and font."
    log "The 'Durev' profile should be automatically selected with dark background (#001e26)."
  else
    warn "iTerm2 preference settings may not have applied correctly:"
    warn "  Expected PrefsCustomFolder: ${DOTFILES_DIR}/iTerm"
    warn "  Actual PrefsCustomFolder: ${actual_folder}"
    warn "  Expected LoadPrefsFromCustomFolder: 1"
    warn "  Actual LoadPrefsFromCustomFolder: ${actual_load}"
    warn "Try re-running this script."
  fi
}

# ————————————————————————————————————————————————————————————————————————
# macOS keyboard settings
# ————————————————————————————————————————————————————————————————————————
configure_macos_keyboard() {
  log "Configuring macOS keyboard settings..."

  # Set fast key repeat (lower = faster; range 1-8, default ~6)
  defaults write -g KeyRepeat -int 2
  log "Set KeyRepeat to 2 (fast repeat speed)"

  # Set short initial delay before repeat starts (lower = shorter; range 10-120, default ~25)
  defaults write -g InitialKeyRepeat -int 15
  log "Set InitialKeyRepeat to 15 (short initial delay)"

  log "Keyboard settings configured. Changes take effect for new applications."
}

# ————————————————————————————————————————————————————————————————————————
# macOS language and locale settings
# ————————————————————————————————————————————————————————————————————————
configure_macos_locale() {
  log "Configuring macOS language and locale settings..."

  # Set primary language to English (UK), secondary to French (France)
  defaults write -g AppleLanguages -array "en-GB" "fr-FR"
  log "Set primary language to English (UK)"

  # Set locale to English with France region (for date/number formatting)
  defaults write -g AppleLocale -string "en_FR"
  log "Set locale to en_FR (English language, France region formatting)"

  log "Language and locale settings configured. Some changes may require logout/login."
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
  configure_macos_keyboard
  configure_macos_locale
  ensure_rbenv_and_ruby
  run_stow
  ensure_lf_previewer_exec

  hr
  log "Bootstrap complete."
  log "Notes:"
  log "- If iTerm2 was open, please restart it to ensure preferences are applied."
  log "- If stow reported conflicts, resolve them and re-run this script safely."
  hr
}

main "$@"
