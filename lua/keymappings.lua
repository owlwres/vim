-- leadghr
local keymap = vim.api.nvim_set_keymap
local jpts = { noremap = true, silent = true }
-- keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

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

vim.keymap.set("n", "<leader>fw", "<Cmd>Telescope frecency<CR>")

vim.cmd [[
	nnoremap <Leader>bf <cmd>Telescope current_buffer_fuzzy_find<cr>
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
]]

-- autosession
vim.keymap.set("n", "<Leader>sl", require("auto-session.session-lens").search_session, {
  noremap = true,
})

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
   nnoremap <Leader>sd <cmd>lcd %:p:h<cr><cmd>Easypick foldersbelow<cr>
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
-- restore the session for the current directory
vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})

-- restore the last session
vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})

-- stop Persistence => session won't be saved on exit
vim.api.nvim_set_keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {})


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

-- Telekasten

-- Launch panel if nothing is typed after <leader>z
vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>")

-- Most used functions
vim.keymap.set("n", "<leader>kf", "<cmd>Telekasten find_notes<CR>")
vim.keymap.set("n", "<leader>kj", "<cmd>Telekasten search_notes<CR>")
vim.keymap.set("n", "<leader>kd", "<cmd>Telekasten goto_today<CR>")
vim.keymap.set("n", "<leader>kw", "<cmd>Telekasten goto_thisweek<CR>")
vim.keymap.set("n", "<leader>kz", "<cmd>Telekasten follow_link<CR>")
vim.keymap.set("n", "<leader>kn", "<cmd>Telekasten new_note<CR>")
-- vim.keymap.set("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>")
vim.keymap.set("n", "<leader>kc", "<cmd>Calendar<CR>")
vim.keymap.set("n", "<leader>kb", "<cmd>Telekasten show_backlinks<CR>")
vim.keymap.set("n", "<leader>kI", "<cmd>Telekasten insert_img_link<CR>")

-- Call insert link automatically when we start typing a link
vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")

