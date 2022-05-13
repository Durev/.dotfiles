-- Language servers config

-- LSP debugging
-- vim.lsp.set_log_level("debug")

-- ruby LS
require'lspconfig'.solargraph.setup{
  settings = {
    solargraph = {
      diagnostics = true,
      completion = true
    }
  }
}

-- bash LS
require'lspconfig'.bashls.setup{
  filetypes = { "sh", "zsh" }
}

-- solidity LS
require'lspconfig'.solang.setup{
  cmd = { "solang", "--language-server", "--target", "ewasm" }
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

-- JS linting
-- require'lspconfig'.eslint.setup{}
