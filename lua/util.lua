local path = require('plenary.path')
-- yank file contents to clipboard

function file_exists(filename)
  local path = require('plenary.path')
  local expanded_filename = path.expand({ filename = filename })
  local yanked_path = path:new(expanded_filename)
  return yanked_path:exists(), yanked_path
end

--- @param path Path
function yank_path(path)
  local data = path:read()
  vim.fn.setreg("*", data)
end

function prompt_yanked_filename()
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
        top = "[Yanked filename]",
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
      exists, yanked_path = file_exists(value)
      if (not exists) then
        vim.notify('File does not exist', vim.log.levels.ERROR)
        return
      end
      yank_path(yanked_path)
    end,
    on_change = nil
  })

  session_input:mount()
end

local mapopts = {
  silent = true,
  noremap = true
}

vim.keymap.set({ 'n' }, '<leader>yf', prompt_yanked_filename, mapopts)
