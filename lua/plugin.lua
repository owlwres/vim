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
  -- ERGONOMICS
  -- 'fedepujol/move.nvim',
  -- {
  --   'nvim-tree/nvim-tree.lua',
  --   config = function()
  --     require 'user.tree'
  --   end,
  --   dependencies = {
  --     'nvim-tree/nvim-web-devicons'
  --   }
  -- },
  -- {
  --   'obaland/vfiler.vim',
  --   config = function()
  --     require 'user.vfiler'
  --   end
  -- },
  {
    'prichrd/netrw.nvim',
    config = function()
      require('user.netrw')
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    'nvim-focus/focus.nvim',
    config = function()
      require 'user.focus'
    end,
    version = false
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require 'user.autopairs'
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  -- {
  --   'gaoDean/autolist.nvim',
  --   config = function()
  --     require 'user.autolist'
  --   end
  -- },

  -- LUALINE
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   config = function() require 'user.lualine' end
  -- },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "meuter/lualine-so-fancy.nvim",
    },
    opts = {
      options = {
        theme = 'github_dark_dimmed',
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        refresh = {
          statusline = 100,
        },
      },
      sections = {
        lualine_a = {
          { "fancy_mode", width = 3 }
        },
        lualine_b = {
          { "session" },
          { "fancy_branch" },
          { "fancy_diff" },
        },
        lualine_c = {
          { "fancy_cwd", substitute_home = true }
        },
        lualine_x = {
          { "fancy_macro" },
          { "fancy_diagnostics" },
          { "fancy_searchcount" },
          { "fancy_location" },
        },
        lualine_y = {
          { "fancy_filetype", ts_icon = "" },
          { "fancy_lsp_servers" },
        },
        lualine_z = {
          { "time" },
          { "space" },
        },
      }
    },
  },

  -- TPOPE
  'tpope/vim-eunuch',
  'tpope/vim-sensible',
  -- 'tpope/vim-surround',
  -- 'tpope/vim-fugitive',
  -- 'tpope/vim-vinegar',
  'tpope/vim-commentary',
  'tpope/vim-dadbod',
  'tpope/vim-repeat',

  -- FILESYSTEM
  -- 'stevearc/oil.nvim',

  -- SOURCE CONTROL
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      require 'user.neogit'
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'user.gitsigns'
    end
  },

  -- TASK MANAGEMENT
  {
    'stevearc/overseer.nvim',
    config = function()
      require 'user.overseer'
    end,
    opts = {},
  },


  -- PRIVACY
  -- 'laytan/cloak.nvim',

  -- BUFFERS MANAGEMENT
  -- {
  --   'axkirillov/hbac.nvim',
  --   config = function()
  --     require("hbac").setup({
  --       autoclose                  = true, -- set autoclose to false if you want to close manually
  --       threshold                  = 10,   -- hbac will start closing unedited buffers once that number is reached
  --       close_command              = function(bufnr)
  --         vim.api.nvim_buf_delete(bufnr, {})
  --       end,
  --       close_buffers_with_windows = false, -- hbac will close buffers with associated windows if this option is `true`
  --       telescope                  = {
  --         -- See #telescope-configuration below
  --       },
  --     })
  --   end
  -- },

  -- TABS
  {
    'LukasPietzschmann/telescope-tabs',
    config = function()
      require('telescope').load_extension 'telescope-tabs'
      require('telescope-tabs').setup {
        -- Your custom config :^)
      }
    end,
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  {
    'nanozuki/tabby.nvim',
    event = 'VimEnter',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require 'user.tabby'
    end,
  },

  -- DEVELOPMENT
  -- 'bfredl/nvim-luadev',

  -- LSP
  -- {
  --   'ray-x/navigator.lua',
  --   config = function()
  --         require'user.navigator'
  --   end,
  --   dependencies = {
  --     {
  --       'ray-x/guihua.lua',
  --       build = 'cd lua/fzy && make'
  --     },
  --     { 'neovim/nvim-lspconfig' },
  --   },
  -- },

  {
    'stevearc/aerial.nvim',
    config = function()
      require 'user.aerial'
    end,
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require 'user.lsp' ()
    end,
    dependencies = {
      -- 'hinell/lsp-timeout.nvim',
      {
        'folke/neodev.nvim',
        config = true
        -- opts = {}
        -- config = function()
        --   require 'user.neodev'
        -- end
      },
    },
  },

  'Hoffs/omnisharp-extended-lsp.nvim',

  -- LINTING
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('user.lint')
    end
  },
  -- TREESITTER
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require 'user.treesitter-textobjects'
    end,
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter',
        config = function()
          require 'user.treesitter'
        end,
      },
    }
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    lazy = false,
    config = function()
      require 'user.treesitter-context'
    end,
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter',
        config = function()
          require 'user.treesitter'
        end,
      },
    }
  },



  -- ORG MODE
  -- {
  --   'nvim-orgmode/orgmode',
  --   config = function()
  --     require 'user.orgmode'
  --   end
  -- },

  -- COMPLETION
  -- {
  --   'ms-jpq/coq_nvim',
  --   branch = 'coq',
  --   config = function()
  --     require 'user.coq'
  --   end,
  --   dependencies = {
  --     {
  --       'ms-jpq/coq.thirdparty',
  --       config = function()
  --         require("coq_3p") {
  --           { src = "nvimlua", short_name = "nLUA" }
  --         }
  --       end
  --     }
  --   }
  -- },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require 'user.cmp'
    end,
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { 'tzachar/fuzzy.nvim' },
      { "tzachar/cmp-fuzzy-buffer" },
      { "tzachar/cmp-fuzzy-path" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-document-symbol" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "dmitmel/cmp-cmdline-history" },
      { "FelipeLema/cmp-async-path" },
      { "neovim/nvim-lspconfig" },
      { "L3MON4D3/LuaSnip" },
      { "L3MON4D3/cmp-luasnip-choice" },
      { "saadparwaiz1/cmp_luasnip" },
      { "petertriho/cmp-git" },
      { "lukas-reineke/cmp-rg" },
      {
        'doxnit/cmp-luasnip-choice',
        config = function()
          require('cmp_luasnip_choice').setup({
            auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
          })
        end
      },

      -- { "hrsh7th/cmp-path" },
      -- { "simrat39/rust-tools.nvim" },
    }
  },


  -- DEBUGGING
  -- Plug 'puremourning/vimspector'
  {
    'rcarriga/nvim-dap-ui',
    config = function()
      require 'user.dap-ui'
    end,
    dependencies = {
      {
        'mfussenegger/nvim-dap',
        config = function()
          require 'user.dap'
        end,
      },
    }
  },
  {
    'jbyuki/one-small-step-for-vimkind',
    lazy = true
  },

  -- MACRO
  -- 'ecthelionvi/NeoComposer.nvim',
  {
    "chrisgrieser/nvim-recorder",
    config = function()
      require 'user.recorder'
    end
  },

  -- SNIPPETS
  -- follow latest release and install jsregexp.

  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function(_, opts)
      require 'user.luasnip' (opts)
    end,
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
  -- {
  --   'epwalsh/pomo.nvim',
  --   config = function()
  --     require 'user.pomo'
  --   end
  -- },

  -- EASY MOTION
  -- 'phaazon/hop.nvim'
  -- 'folke/flash.nvim',
  {
    'ggandor/leap-spooky.nvim',
    lazy = false,
    config = function()
      require 'user.leap-spooky'
    end,
    dependencies = {
      {
        'ggandor/leap.nvim',
        config = function()
          require 'user.leap'
        end
      },
    }
  },

  {
    'ggandor/flit.nvim',
    lazy = false,
    config = function()
      require 'user.flit'
    end,
    dependencies = {
      {
        'ggandor/leap.nvim',
        config = function()
          require 'user.leap'
        end
      },
    }
  },


  -- { 'ThePrimeagen/harpoon', branch = 'harpoon2' },


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

  -- TASK: marks
  -- TELESCOPE
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    config = function()
      require('user.telescope')
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
  -- 'rmagatti/auto-session',
  {
    'jedrzejboczar/possession.nvim',
    config = function()
      require 'user.possession'
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  -- {
  --   'olimorris/persisted.nvim',
  --   config = function()
  --     require 'user.persisted'
  --   end
  -- },
  -- NOTIFICATIONS
  -- {
  --   'rcarriga/nvim-notify',
  --   config = function() require 'user.notify' end
  -- },
  {
    'folke/noice.nvim',
    event = "VeryLazy",
    config = function() require 'user.noice' end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      {
        'rcarriga/nvim-notify',
        config = function() require 'user.notify' end
      },
    }
  },
  -- {
  --   "cbochs/grapple.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  -- },

  -- MISC
  'fmoralesc/vim-extended-autochdir',
})

require('scratch'):setup()
