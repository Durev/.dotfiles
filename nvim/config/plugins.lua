-- Plugins settings

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
require("indent_blankline").setup {
  use_treesitter = true,
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = false,
  use_treesitter_scope = true,
  context_patterns = { "class", "method", "if", "block" },
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
local navic = require("nvim-navic")

require('lualine').setup {
  options = {
    globalstatus = true,
    theme = 'material',
  },
  sections = {
    lualine_c = {
      { 'filename' },
      { navic.get_location, cond = navic.is_available },
    }
  },
}

-- ===== bufferline =====
require("bufferline").setup{
  options = {
    mode = "tabs",
    diagnostics = "nvim_lsp",
    offsets = {{ filetype = "NvimTree", text = "", text_align = "left" }},
    separator_style = "slant",
    show_buffer_close_icons = false,
    always_show_bufferline = false,
    sort_by = "tabs",
  }
}
