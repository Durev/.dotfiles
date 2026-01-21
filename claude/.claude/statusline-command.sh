#!/bin/bash

# Calculate and format reset time remaining
format_reset_time() {
    local reset_date="$1"

    if [ -z "$reset_date" ]; then
        echo ""
        return
    fi

    # Clean ISO 8601 date: remove microseconds and timezone
    local clean_date=$(echo "$reset_date" | sed 's/\.[0-9]*+/+/; s/+.*//')

    # Parse date to timestamp (BSD date syntax for macOS)
    local reset_ts=$(date -j -u -f "%Y-%m-%dT%H:%M:%S" "$clean_date" "+%s" 2>/dev/null)

    if [ -z "$reset_ts" ]; then
        echo ""
        return
    fi

    local now_ts=$(date "+%s")
    local diff_seconds=$((reset_ts - now_ts))

    # Check if date is in the past
    if [ "$diff_seconds" -lt 0 ]; then
        echo ""
        return
    fi

    # Format based on remaining time
    local days=$((diff_seconds / 86400))
    local remaining=$((diff_seconds % 86400))
    local hours=$((remaining / 3600))
    local minutes=$(((remaining % 3600) / 60))

    if [ "$days" -gt 0 ]; then
        printf "in %dd%02dh" "$days" "$hours"
    elif [ "$hours" -gt 0 ]; then
        printf "in %dh%02d" "$hours" "$minutes"
    else
        printf "in %dm" "$minutes"
    fi
}

# Fetch budget info from liteLLM API
get_budget_info() {
    # Check required environment variables
    if [ -z "$ANTHROPIC_BASE_URL" ] || [ -z "$ANTHROPIC_AUTH_TOKEN" ]; then
        return 1
    fi

    # Remove trailing slash from base URL
    local base_url="${ANTHROPIC_BASE_URL%/}"

    # Call API with short timeout
    local response=$(curl --silent --max-time 1 \
        -H "Authorization: Bearer $ANTHROPIC_AUTH_TOKEN" \
        "$base_url/key/info" 2>/dev/null)

    if [ -z "$response" ]; then
        return 1
    fi

    # Extract budget info as JSON (spend, max_budget, budget_reset_at)
    echo "$response" | jq -r '{
        spend: .info.spend,
        max_budget: .info.max_budget,
        budget_reset_at: .info.budget_reset_at
    }' 2>/dev/null
}

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir')
if [ "$cwd" = "$HOME" ]; then dir_path="~"
elif [ "$cwd" = "/" ]; then dir_path="/"
else dir_path=$(echo "$cwd" | sed "s|^$HOME|~|" | awk -F/ '{if (NF <= 3) print $0; else print ".../" $(NF-1) "/" $NF}')
fi

git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  git_branch=$(git -C "$cwd" branch --show-current 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# Dim gray color for pipe separator
PIPE="$(printf '\033[38;2;128;128;128m') | $(printf '\033[0m')"

output="$(printf '\033[38;2;189;195;199m')  ${dir_path} $(printf '\033[0m')"
[ -n "$git_branch" ] && output="${output}${PIPE}$(printf '\033[38;2;243;156;18m\033[1m')  ${git_branch} $(printf '\033[0m')"

# Add budget info if available
budget_json=$(get_budget_info)
if [ $? -eq 0 ] && [ -n "$budget_json" ]; then
  spend=$(echo "$budget_json" | jq -r '.spend // empty')
  max_budget=$(echo "$budget_json" | jq -r '.max_budget // empty')
  budget_reset_at=$(echo "$budget_json" | jq -r '.budget_reset_at // empty')

  if [ -n "$spend" ] && [ -n "$max_budget" ]; then
    budget_text=$(printf "Budget: \$%.2f/\$%.0f" "$spend" "$max_budget")

    # Add reset time if available
    if [ -n "$budget_reset_at" ]; then
      reset_time=$(format_reset_time "$budget_reset_at")
      if [ -n "$reset_time" ]; then
        budget_text="${budget_text} (reset ${reset_time})"
      fi
    fi

    output="${output}${PIPE}$(printf '\033[38;2;179;157;219m')  ${budget_text} $(printf '\033[0m')"
  fi
fi

# Add context window usage if available
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
INPUT_TOKENS=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
CACHE_CREATE=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')
CACHE_READ=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')
CURRENT_TOKENS=$((INPUT_TOKENS + CACHE_CREATE + CACHE_READ))

if [ "$CONTEXT_SIZE" -gt 0 ] && [ "$CURRENT_TOKENS" -gt 0 ]; then
  # Convert to kilotokens with 1 decimal place
  current_k=$(awk "BEGIN {printf \"%.1f\", $CURRENT_TOKENS/1000}")
  max_k=$(awk "BEGIN {printf \"%.0f\", $CONTEXT_SIZE/1000}")
  context_text=$(printf "Context: %sK/%sK" "$current_k" "$max_k")
  output="${output}${PIPE}$(printf '\033[38;2;179;157;219m')  ${context_text} $(printf '\033[0m')"
fi

# Add model name
MODEL=$(echo "$input" | jq -r '.model.display_name // empty')
if [ -n "$MODEL" ]; then
  output="${output}${PIPE}$(printf '\033[38;2;179;157;219m')  ${MODEL} $(printf '\033[0m')"
fi

echo "$output"
