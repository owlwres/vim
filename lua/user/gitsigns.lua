require('gitsigns').setup({
  on_attach = function(bufnr)
    -- if vim.api.nvim_buf_get_name(bufnr):match(<PATTERN>) then
    --   -- Don't attach to specific buffers whose name matches a pattern
    --   return false
    -- end

    -- Setup keymaps
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gs', '<cmd>lua require"gitsigns".stage_hunk()<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua require"gitsigns".reset_hunk()<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gh', '<cmd>lua require"gitsigns".preview_hunk()<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gn', '<cmd>lua require"gitsigns".next_hunk()<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gp', '<cmd>lua require"gitsigns".prev_hunk()<CR>', {})
  end
})

