local which_key = require("which-key")

------ Normal ------
local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,
  noremap = true,
  nowait = false,
}

local mappings = {
    g = {
      name = "Git",
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
      b = { "<cmd>Gitsigns blame_line<cr>", "blame line" },
    },
    h = {
      name = "Hunks",
      l = { "<cmd>Gitsigns prev_hunk<cr>", "last" },
      n = { "<cmd>Gitsigns next_hunk<cr>", "next" },
      p = { "<cmd>Gitsigns preview_hunk<cr>", "preview" },
      s = { "<cmd>Gitsigns stage_hunk<cr>", "stage" },
      u = { "<cmd>Gitsigns reset_hunk<cr>", "undo" },
    },
  }

------ Visual ------
local v_opts = {
  mode = "v",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local v_mappings = {
  p = { "\"_dP", "paste (keep on top)" },
}

which_key.register(mappings, opts)
which_key.register(v_mappings, v_opts)
