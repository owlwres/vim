-- leadghr
local keymap = vim.api.nvim_set_keymap
local mapopts = { noremap = true, silent = true }

-- netrw integration

vim.cmd [[

	augroup netrw_mapping
			au!
			autocmd filetype netrw call NetrwMapping()
	augroup END

	function! NetrwMapping()
			nnoremap <buffer> <C-n> <Plug>NetrwLcd<cmd>term<CR>i
      nnoremap <buffer> <Leader>sd <Plug>NetrwLcd<cmd>Easypick foldersbelow<cr>
      let s_mapping = maparg("s", "n", 0, 1)
      let S_mapping = maparg("S", "n", 0, 1)
      if s_mapping.buffer != 0
        nunmap <buffer> s
      end
      if S_mapping.buffer != 0
        nunmap <buffer> S
      end
	endfunction

]]

-- telescope
--
vim.keymap.set("n", "<leader>ff", function()
  local builtin = require('telescope.builtin')
  local utils = require('telescope.utils')
  builtin.find_files({
    cwd = utils.buffer_dir()
  })
end)

vim.keymap.set("n", "<leader>fj", function()
  local builtin = require('telescope.builtin')
  local utils = require('telescope.utils')
  builtin.live_grep({
    cwd = utils.buffer_dir()
  })
end)


vim.cmd [[
	nnoremap <c-f> <cmd>Telescope current_buffer_fuzzy_find<cr>
	nnoremap <Leader>bs <cmd>Telescope buffers<cr>
	nnoremap <Leader>of <cmd>Telescope oldfiles<cr>
	nnoremap <Leader>nc <cmd>Telescope neoclip<cr>
  nnoremap <Leader>zl <cmd>Telescope zoxide list<cr>
  nnoremap <Leader>rj <cmd>Telescope bibtex<cr>
  nnoremap <Leader>ch <cmd>Telescope command_history<cr>
  nnoremap <Leader>er <cmd>Telescope registers<cr>
  nnoremap <Leader>ht <cmd>Telescope help_tags<cr>
  nnoremap <Leader>lr <cmd>Telescope lsp_references<cr>
  nnoremap <Leader>li <cmd>Telescope lsp_incoming_calls<cr>
  nnoremap <Leader>ls <cmd>Telescope lsp_document_symbols<cr>
  nnoremap <Leader>re <cmd>Telescope resume<cr>
  nnoremap <Leader>he <cmd>Telescope cheat fd<cr>
  nnoremap <Leader>ma <cmd>Telescope macros<cr>
]]


-- coq
vim.cmd([[
  nno <Leader>sn <cmd>COQsnips edit<cr>
  nno <Leader>sb <cmd>COQsnips compile<cr><c-c>
]])


-- motion
vim.cmd [[
	nnoremap <Leader>hg <cmd>HopWord<cr>
	nnoremap <Leader>hf <cmd>HopPattern<cr>
	nnoremap <Leader>hj <cmd>HopLine<cr>
  vnoremap <Leader>hg <cmd>HopWord<cr>
  vnoremap <Leader>hf <cmd>HopPattern<cr>
  vnoremap <Leader>hj <cmd>HopLine<cr>
]]

-- easypick
  --
vim.cmd [[
   nnoremap <leader>sd <cmd>cd %:p:h<cr><cmd>Easypick foldersbelow<cr>
   nnoremap <Leader>cf <cmd>Easypick changed_files<cr>
   nnoremap <Leader>cn <cmd>Easypick conflicts<cr>
]]

-- nnn
-- vim.cmd [[
--   tnoremap <C-e> <cmd>NnnExplorer<CR>
--   nnoremap <C-e> <cmd>NnnExplorer %:p:h<CR>
--   tnoremap <C-P> <cmd>NnnPicker<CR>
--   nnoremap <C-P> <cmd>NnnPicker<CR>
-- ]]

-- quick sourcing

vim.cmd [[
  inoremap <C-s> <cmd>so<CR>
  nnoremap <C-s> <cmd>so<CR>
]]

