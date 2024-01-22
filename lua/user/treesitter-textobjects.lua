require 'nvim-treesitter.configs'.setup {
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["<leader>ts"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>tS"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]r"] = "@call.outer",
        ["]R"] = "@call.inner",
        ["]p"] = "@parameter.outer",
        ["]P"] = "@parameter.inner",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[r"] = "@call.outer",
        ["[R"] = "@call.inner",
        ["[p"] = "@parameter.outer",
        ["[P"] = "@parameter.inner",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ap"] = "@parameter.outer",
      ["ip"] = "@parameter.inner",
      ["ac"] = "@class.outer",
      -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
      ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
    },
    lsp_interop = {
      enable = true,
      -- border = "none",
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
}
