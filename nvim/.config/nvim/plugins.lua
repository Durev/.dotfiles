-- Plugins settings

-- -- Cool but does not work great
-- -- show_current_context_start = true,
-- -- ===== Indent Blankline =====
-- require("indent_blankline").setup({
--   use_treesitter = true,
--   use_treesitter_scope = true,
--   show_trailing_blankline_indent = false,
--   show_first_indent_level = true,
--   show_current_context = true,
--   show_current_context_start = false,
--   context_patterns = { "class", "method", "if", "block" },
--   filetype_exclude = { "dashboard" }, -- nvim-dashboard
-- })

require("treesitter-context").setup({})

-- -- ===== git-conflict.nvim =====
-- require("git-conflict").setup({
--   default_mappings = false,
--   disable_diagnostics = true,
--   highlights = {
--     incoming = "DiffText",
--     current = "DiffAdd",
--   },
-- })

-- -- ===== vim-illuminate  =====
-- require("illuminate").configure({
--   providers = {
--     -- 'lsp', 'treesitter', 'regex'
--     "regex",
--   },
--   filetypes_denylist = {
--     "NvimTree",
--     "TelescopePrompt",
--     "dashboard",
--   },
-- })

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

require("notify").setup({
  stages = "static",
})

-- vim.notify = require("notify")
--require("notify").setup({
--	---@usage Animation style one of { "fade", "slide", "fade_in_slide_out", "static" }
--	stages = "slide",
--	---@usage Function called when a new window is opened, use for changing win settings/config
--	on_open = nil,
--	---@usage Function called when a window is closed
--	on_close = nil,
--	---@usage timeout for notifications in ms, default 5000
--	timeout = 2000,
--	-- Render function for notifications. See notify-render()
--	render = "default",
--	---@usage highlight behind the window for stages that change opacity
--	background_colour = "Normal",
--	---@usage minimum width for notification windows
--	minimum_width = 50,
--	---@usage notifications with level lower than this would be ignored. [ERROR > WARN > INFO > DEBUG > TRACE]
--	level = "TRACE",
--	---@usage Icons for the different levels
--	icons = {
--		ERROR = icons.diagnostics.Error,
--		WARN = icons.diagnostics.Warning,
--		INFO = icons.diagnostics.Information,
--		DEBUG = icons.ui.Bug,
--		TRACE = icons.ui.Pencil,
--	},
--})

-- -- -- ===== Noice =====
-- require("noice").setup({
--   routes = {
--     {
--       filter = {
--         event = "msg_show",
--         any = {
--           { find = '%d+L, %d+B' },
--           { find = '; after #%d+' },
--           { find = '; before #%d+' },
--           { find = '%d fewer lines' },
--           { find = '%d more lines' },
--           { find = 'yanked' },
--           { find = 'Splitjoin:' },
--         },
--       },
--       opts = { skip = true },
--     },
--   },
-- })
-- -- require("noice").setup({
-- --   views = {
-- --     cmdline_popup = {
-- --       border = {
-- --         style = "none",
-- --         padding = { 2, 3 },
-- --       },
-- --       filter_options = {},
-- --       win_options = {
-- --         winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
-- --       },
-- --     },
-- --   },
-- -- })

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
  change_directory_command = "cd", -- default: "cd",
  -- update_on_change = <boolean> -- default: true,
  -- update_on_change_command = <str> -- default: "e .",
  -- clearjumps_on_change = <boolean> -- default: true,
  -- autopush = <boolean> -- default: false,
})

require("telescope").load_extension("git_worktree")
