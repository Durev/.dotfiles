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

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      on_attach = nvim_tree_on_attach,
      git = {
        enable = true,
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
  end,
}
