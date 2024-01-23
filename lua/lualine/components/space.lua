local M = require("lualine.component"):extend()
function M:init(options)
  options = options or {}
  options.icon = options.icon or { "", color = { fg = "Black" } }
  local default_config = {
    command = 'yabai -m query --spaces --space | jq ".index" > %s',
    location = os.tmpname(),
    offset = 9
  }
  self.space_config = vim.tbl_deep_extend('force', default_config, options.space_config or {})
  self:initial_status()
  M.super.init(self, options)
end

function M:initial_status()
  local space_index_location = self.space_config.location
  local command_string = string.gsub(self.space_config.command, "%%s", space_index_location)
  local success = os.execute(command_string)
  if (success) then
    local space_index_file, errmsg = io.open(space_index_location, 'r')
    if space_index_file and not errmsg then
      for line in space_index_file:lines("n") do
        self.space_index = tostring(line - self.space_config.offset)
        break
      end
    end
  end
end

function M:update_status()
  return self.space_index
end

return M
