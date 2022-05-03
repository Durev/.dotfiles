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

-- ===== Tabnine setup =====
require('cmp_tabnine').setup({
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
    border = 'none',
    winblend = 5,
    highlights = {
      border = "Normal",
      background = "Pmenu",
    }
  }
}

-- ===== gitsigns =====
require('gitsigns').setup {
  signs = {
    delete = { hl = 'GitSignsDelete', text = '▸' },
    changedelete = { hl = 'GitSignsChange', text = '│▸' },
  },
}

-- ===== better-escape =====
require("better_escape").setup {
  mapping = {"jk", "kj"},
}

-- ===== nvim-tree =====
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

local nvim_tree_mapping = {
  { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
  { key = "h", cb = tree_cb "close_node" },
  { key = "v", cb = tree_cb "vsplit" },
  { key = "s", cb = tree_cb "split" },
  { key = "?", cb = tree_cb "toggle_help" },
}

require'nvim-tree'.setup {
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  git = {
    enable = false,
  },
  view = {
    mappings = {
      custom_only = false,
      list = nvim_tree_mapping,
    },
  },
}

-- ===== Indent Blankline =====
-- TODO: Enrich with treesitter data
require("indent_blankline").setup {
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_current_context = false,
  show_current_context_start = false,
}

-- ===== Telescope =====
local tl_actions = require "telescope.actions"

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-n>"] = tl_actions.cycle_history_next,
        ["<C-p>"] = tl_actions.cycle_history_prev,
        ["<C-j>"] = tl_actions.move_selection_next,
        ["<C-k>"] = tl_actions.move_selection_previous,
        ["<C-h>"] = tl_actions.which_key,
        ["<C-s>"] = tl_actions.select_horizontal,
      }
    }
  },
}
