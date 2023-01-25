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
    },
  },
})

-- mason-lspconfig
require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "elixirls",
    "eslint",
    "gopls",
    "solargraph",
    "sumneko_lua",
    "tsserver",
  },
})
-- NOTE: Mason could also be used to install directly formatters and linters

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  sources = {
    diagnostics.rubocop.with({
      command = "bundle",
      args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
    }),
    formatting.rubocop, -- enough or need a special command too?
    formatting.prettier,
    formatting.stylua,
  },
})

-- Format current buffer
vim.api.nvim_create_user_command("Format", function()
  vim.lsp.buf.format({ timeout_ms = 2000 })
end, { nargs = 0 })

-- ruby
require("lspconfig").solargraph.setup({
  settings = {
    solargraph = {
      diagnostics = true,
      completion = true,
    },
  },
})

-- bash
require("lspconfig").bashls.setup({
  filetypes = { "sh", "zsh" },
})

-- lua
require("lspconfig").sumneko_lua.setup({
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
})

-- elixir
require("lspconfig").elixirls.setup({})

-- go
require("lspconfig").gopls.setup({})

-- typescript
require("lspconfig").tsserver.setup({
  on_attach = function(client, bufnr)
    -- Use prettier instead for formatting
    client.server_capabilities.documentFormattingProvider = false
  end,
})

-- linters

-- eslint
require("lspconfig").eslint.setup({})

-- diagnostics
-- TODO: add mapping to toggle sign/virtual_text
vim.diagnostic.config({
  virtual_text = true,
  signs = false,
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

-- UI

-- LspSaga
-- TODO: Fix display issue when split is too narrow
require("lspsaga").init_lsp_saga()

-- fidget
-- Show running LSP servers
require("fidget").setup({})
