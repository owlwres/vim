local M = {}
M.after_load_netrw = function(name, user_data)
  local buffers = vim.api.nvim_list_bufs()
  local current_tab_id = vim.api.nvim_get_current_tabpage()
  local current_window_id = vim.api.nvim_get_current_win()
  local tabs = vim.api.nvim_list_tabpages()
  for index, tabid in ipairs(tabs) do
    -- vim.schedule(function()
    local success = pcall(vim.api.nvim_set_current_tabpage, tabid)
    if success then
      -- handle netrw windows
      local netrw_windows = vim.tbl_filter(function(winid)
        local win_bufid = vim.api.nvim_win_get_buf(winid)
        return vim.api.nvim_buf_get_option(win_bufid, 'filetype') == 'netrw'
      end, vim.api.nvim_tabpage_list_wins(tabid))
      for index, winid in ipairs(netrw_windows) do
        local success = pcall(vim.api.nvim_set_current_win, winid)
        if success then
          vim.fn.execute('e .')     -- .. buffer_name)
          vim.fn.execute('set bl')
        end
      end
      -- handle terminal windows
      local terminal_windows = vim.tbl_filter(function(winid)
        local win_bufid = vim.api.nvim_win_get_buf(winid)
        local bufname = vim.fn.bufname(win_bufid)
        return string.match(bufname, '^term') ~= nil
        -- return vim.api.nvim_buf_get_option(win_bufid, 'filetype') == 'zsh'
      end, vim.api.nvim_tabpage_list_wins(tabid))
      for index, winid in ipairs(terminal_windows) do
        local success = pcall(vim.api.nvim_set_current_win, winid)
        if success then
          local bufnr = vim.api.nvim_win_get_buf(winid)
          vim.notify('found terminal buffer')
          vim.fn.execute('set ma')
          vim.api.nvim_buf_set_lines(bufnr, -2, -1, false, { 'a', 'a', 'a' })
        end
      end
    end
    -- end)
  end
  pcall(vim.api.nvim_set_current_tabpage, current_tab_id)
  pcall(vim.api.nvim_set_current_win, current_window_id)
end
local function get_leftmost_window()
end
local function get_rightmost_window()
end
M.after_load_journal = function(name, user_data)
  if name == 'journal' then

  end
end
return M

