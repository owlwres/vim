-- vim.api.nvim_create_autocmd({"VimEnter"}, {
--   callback = function()
--     require("persistence").load({ last = true })
--   end
-- })

vim.api.nvim_create_autocmd({"TermEnter"}, {
  callback = function()
    local buffer = vim.fn.bufnr(vim.fn.expand("%"))
    vim.api.nvim_buf_set_keymap(buffer, 't', '<C-n>', '<C-c>nvrr<cr>', {})
    vim.api.nvim_buf_set_keymap(buffer, 'n', '<C-n>', '<cmd>startinsert<cr><C-n>', {})
  end
})


vim.api.nvim_create_autocmd({"FileType"}, {
  callback = function()
    -- vim.api.nvim_command(":")
  end
})
