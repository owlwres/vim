local easypick = require("easypick")
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local base_branch = "develop"

local function zoxaddcd(template)
	return function(prompt_bufnr, _)
		actions.select_default:replace(function()
			actions.close(prompt_bufnr)
			local selection = action_state.get_selected_entry()
			local count = select(2, string.gsub(template, "%%s", ""))
			if count ~= 1 then
				vim.notify("String does not have exactly one %s placeholder", vim.log.levels.ERROR)
				return false
			end
      local cur_pwd = vim.fn.getcwd()
      local actual_selection = cur_pwd .. '/' .. selection[1]
      vim.cmd('!zoxide add ' .. actual_selection)
			vim.cmd(string.format(template, actual_selection))
      -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      vim.cmd([[
        call feedkeys("\<CR>")
      ]])
		end)
		return true
	end
end

easypick.setup({

	pickers = {
		-- add your custom pickers here
		-- below you can find some examples of what those can look like

		-- list files inside current folder with default previewer
		{
    -- name for your custom picker, that can be invoked using :Easypick <name> (supports tab completion)
			name = "foldersbelow",
			-- the command to execute, output has to be a list of plain text entries
			command = "fd -t directory -H .",
      action = zoxaddcd('edit %s'),
			-- specify your custom previwer, or use one of the easypick.previewers
			previewer = easypick.previewers.default()
		},

		-- diff current branch with base_branch and show files that changed with respective diffs in preview
		{
			name = "changed_files",
			command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
			previewer = easypick.previewers.branch_diff({base_branch = base_branch})
		},

		-- list files that have conflicts with diffs in preview
		{
			name = "conflicts",
			command = "git diff --name-only --diff-filter=U --relative",
			previewer = easypick.previewers.file_diff()
		},
	}
})
