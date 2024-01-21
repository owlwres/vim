call plug#begin()

" LIGHTLINE
Plug 'itchyny/lightline.vim'
Plug 'tsuyoshicho/StatuslineUpdateTimer.vim', {'commit': '08b1560bd3578492404adcd7bb8cbcb004b5c9c9'}

" THEME
Plug 'projekt0n/github-nvim-theme'

" TPOPE
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-repeat'

" FILESYSTEM
" Plug 'stevearc/oil.nvim'

" SOURCE CONTROL
Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'

" TASK MANAGEMENT
Plug 'stevearc/overseer.nvim'

" ERGONOMICS
Plug 'fedepujol/move.nvim'
Plug 'gaoDean/autolist.nvim'


" PRIVACY
" Plug 'laytan/cloak.nvim'

" BUFFERS MANAGEMENT
" Plug 'axkirillov/hbac.nvim'
" lua << EOF
"  require("hbac").setup({
"   autoclose     = true, -- set autoclose to false if you want to close manually
"   threshold     = 10, -- hbac will start closing unedited buffers once that number is reached
"   close_command = function(bufnr)
"     vim.api.nvim_buf_delete(bufnr, {})
"
"   close_buffers_with_windows = false, -- hbac will close buffers with associated windows if this option is `true`
"   telescope = {
"     -- See #telescope-configuration below
"     },
" })
" EOF

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hinell/lsp-timeout.nvim'

" TREESITTER
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'


" ORG MODE
Plug 'nvim-orgmode/orgmode'

" COMPLETION
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}


" TEX
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg' 

" DEVELOPMENT
Plug 'folke/neodev.nvim'
Plug 'bfredl/nvim-luadev'

" DEBUGGING
" Plug 'puremourning/vimspector'
Plug 'jbyuki/one-small-step-for-vimkind'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" SNIPPETS
" follow latest release and install jsregexp.
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'} " Replace <CurrentMajor> by the latest released major (first number of latest release)
Plug 'benfowler/telescope-luasnip.nvim'

" MACRO
" Plug 'ecthelionvi/NeoComposer.nvim'
Plug 'chrisgrieser/nvim-recorder'

lua << EOF
-- default values
require("recorder").setup {
	-- Named registers where macros are saved (single lowercase letters only).
	-- The first register is the default register used as macro-slot after
	-- startup.
	slots = { "a", "b" },

	mapping = {
		startStopRecording = "q",
		playMacro = "Q",
		switchSlot = "<C-q>",
		editMacro = "cq",
		deleteAllMacros = "dq",
		yankMacro = "yq",
		-- ⚠️ this should be a string you don't use in insert mode during a macro
		addBreakPoint = "##",
	},

	-- Clears all macros-slots on startup.
	clear = false,

	-- Log level used for any notification, mostly relevant for nvim-notify.
	-- (Note that by default, nvim-notify does not show the levels `trace` & `debug`.)
	logLevel = vim.log.levels.INFO,

	-- If enabled, only critical notifications are sent.
	-- If you do not use a plugin like nvim-notify, set this to `true`
	-- to remove otherwise annoying messages.
	lessNotifications = false,

	-- Use nerdfont icons in the status bar components and keymap descriptions
	useNerdfontIcons = true,

	-- Performance optimzations for macros with high count. When `playMacro` is
	-- triggered with a count higher than the threshold, nvim-recorder
	-- temporarily changes changes some settings for the duration of the macro.
	performanceOpts = {
		countThreshold = 100,
		lazyredraw = true, -- enable lazyredraw (see `:h lazyredraw`)
		noSystemClipboard = true, -- remove `+`/`*` from clipboard option
		autocmdEventsIgnore = { -- temporarily ignore these autocmd events
			"TextChangedI",
			"TextChanged",
			"InsertLeave",
			"InsertEnter",
			"InsertCharPre",
		},
	},

	-- [experimental] partially share keymaps with nvim-dap.
	-- (See README for further explanations.)
	dapSharedKeymaps = false,
}
EOF

" TEX
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg' 

" DEBUGGING
" Plug 'puremourning/vimspector'
" Plug 'jbyuki/one-small-step-for-vimkind'
" Plug 'mfussenegger/nvim-dap'
" Plug 'rcarriga/nvim-dap-ui'

" SNIPPETS
" Plug 'SirVer/ultisnips'
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" PANDOC
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" WIKI
Plug 'lervag/wiki.vim'
let g:wiki_root = '~/wiki'

" POMODORO
Plug 'epwalsh/pomo.nvim'

" EASY MOTION
" Plug 'phaazon/hop.nvim'
Plug 'ggandor/leap.nvim'
Plug 'ggandor/leap-spooky.nvim'
Plug 'ggandor/flit.nvim'
Plug 'ThePrimeagen/harpoon', {'branch': 'harpoon2'}
" Plug 'folke/flash.nvim'


" TEXT OBJECTS
Plug 'wellle/targets.vim'

" SQLITE
Plug 'kkharji/sqlite.lua'

" SQL
Plug 'mzarnitsa/psql'

" TELESCOPE
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'nvim-telescope/telescope-bibtex.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
" Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'nvim-telescope/telescope-cheat.nvim'
Plug 'axkirillov/easypick.nvim'
Plug 'jvgrootveld/telescope-zoxide'
Plug 'AckslD/nvim-neoclip.lua'

" TELEKASTEN
" Plug 'renerocksai/telekasten.nvim'
" Plug 'renerocksai/calendar-vim'

" SESSION MANAGEMENT
" Plug 'folke/persistence.nvim'
" Plug 'rmagatti/auto-session',
Plug 'olimorris/persisted.nvim'


" MISC
Plug 'fmoralesc/vim-extended-autochdir'
Plug 'windwp/nvim-autopairs'
" Plug 'MattesGroeger/vim-bookmarks'


call plug#end()

" let g:pandoc"syntax#codeblocks#embeds#langs = ["c", "cs", "csharp=cs", "tex", "scheme"]
" autocmd FileType pandoc :lchdir %:p:h
