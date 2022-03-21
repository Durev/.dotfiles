-- Plugins settings

-- ===== nvim-cmp =====
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
      ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'cmp_tabnine' },
      -- For vsnip user.
      { name = 'vsnip' },
    }
})

-- ===== LSP debugging =====
-- vim.lsp.set_log_level("debug")

-- ===== Tabnine setup =====
local tabnine = require('cmp_tabnine.config')
tabnine:setup({
  max_lines = 1000;
  max_num_results = 20;
  sort = true;
  run_on_every_keystroke = true;
  snippet_placeholder = '..';
  ignored_file_types = {};
})

-- ===== ToggleTerm =====
require("toggleterm").setup{
  open_mapping = [[<C-t>]],
  direction = 'float',
  float_opts = {
    border = 'curved',
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}

-- ===== gitsigns =====
require('gitsigns').setup {
  signs = {
    delete = { hl = 'GitSignsDelete', text = '▸' },
  },
}
