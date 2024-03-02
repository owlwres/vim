require("persisted").setup({
  save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
  silent = false,                                                   -- silent nvim message when sourcing session file
  use_git_branch = false,                                           -- create session files based on the branch of a git enabled repository
  default_branch = "main",                                          -- the branch to load if a session file is not found for the current branch
  autosave = true,                                                  -- automatically save session files when exiting Neovim
  should_autosave = nil,                                            -- function to determine if a session should be autosaved
  autoload = false,                                                 -- automatically load the session for the cwd on Neovim startup
  on_autoload_no_session = nil,                                     -- function to run when `autoload = true` but there is no session to load
  follow_cwd = false,                                               -- change session file name to match current working directory if it changes
  allowed_dirs = nil,                                               -- table of dirs that the plugin will auto-save and auto-load from
  ignored_dirs = nil,                                               -- table of dirs that are ignored when auto-saving and auto-loading
  telescope = {
    reset_prompt = true,                                            -- Reset the Telescope prompt after an action?
  }
})

local fp_sep = vim.loop.os_uname().sysname:lower():match("windows") and "\\" or "/" -- \ for windows, mac and linux both use \

function get_session_filename(session)
  local config = require('persisted.config')
  local save_dir = config.options.save_dir
  local session_filename = save_dir .. session .. '.vim'
  return session_filename
end

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
      if (session_exists(value)) then
        vim.notify('Session already exists', vim.log.levels.ERROR)
        return
      end
      local session_name = get_session_filename(value)
      local opts = { session = session_name }
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
  --
  --- @type session[]
  local existing_sessions = require('persisted').list()
  local filtered_sessions = vim.tbl_filter(
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
  vim.g.persisted_loaded_session = opts.session
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
