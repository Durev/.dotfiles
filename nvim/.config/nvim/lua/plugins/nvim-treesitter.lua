-- TODO: Find alternative to the additional_vim_regex_highlighting option
-- setting this to false breaks vim-endwise and vim-ruby
-- cf. https://github.com/nvim-treesitter/nvim-treesitter/issues/703
-- alternative for vim-endwise: https://github.com/RRethy/nvim-treesitter-endwise

return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
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
        -- TODO
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
        -- disable for large files
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = { enable = false },
    })
  end,
}
