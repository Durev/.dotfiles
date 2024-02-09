-- Key mappings

-- Modes
--   normal mode = n
--   insert mode = i
--   visual mode = v
--   visual block mode = x
--   term mode = t
--   command mode = c

-- Show list of mappings
-- :verbose map / :verbose nnoremap / :verbose vnoremap / :verbose inoremap ...

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Write the file with Ctrl-s
keymap("n", "<C-s>", ":w<cr>", opts)
keymap("i", "<C-s>", "<esc>:w<cr>", opts)
keymap("v", "<C-s>", "<esc>:w<cr>", opts)

-- Move text up and down
-- With French Keyboard, the OS remaps <M-j> to Ï and <M-k> to È
keymap("n", "Ï", ":m .+1<CR>==", opts)
keymap("n", "È", ":m .-2<CR>==", opts)
keymap("v", "Ï", ":m '>+1<CR>gv=gv", opts)
keymap("v", "È", ":m '<-2<CR>gv=gv", opts)
keymap("i", "Ï", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "È", "<Esc>:m .-2<CR>==gi", opts)

----------------------- Normal -----------------------
-- Easy quit
keymap("n", "Q", ":q<cr>", opts)

-- Always jump to first non blank character
keymap("n", "0", "^", opts)

-- Move up and down by visible lines if current line is wrapped
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Switch tab
keymap("n", "<right>", "gt", opts)
keymap("n", "<left>", "gT", opts)

-- Jump to split
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- New split
keymap("n", "vv", "<C-w>v", opts)

-- Resize split with arrows
keymap("n", "<M-Up>", ":resize +2<cr>", opts)
keymap("n", "<M-Down>", ":resize -2<cr>", opts)
keymap("n", "<M-Left>", ":vertical resize -2<cr>", opts)
keymap("n", "<M-Right>", ":vertical resize +2<cr>", opts)

-- Beginning/end of paragraph
keymap("n", "<up>", "{", opts)
keymap("n", "<down>", "}", opts)

-- Follow link in help page / go to tags source
keymap("n", "<C-)>", "<C-}>", opts)

-- LSP
-- go to def
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- go to def in new tab
keymap("n", "gD", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", opts)
-- hover
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

-- not implemented yet
-- keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
-- nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>

-- File search /w Telescope
keymap("n", "<C-p>", "<cmd>Telescope find_files hidden=true<cr>", opts)

----------------------- Insert -----------------------
-- Ain't nobody got time for Esc
keymap("i", "jk", "<esc>", opts)
keymap("i", "kj", "<esc>", opts)

----------------------- Visual -----------------------
-- Stay in indent mode
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)

-- Move up and down by visible lines if current line is wrapped
keymap("v", "j", "gj", opts)
keymap("v", "k", "gk", opts)

-- Jump to last non-whitespace character
keymap("v", "$", "g_", opts)

-- Beginning/end of paragraph
keymap("v", "<up>", "{", opts)
keymap("v", "<down>", "}", opts)

-- ===================== Leader =====================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local which_key = require("which-key")

----------------------- Normal -----------------------
local which_key_n_opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,
  noremap = true,
  nowait = false,
}

-- Find tag
vim.api.nvim_create_user_command("FindTag", function()
  local cword = vim.fn.expand("<cword>")

  require("telescope.builtin").tags({
    default_text = cword,
  })
end, { nargs = 0 })

