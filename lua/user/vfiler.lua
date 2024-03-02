require('vfiler/config').setup {
  options = {
    auto_cd = true,
    auto_resize = true,
    keep = true,
    layout = 'none',
    name = 'explorer',
    width = 30,
    columns = 'indent,icon,name',
  },
}

local vfiler = require('vfiler')
local mapopts = { noremap = true, silent = true }
vim.keymap.set({ 'n' }, '-', function() vfiler.start() end, mapopts)
