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

# fzf
export FZF_DEFAULT_COMMAND="fd --type file --color=always --strip-cwd-prefix --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--ansi --preview-window 'right:50%' --preview 'bat --color=always --style=header,grid,changes --line-range :300 {}'"

# Use case-sensitive completion
CASE_SENSITIVE="true"

# Timestamp shown in the history command output - cf. 'man strftime'
HIST_STAMPS="yyyy-mm-dd"

# colorscheme for exa, lf, fd and tools using LS_COLORS
export LS_COLORS="$(vivid generate nord)"
