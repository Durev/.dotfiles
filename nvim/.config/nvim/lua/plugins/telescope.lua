local tl_actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- TODO: Is there a way to do this using the git_stash picker config?
local function custom_git_stash_pop(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  tl_actions.close(prompt_bufnr)
  local cmd = "git stash pop " .. selection.value
  vim.fn.system(cmd)
end

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-n>"] = tl_actions.cycle_history_next,
            ["<C-p>"] = tl_actions.cycle_history_prev,
            ["<C-j>"] = tl_actions.move_selection_next,
            ["<C-k>"] = tl_actions.move_selection_previous,
            ["<C-h>"] = tl_actions.which_key,
            ["<C-s>"] = tl_actions.select_horizontal,
          },
        },
        vimgrep_arguments = {
          "rg",
          "--hidden",
          "-g",
          "!{.git/*,tags,.worktrees/*}", -- excluded folders and files
          -- "--color=never",
          "--no-heading",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "  ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--hidden", "--type", "file", "-E", ".git", "-E", ".worktrees" },
        },
        git_stash = {
          attach_mappings = function(_, map)
            map("i", "<cr>", custom_git_stash_pop)
            map("n", "<cr>", custom_git_stash_pop)
            return true
          end,
        },
      },
    })
  end,
}
