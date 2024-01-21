local leap = require('leap')
leap.set_default_keymaps()
leap.opts.safe_labels = {}
vim.keymap.set('n', 's', function ()
  require('leap').leap { target_windows = { vim.api.nvim_get_current_win() } }
end)

