local M = require("lualine.component"):extend()
function M:init(options)
  options = options or {}
  -- options.icon = options.icon or { "", color = { fg = "black" } }
  M.super.init(self, options)
end

local function get_session()
  return require('possession.session').get_session_name() or ''
end
function M:initial_status()
  return get_session()
end
function M:update_status()
  return get_session()
end

return M
