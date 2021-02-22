# git
alias gdfc="git diff --cached"
alias glg="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# git-flow
alias gffs="git flow feature start"
alias gfrs="git flow release start"
alias gfrf="git flow release finish"

# rails
alias rrg="rr | grep"

# rubocop
alias ra="rubocop -a"

# bundler
alias bel="BUNDLE_GEMFILE='private/LocalGemfile' bundle exec"

# For private aliases
[ -f $DOTFILES/aliases.local.zsh ] && source $DOTFILES/aliases.local.zsh