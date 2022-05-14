-- Language servers config
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- LSP debugging
-- vim.lsp.set_log_level("debug")

-- lsp installer
require("nvim-lsp-installer").setup({
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})

-- ruby
require'lspconfig'.solargraph.setup{
  settings = {
    solargraph = {
      diagnostics = true,
      completion = true
    }
  }
}

-- bash
require'lspconfig'.bashls.setup{
  filetypes = { "sh", "zsh" }
}

-- solidity
-- require'lspconfig'.solang.setup{
--   cmd = { "solang", "--language-server", "--target", "ewasm" }
-- }

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
}

-- elixir
require'lspconfig'.elixirls.setup{}

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

-- JS linting
-- require'lspconfig'.eslint.setup{}
