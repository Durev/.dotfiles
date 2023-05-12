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
    "lua_ls",
    "solargraph",
    "tsserver",
    -- "ruby_ls", -- To check: Shopify ruby-lsp - still misses a lot of features so far
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
require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
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

---------- UI ----------

-- LspSaga
-- TODO: Fix display issue when split is too narrow
require("lspsaga").setup({
  symbol_in_winbar = {
    enable = false,
  },
})

-- fidget
-- Show running LSP servers
require("fidget").setup({})