-- sessions
-- :SessionToggle - Determines whether to load, start or stop a session
-- :SessionStart - Start recording a session. Useful if autosave = false
-- :SessionStop - Stop recording a session
-- :SessionSave - Save the current session
-- :SessionLoad - Load the session for the current directory and current branch (if git_use_branch = true)
-- :SessionLoadLast - Load the most recent session
-- :SessionLoadFromFile - Load a session from a given path
-- :SessionDelete - Delete the current session
vim.api.nvim_set_keymap('n', '<leader>sl', '<cmd>SessionLoadLast<cr>', mapopts)
vim.api.nvim_set_keymap('n', '<leader>ss', '<cmd>SessionStart<cr>', mapopts)
vim.api.nvim_set_keymap('n', '<leader>su', '<cmd>SessionSave<cr>', mapopts)
vim.api.nvim_set_keymap('n', '<leader>st', '<cmd>SessionStop<cr>', mapopts)
-- vim.api.nvim_set_keymap('n', '<leader>su', '<cmd>SessionSave<cr>', jqpts)
-- vim.api.nvim_set_keymap('n', '<leader>qs', '<cmd>SessionStart<cr>', jqpts)
-- vim.api.nvim_set_keymap('n', '<leader>qr', '<cmd>Telescope persisted<cr>', jqpts)
-- restore the session for the current directory
-- autosession


-- refactoring
-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
  "v",
  "<leader>rr",
  "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  { noremap = true }
)

-- dap
vim.cmd [[
    nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
    nnoremap <silent> <F8> <Cmd>lua require"dap.ui.widgets".hover()<CR>
    nnoremap <silent> <F9> <Cmd>lua require'dap'.toggle_breakpoint()<CR>
    nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
    nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
    nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
    nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
    nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
    nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
    nnoremap <silent> <Leader>dl <Cmd>lua require'osv'.launch({port = 8086})<CR>
    nnoremap <silent> <Leader>ds <Cmd>lua require'osv'.stop()<CR>
]]

-- diff
vim.cmd [[
command! DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_
		\ | diffthis | wincmd p | diffthis
]]

-- dbui
vim.cmd [[
    nnoremap <Leader>W <Plug>(DBUI_SaveQuery)
]]


-- Tabs
--
vim.api.nvim_set_keymap("n", "<c-t>h", "<cmd>tabp<cr>", mapopts);
vim.api.nvim_set_keymap("n", "<c-t>l", "<cmd>tabn<cr>", mapopts)
vim.api.nvim_set_keymap("n", "<c-t>k", "<cmd>tabcl<cr>", mapopts)
vim.api.nvim_set_keymap("n", "<c-t>n", "<cmd>tabnew<cr>", mapopts)
vim.api.nvim_set_keymap("n", "<c-t>H", "<cmd>tabmove -1<cr>", mapopts)
vim.api.nvim_set_keymap("n", "<c-t>L", "<cmd>tabmove +1<cr>", mapopts)
vim.api.nvim_set_keymap("n", "<c-t>o", "<cmd>tabonly<cr>", mapopts)
vim.api.nvim_set_keymap("n", "<tab><space>", "g<tab>", mapopts)
vim.api.nvim_set_keymap("n", "<space><space>", "g<tab>", mapopts)
vim.api.nvim_set_keymap("n", "<space><tab>", "g<tab>", mapopts)
vim.api.nvim_set_keymap("n", "<space>1", "1gt", mapopts)
vim.api.nvim_set_keymap("n", "<space>2", "2gt", mapopts)
vim.api.nvim_set_keymap("n", "<space>3", "3gt", mapopts)
vim.api.nvim_set_keymap("n", "<space>4", "4gt", mapopts)
vim.api.nvim_set_keymap("n", "<space>5", "5gt", mapopts)
vim.api.nvim_set_keymap("n", "<space>6", "6gt", mapopts)
vim.api.nvim_set_keymap("n", "<space>7", "7gt", mapopts)
vim.api.nvim_set_keymap("n", "<space>8", "8gt", mapopts)

 -- Macro
vim.keymap.set('v', 'Q', ':norm Q<cr>', mapopts)

-- LUA DEVELOPMENT
--
vim.api.nvim_set_keymap("n", "<leader>R", "<cmd>Luadev<cr>", mapopts)
vim.keymap.set({'n', 'v'}, '<leader>r', '<Plug>(Luadev-Run)', mapopts)

-- NOTIFICATIONS
vim.keymap.set({'n', 'v' }, '<space>ji', function() require('notify').dismiss() end, mapopts)
