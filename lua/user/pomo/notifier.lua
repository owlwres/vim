local PrintNotifier = {};

PrintNotifier.new = function(timer, opts)
  local self = vim.setmetatable({}, { __index = PrintNotifier })
  self.timer = timer
  self.hidden = false
  self.opts = opts -- not used
  return self
end

PrintNotifier.start = function(self)
  print(string.format("Starting timer #%d, %s, for %ds", self.timer.id, self.timer.name, self.timer.time_limit))
end

PrintNotifier.tick = function(self, time_left)
  if not self.hidden then
    print(string.format("Timer #%d, %s, %ds remaining...", self.timer.id, self.timer.name, time_left))
  end
end

PrintNotifier.done = function(self)
  print(string.format("Timer #%d, %s, complete", self.timer.id, self.timer.name))
end

PrintNotifier.stop = function(self) end

PrintNotifier.show = function(self)
  self.hidden = false
end

PrintNotifier.hide = function(self)
  self.hidden = true
end
-- ```

-- And then in the `notifiers` field of your **pomo.nvim** config, you'd add the following entry:

-- ```lua
-- { init = PrintNotifier.new, opts = {} }
-- ```
