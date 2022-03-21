-- Configure language servers

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
require'lspconfig'.solang.setup{
  cmd = { "solang", "--language-server", "--target", "ewasm" }
}

-- JS linting
-- require'lspconfig'.eslint.setup{}
