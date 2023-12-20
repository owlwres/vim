require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = require('telescope.actions').close,
      }
    },
  },
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		}
	},
	pickers = {
		buffers = {
			mappings = {
				n = {
					["D"] = require('telescope.actions').delete_buffer,
					["<C-a>"] = require('telescope.actions').toggle_all
				}
			}
		},
    registers = {
      mappings = {
				n = {
					["<CR>"] = require('telescope.actions').paste_register,
				}
      }
    }
	}
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('bibtex')
require('telescope').load_extension('fzf')
require'telescope'.load_extension('zoxide')
require('telescope').load_extension('neoclip')

local z_utils = require("telescope._extensions.zoxide.utils")

require("telescope._extensions.zoxide.config").setup({
  -- prompt_title = "[ Walking on the shoulders of TJ ]",
  mappings = {
    -- default = {
    --   after_action = function(selection)
    --     print("Update to (" .. selection.z_score .. ") " .. selection.path)
    --   end
    -- },
    ["<CR>"] = {
      action = function(selection)
        vim.cmd("edit " .. selection.path)
        vim.cmd("lcd " .. selection.path)
      end
    },
  }
})
-- load refactoring Telescope extension
-- require("telescope").load_extension("refactoring")

