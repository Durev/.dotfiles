# https://github.com/spaceship-prompt/spaceship-prompt
autoload -U promptinit; promptinit
prompt spaceship
SPACESHIP_GIT_STATUS_COLOR="172"

SPACESHIP_PROMPT_ORDER=(
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  # node          # Node.js section
  # ruby          # Ruby section
  # elixir        # Elixir section
  exec_time     # Execution time
  line_sep      # Line break
  # vi_mode       # Vi-mode indicator
  exit_code     # Exit code section
  char          # Prompt character
)
