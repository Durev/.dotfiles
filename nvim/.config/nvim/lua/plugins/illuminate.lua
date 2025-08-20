return {
  "RRethy/vim-illuminate",
  config = function()
    require("illuminate").configure({
      providers = {
        -- 'lsp', 'treesitter', 'regex'
        "regex",
      },
      filetypes_denylist = {
        "NvimTree",
        "TelescopePrompt",
        "dashboard",
      },
    })
  end,
}
