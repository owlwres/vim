require 'nvim-treesitter.configs'.setup
{
  --   -- A list of parser names, or "all"
  ensure_installed = {
    "typescript", "haskell", "fennel", "lua", "python", "rust", "vim", "vimdoc", "markdown", "markdown_inline", "regex", "bash", "c_sharp"
  },

  --   -- Install parsers synchronously ()
  sync_install = false,

  highlight = {
    enable = true,
    disable = { "markdown" }
  }
  --   -- Automatically install missing parsers when entering buffer
  -- auto_install = true,

  --   -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  --   ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

}
