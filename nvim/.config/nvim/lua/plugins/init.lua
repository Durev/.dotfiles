return {
  { "kaicataldo/material.vim" },
  { "tpope/vim-commentary" },
  { "tpope/vim-repeat" },
  { "tpope/vim-dispatch" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-surround" },
  { "tpope/vim-rails" },
  { "vim-ruby/vim-ruby" },
  { "Raimondi/delimitMate" }, -- needs to be loaded before vim-endwise
  { "tpope/vim-endwise" },
  { "tomlion/vim-solidity" },
  { "AndrewRadev/splitjoin.vim" },
  { "sickill/vim-pasta" },
  -- { 'lewis6991/gitsigns.nvim' },
  { "vim-test/vim-test" },
  -- { "lukas-reineke/indent-blankline.nvim",    version = "2.20.8" }, -- TODO: Unpin and finish v3 update
  { "nvim-treesitter/nvim-treesitter-context" },
  { "elixir-editors/vim-elixir" },
  { "akinsho/git-conflict.nvim",              version = "*" },
  -- { 'RRethy/vim-illuminate' },
  { "folke/which-key.nvim" },
  { "wellle/targets.vim" },
  { "sindrets/diffview.nvim" },
  { "gorbit99/codewindow.nvim" },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  { "mechatroner/rainbow_csv" },
  { "mbbill/undotree" },
  { "rcarriga/nvim-notify" },  -- used by ror
  { "stevearc/dressing.nvim" }, -- used by ror
  { "weizheheng/ror.nvim" },
  { "ThePrimeagen/git-worktree.nvim" },
  { "MunifTanjim/nui.nvim" },
  -- { "folke/noice.nvim" },
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },
  { "tpope/vim-abolish" },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Custom text objects
  {
    "kana/vim-textobj-user",
    dependencies = { "nelstrom/vim-textobj-rubyblock" },
  },

  -- LSP, completion & AI stuff
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
    },
  },
  { "glepnir/lspsaga.nvim",           version = "main" },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "zbirenbaum/copilot.lua" }, -- using lua rewrite
  { "zbirenbaum/copilot-cmp" }, -- so I can plug it to cmp
  { "CopilotC-Nvim/CopilotChat.nvim", version = "canary" },

  -- Snippets
  { "L3MON4D3/LuaSnip",               version = "v1.*" },
  { "saadparwaiz1/cmp_luasnip" },
  { "rafamadriz/friendly-snippets" },
}
