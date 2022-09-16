local wk = require("which-key")

-- TODO: Add default options

wk.register(
  {
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
      -- b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
    },
    h = {
      name = "Hunks",
      l = { "<cmd>Gitsigns prev_hunk<cr>", "last" },
      n = { "<cmd>Gitsigns next_hunk<cr>", "next" },
      p = { "<cmd>Gitsigns preview_hunk<cr>", "preview" },
      s = { "<cmd>Gitsigns stage_hunk<cr>", "stage" },
      u = { "<cmd>Gitsigns reset_hunk<cr>", "undo" },
    },
  },
  { prefix = "<leader>" }
)
