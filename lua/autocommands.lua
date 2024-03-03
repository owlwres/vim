local netrw_serialization_augroup = vim.api.nvim_create_augroup("netrw_serialization_augroup", { clear = true })
vim.api.nvim_create_autocmd('filetype', {
  group = netrw_serialization_augroup,
  pattern = 'netrw',
  callback = function()
  end
})
vim.api.nvim_create_autocmd('BufReadPre', {
  group = netrw_serialization_augroup,
  -- pattern = 'window',
  callback = function()
    local current_window_id = vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_get_option(current_window_id, 'filetype') == 'netrw' then
      vim.notify('buffer entered')
      -- vim.api.nvim_buf_set_name(win_bufid, '.')
      -- vim.fn.execute('Explore')
    end
  end
})
