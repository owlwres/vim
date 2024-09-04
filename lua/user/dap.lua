local dap = require "dap"
local Path = require 'plenary.path'
local Iterators = require 'plenary.iterators'

dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input('Host [127.0.0.1]: ')
      if value ~= "" then
        return value
      end
      return '127.0.0.1'
    end,
    port = function()
      local value = vim.fn.input('Port: ')
      if value ~= "" then
        return tonumber(value)
      end
      return 8086
    end,
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host, port = config.port })
end

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch',
    name = "Launch file",

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}", -- This configuration will launch the current file if used.
  },
}

dap.adapters.python = {
  type = 'executable',
  command = 'python3',
  args = { '-m', 'debugpy.adapter' },
}

dap.defaults.fallback.external_terminal = {
  command = "/usr/bin/alacritty",
  args = { "-e" },
}

-- dap.defaults.fallback.force_external_terminal = true
-- dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
-- dap.defaults.fallback.focus_terminal = true
-- dap.set_log_level("INFO")

-- depending on your installation location.
local debugger_location = os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2"
local change_directory_to_project_root = function()
  local cwd = vim.fn.getcwd()
  vim.cmd.cd()
  local cwdpath = Path:new(cwd)
  local path_components = cwdpath:_split()
  local tail_component
  for index, value in ipairs(cwdpath:_split()) do
    tail_component = value
  end
  if tail_component == 'src' then
    vim.cmd.cd('..')
  end
end


dap.adapters.node = {
  type = "executable",
  command = "node",
  args = { debugger_location .. "/out/src/nodeDebug.js" },
}

dap.configurations.typescript = {
  {
    name = "Launch Node",
    type = "node",
    request = "launch",
    runtimeArgs = { "-r", "ts-node/register" },
    runtimeExecutable = "node",
    -- args = "${file}",
    -- args = { node_debug_workspace_directory .. "/src/index.ts" },
    args = { "--inspect", "${file}" },
    skipFiles = { "node_modules/**" },

  },
  {
   name = 'Attach to process',
    type = 'node',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  }
}
