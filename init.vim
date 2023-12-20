" GENERAL CONFIGURATION

set ts=2 sw=2 
set expandtab
set ignorecase
set smartcase
set number
set relativenumber
set cursorline
set virtualedit=all
inoremap jk <ESC>
nnoremap <C-q> :qa!<CR>
set conceallevel=2
set concealcursor="nc"
set formatoptions="jcql"
" let g:netrw_liststyle= 3

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

" MODULES

lua << EOF

local config_file = vim.call('eval', '$MYVIMRC')
local config_directory = vim.fs.dirname(config_file)

vim.cmd.source(config_directory .. '/lightline.vim')
vim.cmd.source(config_directory .. '/plug.vim')

require('plugins')
require('autocommands')
require('keymappings')
                
EOF
