local Path = require('plenary.path')
local mapopts = {
  noremap = true,
  silent = true
}

---@class ScratchConfig
---@field storage Path
local M = {}
function M:setup(config)
  config = config or {}
  local default_settings = {
    storage_directory = 'scratch',
    storage_filename = '01.lua',
  }
  config = vim.tbl_deep_extend('force', default_settings, config)
  self:init(config)
end

function M:init(config)
  self.storage = Path:new(vim.fn.stdpath('data'), config.storage_directory, config.storage_filename)

end

function M:open()
  -- vim.notify(self.storage.filename)
  vim.cmd.tabnew(self.storage.filename)
end

M:setup()
-- print(vim.inspect(M))
-- vim.notify(vim.inspect(M))

return M

