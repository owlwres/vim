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

" SOURCE CONTROL
Plug 'lewis6991/gitsigns.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'ldelossa/litee.nvim'
Plug 'ldelossa/litee-calltree.nvim'

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

" DEBUGGING
" Plug 'puremourning/vimspector'
Plug 'jbyuki/one-small-step-for-vimkind'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" SNIPPETS
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'

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
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" PANDOC
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" WIKI
Plug 'lervag/wiki.vim'
let g:wiki_root = '~/wiki'

" POMODORO
Plug 'epwalsh/pomo.nvim'

" EASY MOTION
Plug 'phaazon/hop.nvim'
Plug 'ggandor/leap.nvim'
Plug 'ggandor/flit.nvim'
Plug 'ggandor/leap-spooky.nvim'
Plug 'ThePrimeagen/harpoon', {'branch': 'harpoon2'}

" SQLITE
" 
Plug 'kkharji/sqlite.lua',

" TELESCOPE
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-bibtex.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'nvim-telescope/telescope-cheat.nvim'
Plug 'axkirillov/easypick.nvim'
Plug 'jvgrootveld/telescope-zoxide'
Plug 'AckslD/nvim-neoclip.lua'

" TELEKASTEN
" Plug 'renerocksai/telekasten.nvim'
" Plug 'renerocksai/calendar-vim'

" SESSION MANAGEMENT
" Plug 'folke/persistence.nvim'
Plug 'rmagatti/auto-session',

" MISC
Plug 'fmoralesc/vim-extended-autochdir'
Plug 'windwp/nvim-autopairs'
Plug 'MattesGroeger/vim-bookmarks'

call plug#end()

" let g:pandoc"syntax#codeblocks#embeds#langs = ["c", "cs", "csharp=cs", "tex", "scheme"]
" autocmd FileType pandoc :lchdir %:p:h
