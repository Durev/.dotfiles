-- Plugins settings

-- ===== nvim-cmp =====
local cmp = require'cmp'

local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

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
    { name = 'nvim_lua' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'cmp_tabnine' },
    { name = 'path' },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[Nvim lua]",
        vsnip = "[Snippet]",
        buffer = "[Buffer]",
        cmp_tabnine = "[Tabnine]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
})

-- ===== Tabnine setup =====
require('cmp_tabnine').setup({
  max_lines = 1000;
  max_num_results = 5;
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

-- TODO: Find alternative to the additional_vim_regex_highlighting option
-- setting this to false breaks vim-endwise and vim-ruby
-- cf. https://github.com/nvim-treesitter/nvim-treesitter/issues/703
-- alternative for vim-endwise: https://github.com/RRethy/nvim-treesitter-endwise
-- ===== Treesitter =====
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "ruby", "lua", "bash", "elixir", "html", "vim", "javascript", "json" },
  sync_install = false,
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
}

-- ===== lualine =====
require('lualine').setup {
  options = {
    globalstatus = true,
    theme = 'material',
  },
}
