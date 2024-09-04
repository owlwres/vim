require 'nvim-treesitter.configs'.setup
---@diagnostic disable-next-line: missing-fields
    {
      --   -- A list of parser names, or "all"
      ensure_installed =
      {
        "c", "haskell", "fennel", "lua", "python", "rust", "vim", "regex", "bash", "c_sharp", "markdown", "markdown_inline", "typescript"
      },

      --   -- Install parsers synchronously ()
      sync_install = false,
      textobjects = {
        enable = true
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      highlight = {
        enable = true,
        disable = function(lang, bufnr)
          return vim.api.nvim_buf_get_option(bufnr, 'filetype') == 'pandoc'
        end,
      },
      --   -- Automatically install missing parsers when entering buffer
      auto_install = true,

      --   -- List of parsers to ignore installing ()
      -- ignore_install = { "javascript" },

      --   ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
      -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    }
