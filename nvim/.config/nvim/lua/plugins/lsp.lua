return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "elixirls",
          "eslint",
          "gopls",
          "lua_ls",
          "solargraph",
          "ts_ls",
          -- "ruby_ls",
        },
      })
    end,
  },

  { "neovim/nvim-lspconfig" },
}
