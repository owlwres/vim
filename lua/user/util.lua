-- yank file contents to clipboard

function file_exists(filename)
  local path = require('plenary.path')
  return path.exists(filename)
end

function yank_file_to_clipboard(filename)
  local path = require('plenary.path')
  local file = path:new(filename)
  local data = file:read()
  vim.fn.setreg("", data)
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
      if (not file_exists(value)) then
        vim.notify('File does not exist', vim.log.levels.ERROR)
        return
      end
      local opts = { session = value }
      yank_file_to_clipboard(opts)
    end,
    on_change = nil
  })

  session_input:mount()
end


local mapopts  = {
  silent = true,
  noremap = true
}

vim.keymap.set({'n'}, '<leader>yf', prompt_yanked_filename, mapopts)


