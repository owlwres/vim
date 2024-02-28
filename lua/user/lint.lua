require('lint').linters_by_ft = {
  markdown = {'vale',},
  -- lua = {'luacheck'},
  rust = {'rstcheck'},
  zsh = {'zsh'},
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
