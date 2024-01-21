vim.cmd [[

" GENERAL CONFIGURATION
let mapleader = ";"      
let maplocalleader = ";"
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

" set conceallevel=2
" set concealcursor="nc"
" set formatoptions="jcql"

" let g:netrw_liststyle=3

" REGISTERS
nn <C-s> "*
vn <C-s> "*

" TERMINAL MODE

tnoremap <C-w>h <C-\><C-N><C-w>h
tnoremap <C-w>j <C-\><C-N><C-w>j
tnoremap <C-w>k <C-\><C-N><C-w>k
tnoremap <C-w>l <C-\><C-N><C-w>l
tnoremap <C-w>N <C-\><C-N>

" COMPLETION

set completeopt=menu,menuone,noselect

]]

require('plugin')
require('autocommands')
require('keymappings')
