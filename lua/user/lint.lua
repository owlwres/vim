require('lint').linters_by_ft = {
  markdown = { 'vale', },
  lua = { 'luacheck' },
  -- rust = { 'rstcheck' },
  zsh = { 'zsh' },
}

local luacheck = require('lint').linters.luacheck
luacheck.args = {
  '--std',
  'luajit',
  '--globals',
  'vim'
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
