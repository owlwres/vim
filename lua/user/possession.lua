local Path = require('plenary.path')
require('possession').setup {
  session_dir = (Path:new(vim.fn.stdpath('data')) / 'possession'):absolute(),
  silent = false,
  load_silent = true,
  debug = false,
  logfile = false,
  prompt_no_cr = false,
  autosave = {
    current = true,  -- or fun(name): boolean
    tmp = false,      -- or fun(): boolean
    tmp_name = 'tmp', -- or fun(): string
    on_load = true,
    on_quit = true,
  },
  commands = {
    save = 'PossessionSave',
    load = 'PossessionLoad',
    rename = 'PossessionRename',
    close = 'PossessionClose',
    delete = 'PossessionDelete',
    show = 'PossessionShow',
    list = 'PossessionList',
    migrate = 'PossessionMigrate',
  },
  hooks = {
    before_save = function(name)
      return {}
      -- local netrw_buffers = {}
      -- local buffers = vim.api.nvim_list_bufs()
      -- for index, bufnr in ipairs(buffers) do
      --   local buffer_type = vim.api.nvim_buf_get_option(bufnr, 'filetype')
      --   local buffer_name = vim.fn.bufname(bufnr)
      --   if buffer_type == 'netrw' then
      --     vim.api.nvim_set_current_buf(bufnr)
      --     vim.schedule(function()
      --       local winnr = vim.api.nvim_get_current_win()
      --       local tabnr = vim.api.nvim_get_current_tabpage()
      --       vim.fn.execute('cd')
      --       vim.notify(tostring(winnr) .. ' ' .. tostring(tabnr) .. vim.fn.getcwd())
      --       table.insert(netrw_buffers, bufnr)
      --     end)
      --   end
      -- end
      -- return {
      --   netrw_buffers = netrw_buffers
      -- }
    end,
    after_save = function(name, user_data, aborted) end,
    before_load = function(name, user_data) return user_data end,
    after_load = function(name, user_data)
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
              vim.fn.execute('e .') -- .. buffer_name)
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
              vim.api.nvim_buf_set_lines(bufnr, -2, -1, false, {'a','a','a'})
            end
          end
        end
        -- end)
      end
      pcall(vim.api.nvim_set_current_tabpage, current_tab_id)
      pcall(vim.api.nvim_set_current_win, current_window_id)
    end,
  },
  plugins = {
    close_windows = {
      hooks = { 'before_save', 'before_load' },
      preserve_layout = true, -- or fun(win): boolean
      match = {
        floating = true,
        buftype = {},
        filetype = {},
        custom = false, -- or fun(win): boolean
      },
    },
    delete_hidden_buffers = false,
    -- delete_hidden_buffers = {
    --   hooks = {
    --     'before_load',
    --     vim.o.sessionoptions:match('buffer') and 'before_save',
    --   },
    --   force = false,       -- or fun(buf): boolean
    -- },
    nvim_tree = false,
    neo_tree = false,
    symbols_outline = false,
    tabby = false,
    dap = true,
    dapui = true,
    neotest = true,
    delete_buffers = false,
  },
  telescope = {
    previewer = {
      enabled = true,
      previewer = 'pretty', -- or 'raw' or fun(opts): Previewer
      wrap_lines = true,
      include_empty_plugin_data = false,
      cwd_colors = {
        cwd = 'Comment',
        tab_cwd = { '#cc241d', '#b16286', '#d79921', '#689d6a', '#d65d0e', '#458588' }
      }
    },
    list = {
      default_action = 'load',
      mappings = {
        save = { n = '<c-x>', i = '<c-x>' },
        load = { n = '<c-v>', i = '<c-v>' },
        delete = { n = '<c-t>', i = '<c-t>' },
        rename = { n = '<c-r>', i = '<c-r>' },
      },
    },
  },
}

function prompt_new_session()
  local Input = require('nui.input')
  local event = require("nui.utils.autocmd").event

  local popup_options = {
    relative = "cursor",
    position = {
      row = 1,
      col = 0,
    },
    size = 20,
    border = {
      style = "rounded",
      text = {
        top = "[New Session Name]",
        top_align = "left",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal",
    },
  }

  local session_input = Input(popup_options, {
    prompt = "> ",
    on_close = nil,
    on_submit = function(value)
      vim.fn.execute('PossessionSave ' .. value)
    end,
    on_change = nil
  })

  session_input:mount()
end

local mapopts = {
  silent = true,
  noremap = true,
  desc = 'prompt new session'
}
vim.keymap.set('n', '<leader>sn', prompt_new_session, mapopts)
vim.keymap.set('n', '<leader>su', '<cmd>PossessionSave!<cr>', mapopts)
vim.keymap.set('n', '<leader>sl', '<cmd>PossessionLoad<cr>', mapopts)
vim.keymap.set('n', '<leader>sj', '<cmd>Telescope possession list<cr>', mapopts)
