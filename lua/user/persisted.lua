require("persisted").setup()

function prompt_new_session()
  local Input = require("nui.input")
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
        top = "[Session Name]",
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
      if (session_exists(value)) then
        vim.notify('Session already exists', vim.log.levels.ERROR)
        return
      end
      local opts = { session = value }
      session_save(opts)
      session_begin(opts)
    end,
    on_change = nil
  })

  session_input:mount()
end

--- @class session
--- @field name string
--- @field dir_path string
--- @field file_path string
--- @field branch string

--- @param session_name string
function session_exists(session_name)
  local functional = require('plenary.functional')
  --
  --- @type session[]
  local existing_sessions = require('persisted').list()
  local filtered_sessions = functional.kv_map(
    function(existing_session)
      if (existing_session.name == session_name) then
        return existing_session
      else
        return nil
      end
    end,
    existing_sessions)
  -- vim.notify(vim.inspect(filtered_sessions))
  -- vim.notify(vim.inspect(#filtered_sessions))
  if (#filtered_sessions ~= 0) then
    return true
  else
    return false
  end
end

function session_begin(opts)
  require('persisted').start(opts)
  vim.g.persisting_session = opts.session
end

function session_save(opts)
  require('persisted').save(opts)
end

local mapopts = {
  silent = true,
  noremap = true,
  desc = 'prompt new session'
}

vim.keymap.set({ 'n' }, '<leader>sn', prompt_new_session, mapopts)
