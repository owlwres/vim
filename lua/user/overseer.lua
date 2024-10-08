-- setup
--
local overseer = require('overseer')
overseer.setup({
  templates = { "builtin", "user.run_script" },
  log = {
    {
      type = "file",
      filename = "overseer.log",
      level = vim.log.levels.DEBUG, -- or TRACE for max verbosity
    },
  },
})

-- autocommands
--
vim.api.nvim_create_user_command("WatchRun", function()
  local overseer = require("overseer")
  overseer.run_template({ name = "run script" }, function(task)
    if task then
      task:add_component({ "restart_on_save", paths = {vim.fn.expand("%:p")} })
      local main_win = vim.api.nvim_get_current_win()
      overseer.run_action(task, "open vsplit")
      vim.api.nvim_set_current_win(main_win)
    else
      vim.notify("WatchRun not supported for filetype " .. vim.bo.filetype, vim.log.levels.ERROR)
    end
  end)
end, {})
