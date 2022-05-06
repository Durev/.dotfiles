export VISUAL=nvim
export EDITOR="$VISUAL"

# History
HISTFILE="$HOME/.zsh_history"
# Number of events stored in the zsh history file
SAVEHIST=20000
# Number of events loaded into memory
HISTSIZE=20000

# Folder for manually added binaries
export PATH="$HOME/.local/bin":$PATH

# Homebrew: Only update explicitely required packages
export HOMEBREW_NO_AUTO_UPDATE=1

# Setting fd as the default source for fzf (thus respecting .gitignore)
export FZF_DEFAULT_COMMAND='ag -g ""'

# Use case-sensitive completion
CASE_SENSITIVE="true"

# Timestamp shown in the history command output - cf. 'man strftime'
HIST_STAMPS="yyyy-mm-dd"
