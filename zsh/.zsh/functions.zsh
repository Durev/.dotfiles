# mk directory (can be nested) and cd into it
mkcd() {
  mkdir -p -- "$1" && cd -P -- "$1"
}

# --- Files and plugin management ---
# From https://github.com/Mach-OS/Machfiles

# Source files if they exist
zsh_add_file() {
  [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

zsh_add_plugin() {
  PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)

  if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
  else
    git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
  fi
}

# ------- Git -------
__git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}

# Outputs the name of the current branch
# From https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/git.zsh
git_current_branch() {
  local ref
  ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

# git checkout branch x fzf
fco() {
  local branches target
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# git rebase branch x fzf
frb() {
  local branches target
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git rebase $(echo "$target" | awk '{print $2}')
}

# switch git worktree x fzf
fgw() {
  local worktrees target

  worktrees=$(
    git worktree list --porcelain |
    awk -F " " '/worktree/ {print "\x1b[32;1mworktree\x1b[m\t" $2}') || return

  target=$(
    echo "$worktrees" |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return

  cd "$(echo "$target" | awk '{print $2}')"
}

# git merge x fzf
fgm() {
  git merge $(select_branch_or_tag)
}

# return main or master - errors if both or none exists
main_or_master() {
  git show-ref --quiet refs/heads/main
  local main_status=$?

  git show-ref --quiet refs/heads/master
  local master_status=$?

  if [[ $master_status -eq 0 && $main_status -eq 0 ]]
  then
    return 1
  elif [[ $main_status -eq 0 ]]
  then
    echo 'main'
  elif [[ $master_status -eq 0 ]]
  then
    echo 'master'
  else
    return 1
  fi
}

gcm() {
  git checkout $(main_or_master)
}

# fetch main/master and merge in current branch
mma() {
  git fetch origin $(main_or_master)
  git merge origin/$(main_or_master)
}

# fetch main/master and rebase in current branch
rbma() {
  git fetch origin $(main_or_master)
  git rebase origin/$(main_or_master)
}

# rebase interative with autosquash on current version of main/master
riama() {
  git rebase -i --autosquash --no-edit origin/$(main_or_master)
}

# commit the staged changes as a fixup using fzf to select the commit
fixup() {
 local commits
 local commit
 local commit_hash

 commits="$(git log --abbrev-commit --decorate --format=format:'%C(magenta)%h%C(reset) - %s%C(reset) %C(cyan)' -50)"

 commit="$(echo "$commits" | fzf-tmux +m)" || return
 commit_hash="$(echo "$commit" | cut -d ' ' -f 1)"

 git commit --fixup=$commit_hash
}

# git push (with the upstream not set yet)
fgp() {
  git push --set-upstream origin $(git_current_branch)
}

# Clean local branches
git_cleanup() {
  git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
}

# Checkout on master and start fresh
git_update() {
  gcm
  git pull
  git_cleanup

  if [ -f Gemfile ]; then
    echo "Installing gems..."
    bundle install
  else
    echo "No Gemfile found in the current directory."
  fi
}

# lf: bind Q to 'quit and move to current directory'
# https://github.com/gokcehan/lf/issues/785
lf () {
  local tempfile="$(mktemp)"
  command lf -command "map Q \$echo \$PWD >$tempfile; lf -remote \"send \$id quit\"" "$@"
  if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n $(pwd))" ]]; then
    cd -- "$(cat "$tempfile")" || return
  fi
  command rm -f -- "$tempfile" 2>/dev/null
}

# print filesize in human readable format
file_size() {
  du -h "$1" | cut -f1
}

# decode base64 and jwt
_decode_base64_url() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'='
  fi
  echo "$result" | tr '_-' '/+' | base64 -d
}

# $1 => JWT to decode
# $2 => either 1 for header or 2 for body (default is 2)
decode_jwt() { _decode_base64_url $(echo -n $1 | cut -d "." -f ${2:-2}) | jq .; }
decode_jwtp() { decode_jwt "$(pbpaste)" }
