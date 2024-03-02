local M = require("lualine.component"):extend()
function M:init(options)
  options = options or {}
  -- options.icon = options.icon or { "", color = { fg = "Black" } }
  local default_config = {
    command = 'yabai -m query --spaces --space | jq ".index"',
    offset = 9
  }
  self.space_config = vim.tbl_deep_extend('force', default_config, options.space_config or {})
  self:initial_status()
  M.super.init(self, options)
end

function M:initial_status()
  local popen_result_file, errmsg = io.popen(self.space_config.command)
  if popen_result_file and not errmsg then
    for line in popen_result_file:lines("n") do
      self.space_index = tostring(line - self.space_config.offset)
      break
    end
  end
end

function M:update_status()
  return self.space_index
end

return M
