return {
  "lukas-reineke/indent-blankline.nvim",
  version = "2.20.8", -- TODO: Unpin and finish v3 update
  config = function()
    require("indent_blankline").setup({
      use_treesitter = true,
      use_treesitter_scope = true,
      show_trailing_blankline_indent = false,
      show_first_indent_level = true,
      show_current_context = true,
      show_current_context_start = false,
      context_patterns = { "class", "method", "if", "block" },
      filetype_exclude = { "dashboard" }, -- nvim-dashboard
    })
  end,
}