local n_mappings = {
  g = {
    name = "Git",
    b = { "<cmd>Gitsigns blame_line<cr>", "blame line" },
    d = { "<cmd>DiffviewOpen<cr>", "diff" },
    c = {
      name = "Conflicts",
      l = { "<cmd>GitConflictListQf<cr>", "list" },
      n = { "<cmd>GitConflictNextConflict<cr>", "next" },
      p = { "<cmd>GitConflictPrevConflict<cr>", "previous" },
      o = { "<cmd>GitConflictChooseOurs<cr>", "ours (keep current)" },
      t = { "<cmd>GitConflictChooseTheirs<cr>", "theirs (keep incoming)" },
      b = { "<cmd>GitConflictChooseBoth<cr>", "both (keep all)" },
      z = { "<cmd>GitConflictChooseNone<cr>", "zero (keep none)" },
    },
    h = {
      name = "History",
      b = { "<cmd>DiffviewFileHistory<cr>", "branch" },
      f = { "<cmd>DiffviewFileHistory %<cr>", "file" },
    },
    f = {
      name = "Find (Telescope)",
      c = { "<cmd>Telescope git_commits<cr>", "commits" },
      b = { "<cmd>Telescope git_branches<cr>", "branches" },
      s = { "<cmd>Telescope git_status<cr>", "status" },
    },
    w = {
      name = "Worktrees",
      s = { "<cmd>Telescope git_worktree git_worktrees<cr>", "switch" },
      c = { "<cmd>Telescope git_worktree create_git_worktree<cr>", "create" },
    },
  },
  h = {
    name = "Hunks",
    l = { "<cmd>Gitsigns prev_hunk<cr>", "last" },
    n = { "<cmd>Gitsigns next_hunk<cr>", "next" },
    p = { "<cmd>Gitsigns preview_hunk<cr>", "preview" },
    s = { "<cmd>Gitsigns stage_hunk<cr>", "stage" },
    u = { "<cmd>Gitsigns reset_hunk<cr>", "undo" },
  },
  b = {
    name = "Buffers",
    s = { "<cmd>BufferLineSortByTabs<cr>", "sort" },
  },
  d = {
    name = "Diagnostics",
    f = { "<cmd>Telescope diagnostics<cr>", "find (Telescope)" },
    p = { "<cmd>Lspsaga show_line_diagnostics<cr>", "preview" },
    n = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "next" },
    l = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "last" },
  },
  t = {
    name = "Tests", -- test.vim - save and run specs
    t = { ":w<cr> :TestFile<cr>", "file" },
    l = { ":w<cr> :TestLast<cr>", "last" },
    n = { ":w<cr> :TestNearest<cr>", "nearest" },
    b = { "obinding.break<esc>", "Insert debugger entry point" },
  },
  n = {
    name = "Nvim-Tree",
    t = { ":NvimTreeToggle<cr>", "toggle" },
    f = { ":NvimTreeFindFile<cr>", "toggle" },
  },
  -- Telescope
  f = {
    name = "Find (Telescope)",
    f = { "<cmd>Telescope live_grep<cr>", "Live grep" },
    s = { "<cmd>Telescope grep_string<cr>", "Grep string under cursor" },
    r = { "<cmd>Telescope lsp_references show_line=false<cr>", "LSP references" },
    d = { "<cmd>Telescope lsp_definitions<cr>", "LSP definitions" }, -- go to def or show list if multiple defs
    t = { "<cmd>FindTag<cr>", "Find Tag" },
  },
  l = {
    name = "LSP",
    r = { "<cmd>Lspsaga rename<cr>", "Rename" },
    o = { "<cmd>Format<cr>", "Format" },
  },
  r = {
    name = "Rails",
    l = { "<cmd>lua require('ror.commands').list_commands()<CR>", "List commands" },
    t = {
      name = "Tests",
      t = { "<cmd>lua require('ror.test').run()<CR>", "file" },
      n = { "<cmd>lua require('ror.test').run('Line')<CR>", "nearest" },
      c = { "<cmd>lua require('ror.test').clear()<CR>", "clear" },
    }
  },
  u = { "<cmd>UndotreeToggle<cr> <cmd>UndotreeFocus<cr>", "Undotree" },
  -- Rapid editing/sourcing of init.vim
  ["so"] = { ":source $MYVIMRC<cr>", "source init.vim" },
  ["vr"] = { ":tabnew $MYVIMRC<cr>", "edit init.vim" },
  -- Lazy js
  [";"] = { "m`A;<Esc>``", "Append `;` at eol" },
  [","] = { "m`A,<Esc>``", "Append `,` at eol" },
  -- Code actions
  ["ca"] = { "<cmd>Lspsaga code_action<cr>", "Code Actions" },
  -- Debug
  ["-"] = { "op '🤟' * 50<esc>", "Insert ruby puts" },
}

----------------------- Visual -----------------------
local which_key_v_opts = {
  mode = "v",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local v_mappings = {
  p = { '"_dP', "paste (keep on top)" },
}

which_key.register(n_mappings, which_key_n_opts)
which_key.register(v_mappings, which_key_v_opts)

-- ===================== Plugins defaults =====================
require("codewindow").apply_default_keybinds()
require("leap").set_default_keymaps()
