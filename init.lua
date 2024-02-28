vim.cmd [[

" GENERAL CONFIGURATION
let g:mapleader = ";"      
let g:maplocalleader = ";"
set cmdheight=0
set runtimepath+=~/work/mod/a
set ts=2 sw=2
set expandtab
set ignorecase
set smartcase
set number
set relativenumber
set cursorline
set virtualedit=all
set shada=!,'1000,<50,s10,h
set splitkeep=screen

inoremap jk <ESC>
nnoremap <C-q> :qa!<CR>
cmap <C-k> <up>
cmap <C-j> <down>
cmap <C-h> <S-left>
cmap <C-l> <S-right>

" SESSIONS / TABS
set showtabline=2
set sessionoptions=blank,buffers,curdir,folds,globals,help,tabpages,terminal,winsize


set conceallevel=3

" set formatoptions="jcql"

" set concealcursor="nc"

" let g:netrw_liststyle=3

" SAVING
nn <C-s> <cmd>w<cr>
ino <C-s> <cmd>w<cr>
vn <C-s> <cmd>w<cr>

" TERMINAL MODE

tnoremap <C-w>h <C-\><C-N><C-w>h
tnoremap <C-w>j <C-\><C-N><C-w>j
tnoremap <C-w>k <C-\><C-N><C-w>k
tnoremap <C-w>l <C-\><C-N><C-w>l

" COMPLETION

" set completeopt=menu,menuone,noselect

]]

require('plugin')
require('autocommands')
require('keymappings')
require('util')
