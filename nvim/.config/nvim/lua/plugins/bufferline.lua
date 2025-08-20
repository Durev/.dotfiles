return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "tabs",
        diagnostics = "nvim_lsp",
        offsets = { { filetype = "NvimTree", text = "", text_align = "left" } },
        separator_style = "thin",
        show_buffer_close_icons = false,
        always_show_bufferline = false,
        sort_by = "tabs",
        color_icons = true,
        show_tab_indicators = false,
      },
    })
  end,
}
