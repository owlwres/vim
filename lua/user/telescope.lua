require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = require('telescope.actions').close,
        ["<c-c>"] = require('telescope.actions').close,
        ["<c-o>"] = require('telescope.actions').select_default,
        ["<c-t>"] = require('telescope.actions').select_tab,
        ["<c-j>"] = require('telescope.actions').results_scrolling_down,
        ["<c-k>"] = require('telescope.actions').results_scrolling_up,
      },
      i = {
        ["<c-c>"] = require('telescope.actions').close,
        ["<c-o>"] = require('telescope.actions').select_default,
        ["<c-t>"] = require('telescope.actions').select_tab,
        ["<c-j>"] = require('telescope.actions').results_scrolling_down,
        ["<c-k>"] = require('telescope.actions').results_scrolling_up,
      }
    },
    layout_config = {
      height = 0.95,
      width = .95
    },
  },
  extensions = {
    aerial = {
      -- Display symbols as <root>.<parent>.<symbol>
      show_nesting = {
        ["_"] = true, -- This key will be the default
        -- json = true,   -- You can set the option for specific filetypes
        -- yaml = true,
      },
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      },
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      }
    },
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
require('telescope').load_extension('zoxide')
require('telescope').load_extension('neoclip')
-- require("telescope").load_extension "frecency"
require("telescope").load_extension("cheat")
require("telescope").load_extension("persisted")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("aerial")
require("telescope").load_extension("notify")

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
