-- Plugins settings

-- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      -- For vsnip user.
      { name = 'vsnip' },
    }
  })

vim.lsp.set_log_level("debug")

-- Configure language servers (to extract)
require'lspconfig'.solargraph.setup{
    settings = {
        solargraph = {
            diagnostics = false,
            completion = true
        }
    }
}
