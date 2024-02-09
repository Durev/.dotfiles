-- Plugins settings

-- ===== gitsigns =====
require("gitsigns").setup({
  signs = {
    delete = { hl = "GitSignsDelete", text = "▸" },
    changedelete = { hl = "GitSignsChange", text = "│▸" },
  },
  preview_config = {
    -- Options passed to nvim_open_win
    border = "none",
    style = "minimal",
    -- relative = 'cursor',
    -- row = 0,
    -- col = 1,
  },
})

-- ===== better-escape =====
require("better_escape").setup({
  mapping = { "jk", "kj" },
})

-- ===== nvim-tree =====
local function nvim_tree_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Default mappings.
  api.config.mappings.default_on_attach(bufnr)

  -- Custom Mappings
  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

require("nvim-tree").setup({
  on_attach = nvim_tree_on_attach,
  git = {
    enable = false,
  },
  renderer = {
    icons = {
      symlink_arrow = " ➛ ",
      show = {
        folder = false,
      },
    },
  },
  actions = {
    open_file = {
      resize_window = true,
      quit_on_open = true,
      window_picker = {
        enable = false,
      },
    },
  },
})

-- Cool but does not work great
-- show_current_context_start = true,
-- ===== Indent Blankline =====
require("indent_blankline").setup({
  use_treesitter = true,
  use_treesitter_scope = true,
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
  show_current_context = true,
  show_current_context_start = false,
  context_patterns = { "class", "method", "if", "block" },
  filetype_exclude = { "dashboard" }, -- nvim-dashboard
})

-- ===== Telescope =====
local tl_actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-n>"] = tl_actions.cycle_history_next,
        ["<C-p>"] = tl_actions.cycle_history_prev,
        ["<C-j>"] = tl_actions.move_selection_next,
        ["<C-k>"] = tl_actions.move_selection_previous,
        ["<C-h>"] = tl_actions.which_key,
        ["<C-s>"] = tl_actions.select_horizontal,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--hidden",
      "-g",
      "!{.git/,tags}", -- excluded folders and files
      -- "--color=never",
      "--no-heading",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "  ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--hidden", "--type", "file", "-E", ".git" },
    },
  },
})

-- TODO: Find alternative to the additional_vim_regex_highlighting option
-- setting this to false breaks vim-endwise and vim-ruby
-- cf. https://github.com/nvim-treesitter/nvim-treesitter/issues/703
-- alternative for vim-endwise: https://github.com/RRethy/nvim-treesitter-endwise
-- ===== Treesitter =====
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "dockerfile",
    "elixir",
    "gitignore",
    "glimmer",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "pug",
    "ruby",
    "scss",
    "sql",
    "typescript",
    "vim",
    "xml",
    "yaml",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = false },
})

require("treesitter-context").setup({})

require("lualine").setup({
  options = {
    globalstatus = true,
    theme = "material",
  },
  sections = {
    lualine_c = {
      {
        "filename",
        file_status = true, -- Displays file status (readonly status, modified status)
        newfile_status = false, -- Display new file status (new file means no write after created)
        path = 1, -- 0: Just the filename
        shorting_target = 40, -- Shortens path to leave 40 spaces in the window
      },
    },
    lualine_y = {}, -- Hide progress %
  },
})

-- ===== bufferline =====
require("bufferline").setup({
  options = {
    mode = "tabs",
    diagnostics = "nvim_lsp",
    offsets = { { filetype = "NvimTree", text = "", text_align = "left" } },
    separator_style = "thin",
    show_buffer_close_icons = false,
    always_show_bufferline = false,
    sort_by = "tabs",
    color_icons = true,
    show_tab_indicators = false,
  },
})

-- ===== dashboard-nvim =====
local dashboard = require("dashboard")

local dashboard_header = {
  "            .:                :.            ",
  "          .---:.              :--.          ",
  "        .-----::.             :===-.        ",
  "      .----------:            :=====-.      ",
  "    .::-----------:           :=======-.    ",
  "    ::::------------.         -========:    ",
  "    :::::------------:        -========:    ",
  "    ::::::------------:       -========:    ",
  "    :-------------------.     -========:    ",
  "    :--------..----------:    -========:    ",
  "    :--------.  -----------   -========:    ",
  "    :--------.   :----------. -========:    ",
  "    :--------.    .----------:-========:    ",
  "    :--------.      ----------=========:    ",
  "    :--------.       :--------=========-    ",
  "    :--------.        .-------====+++++-    ",
  "    :--------.         .------=====++++-    ",
  "     :-------.           :----======+=:     ",
  "       :-----.            .---======:       ",
  "         :-==.             .--====:         ",
  "           :-.               -==:           ",
}

