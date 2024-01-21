local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  -- LIGHTLINE
  -- 'itchyny/lightline.vim',
  -- { 'tsuyoshicho/StatuslineUpdateTimer.vim', commit ='08b1560bd3578492404adcd7bb8cbcb004b5c9c9'},


  -- THEME
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme github_dark_dimmed')
    end
  },

  -- LUALINE
  'nvim-lualine/lualine.nvim',

  -- TPOPE
  'tpope/vim-eunuch',
  'tpope/vim-sensible',
  'tpope/vim-surround',
  'tpope/vim-fugitive',
  'tpope/vim-vinegar',
  'tpope/vim-commentary',
  'tpope/vim-dadbod',
  'tpope/vim-repeat',

  -- FILESYSTEM
  -- 'stevearc/oil.nvim',

  -- SOURCE CONTROL
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'user.gitsigns'
    end
  },

  'sindrets/diffview.nvim',

  -- TASK MANAGEMENT
  'stevearc/overseer.nvim',

  -- ERGONOMICS
  'fedepujol/move.nvim',
  {
    'gaoDean/autolist.nvim',
    config = function()
      require 'user.autolist'
    end
  },


  -- PRIVACY
  -- 'laytan/cloak.nvim',

  -- BUFFERS MANAGEMENT
  -- Plug 'axkirillov/hbac.nvim'
  -- lua << EOF
  --  require("hbac").setup({
  --   autoclose     = true, -- set autoclose to false if you want to close manually
  --   threshold     = 10, -- hbac will start closing unedited buffers once that number is reached
  --   close_command = function(bufnr)
  --     vim.api.nvim_buf_delete(bufnr, {})

  --   close_buffers_with_windows = false, -- hbac will close buffers with associated windows if this option is `true`
  --   telescope = {
  --     -- See #telescope-configuration below
  --     },
  -- })
  -- EOF

  -- LSP
  {
    'neovim/nvim-lspconfig',
    config = function()
      require 'user.lsp' ({})
    end
  },
  'hinell/lsp-timeout.nvim',

  -- TREESITTER
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'user.treesitter'
    end,
    dependencies = {
      'nvim-treesitter/playground',
    }
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require 'user.treesitter-context'
    end
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require 'user.treesitter-textobjects'
    end
  },

  -- ORG MODE
  {
    'nvim-orgmode/orgmode',
    config = function()
      require 'user.orgmode'
    end
  },

  -- COMPLETION
  {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    config = function()
      require 'user.coq'
    end,
    dependencies = {
      { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
    }
  },

  -- DEVELOPMENT
  'folke/neodev.nvim',
  'bfredl/nvim-luadev',

  -- DEBUGGING
  -- Plug 'puremourning/vimspector'
  {
    'mfussenegger/nvim-dap',
    config = function()
      require 'user.dap'
    end
  },
  {
    'rcarriga/nvim-dap-ui',
    config = function()
      require 'user.dap-ui'
    end
  },
  'jbyuki/one-small-step-for-vimkind',

  -- SNIPPETS
  -- follow latest release and install jsregexp.
  -- 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'} " Replace <CurrentMajor> by the latest released major (first number of latest release),
  -- 'benfowler/telescope-luasnip.nvim',

  -- MACRO
  -- 'ecthelionvi/NeoComposer.nvim',
  {
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify", -- optional
    opts = {},                          -- required even with default settings, since it calls `setup()`
  },

  -- TEX
  -- vim.g.tex_flavor='latex'
  -- vim.g.vimtex_view_method='zathura',
  -- vim.g.vimtex_quickfix_mode=0,
  -- conceallevel=1,
  -- vim.g.tex_conceal='abdmg' ,
  -- 'lervag/vimtex',


  -- PANDOC
  'vim-pandoc/vim-pandoc',
  'vim-pandoc/vim-pandoc-syntax',

  -- WIKI
  {
    'lervag/wiki.vim',
    config = function()
      vim.g.wiki_root = '~/wiki'
    end,
  },

  -- POMODORO
  {
    'epwalsh/pomo.nvim',
    config = function()
      require 'user.pomo'
    end
  },

  -- EASY MOTION
  -- 'phaazon/hop.nvim'
  -- 'folke/flash.nvim',
  {
    'ggandor/leap.nvim',
    lazy = false,
    config = function()
      require 'user.leap'
    end
  },

  {
    'ggandor/leap-spooky.nvim',
    lazy = false,
    config = function()
      require 'user.leap-spooky'
    end
  },

  {
    'ggandor/flit.nvim',
    lazy = false,
    config = function()
      require 'user.flit'
    end
  },
  { 'ThePrimeagen/harpoon', branch = 'harpoon2' },


  -- TEXT OBJECTS
  'wellle/targets.vim',

  -- SQLITE
  'kkharji/sqlite.lua',

  -- SQL
  {
    'mzarnitsa/psql',
    config = function()
      require 'user.psql'
    end
  },

  -- TELESCOPE
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    config = function()
    end,
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-bibtex.nvim',
      'nvim-telescope/telescope-cheat.nvim',
      {
        'axkirillov/easypick.nvim',
        config = function()
          require 'user.easypick'
        end
      },
      'jvgrootveld/telescope-zoxide',
      'AckslD/nvim-neoclip.lua',
    }
  },



  -- SESSION MANAGEMENT
  -- 'folke/persistence.nvim',
  -- 'rmagatti/auto-session',,
  {
    'olimorris/persisted.nvim',
    config = function()
      require 'user.persisted'
    end
  },


  -- MISC
  'fmoralesc/vim-extended-autochdir',
  'windwp/nvim-autopairs'
})
