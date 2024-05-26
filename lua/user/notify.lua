local notify = require('notify')
local render = require('notify.render')
local default_renderer = notify.render
vim.notify = require("notify")

-- 'default'
-- 'compact'
-- 'minimal'
-- 'simple'
-- 'wrapped-compact'
---@param buf integer
---@param notification notify.Record
---@param highlights notify.Highlights
---@param config table
local gate_render = function(buf, notification, highlights, config)
 render.default(buf, notification, highlights, config)
end

require("notify").setup({
  background_colour = "NotifyBackground",
  fps = 30,
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = ""
  },
  level = 2,
  minimum_width = 50,
  render = gate_render,
  stages = "fade",
  time_formats = {
    notification = "%T",
    notification_history = "%FT%T"
  },
  timeout = 5000,
  top_down = true
})


