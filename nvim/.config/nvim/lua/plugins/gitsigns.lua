return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      preview_config = {
        -- Options passed to nvim_open_win
        border = "none",
        style = "minimal",
      },
    })
  end,
}
