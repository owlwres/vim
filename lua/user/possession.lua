local Path = require('plenary.path')
require('possession').setup {
  session_dir = (Path:new(vim.fn.stdpath('data')) / 'possession'):absolute(),
  silent = false,
  load_silent = true,
  debug = false,
  logfile = false,
  prompt_no_cr = false,
  autosave = {
    current = true,   -- or fun(name): boolean
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
      require('user.possession-handler').before_save_netrw(name)
      return {}
    end,
    after_save = function(name, user_data, aborted)
      -- require('user.possession-handler').after_save_netrw(name, user_data)
    end,
    before_load = function(name, user_data)
      return user_data
    end,
    after_load = function(name, user_data)
      require('user.possession-handler').after_load_netrw(name, user_data)
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
    delete_hidden_buffers = true,
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
-- vim.keymap.set('n', '<leader>sn', '<cmd>PossessionSave! 1<cr>', mapopts)
vim.keymap.set('n', '<leader>su', '<cmd>PossessionSave!<cr>', mapopts)
vim.keymap.set('n', '<leader>sl', '<cmd>PossessionLoad<cr>', mapopts)
vim.keymap.set('n', '<leader>sj', '<cmd>Telescope possession list<cr>', mapopts)
