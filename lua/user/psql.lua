require('psql').setup({
  database_name       = 'postgres',
  execute_line        = '<leader>e',
  execute_selection   = '<leader>e',
  execute_paragraph   = '<leader>r',

  close_latest_result = '<leader>w',
  close_all_results   = '<leader>W',
})
