local leap = require('leap')
leap.create_default_mappings()
leap.opts.safe_labels = {}
vim.keymap.set('n', 's', function ()
  require('leap').leap { target_windows = { vim.api.nvim_get_current_win() } }
end)

