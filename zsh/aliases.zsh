# git
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gc="git commit -v"
alias gco="git checkout"
alias gl="git pull"
alias gp="git push"
alias gm="git merge"
alias gst="git status"
alias gdfc="git diff --cached"
alias glg="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# git-flow
alias gffs="git flow feature start"
alias gfrs="git flow release start"
alias gfrf="git flow release finish"

# rails
alias rc="rails console"
alias rs="rails server"
alias rr="rails routes"
alias rrg="rails routes | grep"
alias dbmigrate="bundle exec rake db:migrate db:rollback && bundle exec rake db:migrate db:test:prepare"

# rubocop
alias ra="rubocop -a"
alias rag="git status --porcelain | cut -c4- | xargs rubocop -a"

# bundler
alias be="bundle exec"
alias bel="BUNDLE_GEMFILE='private/LocalGemfile' bundle exec"

# navigation
alias dotfiles="cd $DOTFILES"

# misc
alias v="nvim"
alias subl=\''/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'\'

# For private aliases
[ -f $DOTFILES/zsh/aliases.local.zsh ] && source $DOTFILES/zsh/aliases.local.zsh
