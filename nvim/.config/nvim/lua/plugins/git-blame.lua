return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  opts = {
    enabled = false,
    -- message_template = " <summary> • <date> • <author> • <<sha>>",
    date_format = "%m-%d-%Y",
  },
}

-- used in combination with 'lewis6991/gitsigns.nvim'
-- this provides the go to github url