local update_plugins = function()
  vim.cmd([[
  let s:filepath = $DOTFILES . '/nvim/snapshots/plugins_snapshop_' . strftime('%Y-%m-%d-%H:%M:%S') . '.vim'

  execute ':PlugSnapshot 's:filepath''

  execute ':PlugUpdate'
  ]])
end

dashboard.custom_center = {
  {
    icon = "🔍  ",
    icon_hl = { fg = "#c7d8ff" },
    desc = "Find file     ",
    action = "Telescope find_files hidden=true",
  },
  {
    icon = "🔤  ",
    icon_hl = { fg = "#c7d8ff" },
    desc = "Find word     ",
    action = "Telescope live_grep",
  },
  {
    icon = "📄  ",
    icon_hl = { fg = "#c7d8ff" },
    desc = "New file      ",
    action = "enew",
  },
  {
    icon = "🕣  ",
    icon_hl = { fg = "#c7d8ff" },
    desc = "Recent files  ",
    action = "Telescope oldfiles",
  },
  {
    icon = "💾  ",
    icon_hl = { fg = "#c7d8ff" },
    desc = "Last session  ",
    action = "SessionLoad",
  },
  {
    icon = "📡  ",
    icon_hl = { fg = "#c7d8ff" },
    desc = "Update plugins",
    action = update_plugins,
  },
  -- Link to LSP Installer / Mason?
}

dashboard.custom_header = dashboard_header
dashboard.custom_footer = { (vim.fn.getcwd():gsub("/Users/vincent.durewski", "")) }
dashboard.hide_statusline = true
dashboard.hide_tabline = true
dashboard.header_pad = 1
dashboard.center_pad = 3
dashboard.footer_pad = 3
-- Sessions
dashboard.session_directory = string.format("%s/nvim/sessions", os.getenv("DOTFILES"))
dashboard.session_auto_save_on_exit = true

-- ===== git-conflict.nvim =====
require("git-conflict").setup({
  default_mappings = false,
  disable_diagnostics = true,
  highlights = {
    incoming = "DiffText",
    current = "DiffAdd",
  },
})

-- ===== true-zen  =====
require("true-zen").setup({})

-- ===== vim-illuminate  =====
require("illuminate").configure({
  providers = {
    -- 'lsp', 'treesitter', 'regex'
    "regex",
  },
  filetypes_denylist = {
    "NvimTree",
    "TelescopePrompt",
    "dashboard",
  },
})

-- ===== leap  =====
require("leap").setup({
  case_sensitive = true,
})

-- ===== flit  =====
require("flit").setup({})

-- ===== codewindow  =====
require("codewindow").setup({})

-- ===== nvim-web-devicons  =====
-- override dev icons
-- https://github.com/nvim-tree/nvim-web-devicons/blob/master/lua/nvim-web-devicons.lua
-- https://www.nerdfonts.com/cheat-sheet
require("nvim-web-devicons").set_icon({
  rb = {
    icon = "",
    color = "#e74c3c",
    name = "Rb",
  },
  erb = {
    icon = "",
    color = "#e74c3c",
    name = "Erb",
  },
  ["config.ru"] = {
    icon = "",
    color = "#e74c3c",
    name = "ConfigRu",
  },
  rakefile = {
    icon = "",
    color = "#e74c3c",
    name = "Rakefile",
  },
  rake = {
    icon = "",
    color = "#e74c3c",
    name = "Rake",
  },
  ["dockerfile"] = {
    icon = "",
    color = "#458ee6",
    cterm_color = "68",
    name = "Dockerfile",
  },
  ["docker-compose.yml"] = {
    icon = "",
    color = "#458ee6",
    cterm_color = "68",
    name = "Dockerfile",
  },
})

-- ===== nvim-notify =====
vim.notify = require("notify")

-- ===== dressing =====
require("dressing").setup({
  input = {
    min_width = { 60, 0.9 },
  },
})

-- ===== ror.nvim =====
require("ror").setup({
  test = {
    notification = {
      timeout = false,
    },
    pass_icon = "✅",
    fail_icon = "❌",
  },
})

-- ===== ThePrimeagen =====
-- ===== git-worktree =====
require("git-worktree").setup({
    change_directory_command = "cd" -- default: "cd",
    -- update_on_change = <boolean> -- default: true,
    -- update_on_change_command = <str> -- default: "e .",
    -- clearjumps_on_change = <boolean> -- default: true,
    -- autopush = <boolean> -- default: false,
})

require("telescope").load_extension("git_worktree")
