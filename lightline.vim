let g:StatuslineUpdateTimer#clockformat = "%a %b %d %H:%M %Y"
let g:StatuslineUpdateTimer#interval_function = function('lightline#update')
let g:lightline = {
\ 'colorscheme': 'nord',
\ 'active': {
\   'left': [ [ 'mode', 'paste'],
\             [ 'readonly', 'filename', 'modified', ] ],
\   'right': [
\     ['clock'],
\     ['percent','lineinfo'],
\     ['fileformat', 'fileencoding', 'filetype'],
\   ]
\ },
\ 'component_function': {
\		'clock': 'StatuslineUpdateTimer#clock'
\ },
\ }
