-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
-- vim.opt.termguicolors = true

local function toggle_replace()
  local api = require("nvim-tree.api")
  if api.tree.is_visible() then
    api.tree.change_root_to_parent()
  else
    api.node.open.replace_tree_buffer({ winid = vim.api.nvim_get_current_win() })
  end
end
local function change_root_to_global_cwd()
  local api = require("nvim-tree.api")
  local global_cwd = vim.fn.getcwd(-1, -1)
  api.tree.change_root(global_cwd)
end

local function edit_or_open()
  local api = require("nvim-tree.api")
  local node = api.tree.get_node_under_cursor()


  if node.nodes ~= nil then
    -- expand or collapse folder
    api.tree.change_root(node.absolute_path)
    -- api.node.open.edit()
  else
    -- open file
    api.node.open.replace_tree_buffer()
    -- api.node.open.edit()
    -- Close the tree if file was opened
    -- api.tree.close()
  end
end

-- open as vsplit on current node
local function vsplit_preview()
  local api = require("nvim-tree.api")
  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    -- expand or collapse folder
    api.node.open.edit()
  else
    -- open file as vsplit
    api.node.open.vertical()
  end

  -- Finally refocus on tree if it was lost
  api.tree.focus()
end
local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '-', toggle_replace, opts('Vinegar'))
  vim.keymap.set('n', 'o', edit_or_open, opts('Open'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
  -- vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
  -- vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
  -- vim.keymap.set("n", "h", api.tree.close, opts("Close"))
  -- vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))

  -- unmappings
  --
  vim.keymap.del('n', 's', { buffer = bufnr })
end

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  on_attach = on_attach
})
