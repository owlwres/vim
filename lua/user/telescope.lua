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
        ["<c-h>"] = require('telescope.actions').preview_scrolling_left,
        ["<c-l>"] = require('telescope.actions').preview_scrolling_right,
      },
      i = {
        ["<c-c>"] = require('telescope.actions').close,
        ["<c-o>"] = require('telescope.actions').select_default,
        ["<c-t>"] = require('telescope.actions').select_tab,
        ["<c-j>"] = require('telescope.actions').results_scrolling_down,
        ["<c-k>"] = require('telescope.actions').results_scrolling_up,
        ["<c-h>"] = require('telescope.actions').preview_scrolling_left,
        ["<c-l>"] = require('telescope.actions').preview_scrolling_right,
        ["<c-s>"] = require('telescope.actions').complete_tag,
      }
    },
    layout_config = {
      height = 0.95,
      width = .95
    },
  },
  extensions = {
    -- aerial = {
    --   -- Display symbols as <root>.<parent>.<symbol>
    --   show_nesting = {
    --     ["_"] = true, -- This key will be the default
    --     -- json = true,   -- You can set the option for specific filetypes
    --     -- yaml = true,
    --   },
    -- },
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
    -- nnoremap <Leader>bs <cmd>Telescope buffers<cr>
    -- nnoremap <Leader>js <cmd>Telescope jumplist<cr>
    -- nnoremap <Leader>of <cmd>Telescope oldfiles<cr>
    -- nnoremap <Leader>nc <cmd>Telescope neoclip<cr>
    -- nnoremap <Leader>zl <cmd>Telescope zoxide list<cr>
    -- nnoremap <Leader>rj <cmd>Telescope bibtex<cr>
    -- nnoremap <Leader>ch <cmd>Telescope command_history<cr>
    -- nnoremap <Leader>er <cmd>Telescope registers<cr>
    -- nnoremap <Leader>ht <cmd>Telescope help_tags<cr>
    -- nnoremap <Leader>lr <cmd>Telescope lsp_references<cr>
    -- nnoremap <Leader>li <cmd>Telescope lsp_incoming_calls<cr>
    -- nnoremap <Leader>ls <cmd>Telescope lsp_document_symbols<cr>
    -- nnoremap <Leader>lw <cmd>Telescope lsp_workspace_symbols<cr>
    -- nnoremap <Leader>re <cmd>Telescope resume<cr>
    -- nnoremap <Leader>he <cmd>Telescope cheat fd<cr>
    -- nnoremap <Leader>ma <cmd>Telescope macros<cr>
    -- nnoremap <Leader>no <cmd>Telescope noice<cr>
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
-- require("telescope").load_extension("persisted")
require("telescope").load_extension("ui-select")
-- require("telescope").load_extension("aerial")
require("telescope").load_extension("notify")
-- require('telescope').load_extension('possession')

local z_utils = require("telescope._extensions.zoxide.utils")

require("telescope._extensions.zoxide.config").setup({
  -- prompt_title = "[ Walking on the shoulders of TJ ]",
  mappings = {
    -- default = {
    --   after_action = function(selection)
    --     print("Update to (" .. selection.z_score .. ") " .. selection.path)
    --   end
    -- },
    ["<c-o>"] = {
      action = function(selection)
        vim.cmd("edit " .. selection.path)
      end
    },
    ["<c-t>"] = {
      action = function(selection)
        vim.cmd("tabe " .. selection.path)
      end
    },
    ["<CR>"] = {
      action = function(selection)
        vim.cmd("edit " .. selection.path)
      end
    },
  }
})
