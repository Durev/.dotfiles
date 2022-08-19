-- Language servers config
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- LSP debugging
-- vim.lsp.set_log_level("debug")

-- mason
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    }
  }
})

-- mason-lspconfig
require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "elixirls",
    "gopls",
    "solargraph",
    "sumneko_lua",
  }
})

-- navic context component for statusline
local navic = require("nvim-navic")

-- ruby
require'lspconfig'.solargraph.setup{
  settings = {
    solargraph = {
      diagnostics = true,
      completion = true
    }
  },
  -- on_attach = function(client, bufnr)
  --   navic.attach(client, bufnr)
  -- end
}
-- TODO: attach navic when solargraph uses documentSymbols
-- https://github.com/castwide/solargraph/issues/550

-- bash
require'lspconfig'.bashls.setup{
  filetypes = { "sh", "zsh" },
  -- on_attach = function(client, bufnr)
  --   navic.attach(client, bufnr)
  -- end
}
-- TODO: attach navic when bashls uses documentSymbols

-- lua
require'lspconfig'.sumneko_lua.setup{
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
}

-- elixir
require'lspconfig'.elixirls.setup{
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
}

-- go
require'lspconfig'.gopls.setup{
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
}

-- diagnostics
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = false,
  update_in_insert = false,
  -- float = { border = "single" },
})

-- local signs = { Error = "🚨", Warn = "⚠️", Hint = "💡", Info = "💡" }
local signs = { Error = "", Warn = "", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
