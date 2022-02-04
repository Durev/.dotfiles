# git checkout branch/tag x fzf
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# git merge x fzf
fgm() {
  git merge $(select_branch_or_tag)
}

# pull main and merge in current branch
mma() {
  git checkout main
  git pull
  git checkout -
  git merge main
}

# git push (with the upstream not set yet)
fgp() {
  git push --set-upstream origin $(git_current_branch)
}

# Clean local branches
git_cleanup() {
  git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
}

