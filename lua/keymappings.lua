if vim.g.vscode then
  return
end

-- leadghr
local keymap = vim.api.nvim_set_keymap
local mapopts = { noremap = true, silent = true }
local Path = require('plenary.path')

-- netrw integration

-- what is this?

vim.keymap.set('n', '-', function()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.api.nvim_buf_get_option(bufnr, 'filetype') ~= 'netrw' then
    vim.fn.execute('Explore')
  end
end, mapopts)

local function netrw_navigate()
  vim.notify(vim.fn.getcwd())
end

local netrw_telescope_augroup = vim.api.nvim_create_augroup("netrw_telescope", { clear = true })
vim.api.nvim_create_autocmd('filetype', {
  group = netrw_telescope_augroup,
  pattern = 'netrw',
  callback = function()
    local buffer = vim.fn.bufnr(vim.fn.bufname('%'))
    vim.keymap.set('n', '<C-f>', function()
      local opts = {
        attach_mappings = function(prompt_bufnr, map)
          local actions = require 'telescope.actions'
          local action_set = require 'telescope.actions.set'
          local action_state = require 'telescope.actions.state'
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            action_set.select(prompt_bufnr, 'default')
            local path_cwd = Path:new(vim.fn.getcwd())
            local path_cwd_plus_selection = path_cwd:joinpath(selection.text)
            if (path_cwd_plus_selection:is_dir()) then
              vim.cmd('!zoxide add ' .. path_cwd_plus_selection.filename)
            end
            vim.fn.feedkeys('o')
          end)
          return true
        end
      }
      require 'telescope.builtin'.current_buffer_fuzzy_find(opts)
    end, { buffer = true })
  end
})

local netrw_mapping_augroup = vim.api.nvim_create_augroup('netrw_mapping', { clear = true })
vim.api.nvim_create_autocmd('filetype', {
  group = netrw_mapping_augroup,
  pattern = 'netrw',
  callback = function()
    -- local netrwmapopts = vim.deepcopy(mapopts)
    -- netrwmapopts.buffer = true
    local netrwmapopts = { buffer = true }
    vim.keymap.set('n', '<C-n>', '<cmd>term<CR>i', netrwmapopts)
    vim.keymap.set('n', 'o', '<Plug>NetrwLocalBrowseCheck', netrwmapopts)
    vim.keymap.set('n', '~', '<cmd>NetrwKeepj call netrw#LocalBrowseCheck(expand("~/work"))<cr>', netrwmapopts)
    vim.keymap.set('n', '<leader>sd', '<cmd>Easypick foldersbelow<cr>', netrwmapopts)
    local s_mapping = vim.fn.maparg('s', 'n', nil, true)
    local S_mapping = vim.fn.maparg('S', 'n', nil, true)
    if s_mapping.buffer ~= 0 then
      vim.keymap.del({ 'n' }, 's', { buffer = true })
    end
    if S_mapping.buffer ~= 0 then
      vim.keymap.del({ 'n' }, 'S', { buffer = true })
    end
    -- vim.keymap.set('n', '-', function()
    --   local bufnr = vim.api.nvim_get_current_buf()
    --   local path = Path.new(vim.fn.getcwd())
    --   local parent = path:parent().filename
    --   vim.cmd('Explore ' .. parent)
    --   -- local bufnr = vim.api.nvim_get_current_buf()
    --   -- vim.api.nvim_buf_set_name(bufnr, parent)
    -- end, netrwmapopts)
  end
})

-- telescope
--
vim.keymap.set("n", "<leader>ff", function()
  local builtin = require('telescope.builtin')
  local utils = require('telescope.utils')
  builtin.find_files({
    cwd = utils.buffer_dir()
  })
end, mapopts)

vim.keymap.set("n", "<leader>fj", function()
  local builtin = require('telescope.builtin')
  local utils = require('telescope.utils')
  builtin.live_grep({
    cwd = utils.buffer_dir()
  })
end, mapopts)

vim.keymap.set({ 'n' }, '<leader>la', function()
  require("telescope").extensions.aerial.aerial()
end, mapopts)

vim.keymap.set({ 'n' }, '<leader>§', function()
  require('telescope-tabs').list_tabs()
end, mapopts)

vim.cmd [[
	nnoremap <c-f> <cmd>Telescope current_buffer_fuzzy_find<cr>
	nnoremap <Leader>bs <cmd>Telescope buffers<cr>
	nnoremap <Leader>js <cmd>Telescope jumplist<cr>
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
  nnoremap <Leader>lw <cmd>Telescope lsp_workspace_symbols<cr>
  nnoremap <Leader>re <cmd>Telescope resume<cr>
  nnoremap <Leader>he <cmd>Telescope cheat fd<cr>
  nnoremap <Leader>ma <cmd>Telescope macros<cr>
  nnoremap <Leader>no <cmd>Telescope noice<cr>
  nnoremap <Leader>md <cmd>Telescope man_pages<cr>
]]


-- coq
--
-- local completion = require 'user.completion'
-- vim.keymap.set({ 'i' }, '<c-h>', function() completion.jump_confirm() end, mapopts)
-- vim.keymap.set({ 'i' }, '<c-l>', function() completion.confirm() end, mapopts)
-- vim.keymap.set({ 'i' }, '<c-i>', function() completion.complete() end, mapopts)

-- vim.cmd([[
--   nno <Leader>sn <cmd>COQsnips edit<cr>
--   nno <Leader>sb <cmd>COQsnips compile<cr><c-c>
-- ]])


-- motion
-- vim.cmd [[
-- 	nnoremap <Leader>hg <cmd>HopWord<cr>
-- 	nnoremap <Leader>hf <cmd>HopPattern<cr>
-- 	nnoremap <Leader>hj <cmd>HopLine<cr>
--   vnoremap <Leader>hg <cmd>HopWord<cr>
--   vnoremap <Leader>hf <cmd>HopPattern<cr>
--   vnoremap <Leader>hj <cmd>HopLine<cr>
-- ]]

-- easypick
--

-- nnoremap <leader>sd <cmd>cd %:p:h<cr><cmd>Easypick foldersbelow<cr>
vim.cmd [[
   nnoremap <leader>sd <cmd>Easypick foldersbelow<cr>
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

-- sessions


-- :SessionToggle - Determines whether to load, start or stop a session
-- :SessionStart - Start recording a session. Useful if autosave = false
-- :SessionStop - Stop recording a session
-- :SessionSave - Save the current session
-- :SessionLoad - Load the session for the current directory and current branch (if git_use_branch = true)
-- :SessionLoadLast - Load the most recent session
-- :SessionLoadFromFile - Load a session from a given path
-- :SessionDelete - Delete the current session
-- local otheropts = {silent = true, noremap = true, desc = "?1"}
-- vim.api.nvim_set_keymap('n', '<leader>ss', '<cmd>SessionStart<cr>', mapopts)
-- vim.api.nvim_set_keymap('n', '<leader>st', '<cmd>SessionStop<cr>', mapopts)
-- vim.api.nvim_set_keymap('n', '<leader>sl', '<cmd>SessionLoadLast<cr>', mapopts)
-- vim.api.nvim_set_keymap('n', '<leader>su', '<cmd>SessionSave<cr>', mapopts)
-- vim.api.nvim_set_keymap('n', '<leader>sj', '<cmd>Telescope persisted<cr>', mapopts)
-- vim.api.nvim_set_keymap('n', '<leader>su', '<cmd>SessionSave<cr>', jqpts)
-- vim.api.nvim_set_keymap('n', '<leader>qs', '<cmd>SessionStart<cr>', jqpts)
-- restore the session for the current directory
-- autosession


-- refactoring
-- remap to open the Telescope refactoring menu in visual mode
-- vim.api.nvim_set_keymap(
--   "v",
--   "<leader>rr",
--   "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
--   { noremap = true }
-- )

local change_directory_to_project_root = function()
  local cwd = vim.fn.getcwd()
  vim.cmd.cd()
  local cwdpath = Path:new(cwd)
  local path_components = cwdpath:_split()
  local tail_component
  for index, value in ipairs(cwdpath:_split()) do
    tail_component = value
  end
  if tail_component == 'src' then
    vim.cmd.cd('..')
  end
end

-- dap
--
-- local typescript_mapping_augroup = vim.api.nvim_create_augroup('typescript_mapping', { clear = true })
-- vim.api.nvim_create_autocmd('filetype', )

vim.cmd [[
    nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
    nnoremap <silent> <F8> <Cmd>lua require"dap.ui.widgets".hover()<CR>
    nnoremap <silent> <F9> <Cmd>lua require'dap'.toggle_breakpoint()<CR>
    nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
    nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
    nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
    nnoremap <silent> <Leader>ds <Cmd>lua require'dap'.terminate()<CR>
    nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
    nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
    nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
    nnoremap <silent> <Leader>dl <Cmd>lua require'osv'.launch({port = 8086})<CR>
    nnoremap <silent> <Leader>dS <Cmd>lua require'osv'.stop()<CR>
    nnoremap <silent> <Leader>do <Cmd>lua require'dapui'.open()<CR>
    nnoremap <silent> <Leader>dc <Cmd>lua require'dapui'.close()<CR>
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
vim.api.nvim_set_keymap("n", "`h", "<cmd>tabp<cr>", mapopts);
vim.api.nvim_set_keymap("n", "`l", "<cmd>tabn<cr>", mapopts)
vim.api.nvim_set_keymap("n", "`k", "<cmd>tabcl<cr>", mapopts)
vim.api.nvim_set_keymap("n", "`n", "<cmd>tabnew<cr>", mapopts)
vim.api.nvim_set_keymap("n", "`H", "<cmd>tabmove -1<cr>", mapopts)
vim.api.nvim_set_keymap("n", "`L", "<cmd>tabmove +1<cr>", mapopts)
vim.api.nvim_set_keymap("n", "`i", "<cmd>tabfir<cr>", mapopts)
vim.api.nvim_set_keymap("n", "`p", "<cmd>tabl<cr>", mapopts)
vim.api.nvim_set_keymap("n", "<c-t>o", "<cmd>tabonly<cr>", mapopts)
vim.api.nvim_set_keymap("n", "`<space>", "g<tab>", mapopts)
vim.api.nvim_set_keymap("n", "<space><space>", "g<tab>", mapopts)
vim.api.nvim_set_keymap("n", "``", "g<tab>", mapopts)
vim.api.nvim_set_keymap("n", "`1", "1gt", mapopts)
vim.api.nvim_set_keymap("n", "`2", "2gt", mapopts)
vim.api.nvim_set_keymap("n", "`3", "3gt", mapopts)
vim.api.nvim_set_keymap("n", "`4", "4gt", mapopts)
vim.api.nvim_set_keymap("n", "`5", "5gt", mapopts)
vim.api.nvim_set_keymap("n", "<space>1", "1gt", mapopts)
vim.api.nvim_set_keymap("n", "<space>2", "2gt", mapopts)
vim.api.nvim_set_keymap("n", "<space>3", "3gt", mapopts)
vim.api.nvim_set_keymap("n", "<space>4", "4gt", mapopts)
vim.api.nvim_set_keymap("n", "<space>5", "5gt", mapopts)
vim.api.nvim_set_keymap("n", "<space>6", "6gt", mapopts)
vim.api.nvim_set_keymap("n", "<space>7", "7gt", mapopts)
vim.api.nvim_set_keymap("n", "<space>8", "8gt", mapopts)

-- Windows
--
vim.api.nvim_set_keymap("n", "`wj", "<c-w>j", mapopts)
vim.api.nvim_set_keymap("n", "`wk", "<c-w>k", mapopts)
vim.api.nvim_set_keymap("n", "<c-w>d", "<c-w>c", mapopts)
vim.api.nvim_set_keymap("n", "`wh", "<c-w>h", mapopts)
vim.api.nvim_set_keymap("n", "`wl", "<c-w>l", mapopts)
vim.api.nvim_set_keymap("n", "`wu", "<c-w>s", mapopts)
vim.api.nvim_set_keymap("n", "`wi", "<c-w>v", mapopts)
vim.api.nvim_set_keymap("n", "`wo", "<c-w>o", mapopts)
vim.api.nvim_set_keymap("n", "`wy", "<c-w>30>", mapopts)
vim.api.nvim_set_keymap("n", "`wp", "<c-w>30+", mapopts)
vim.api.nvim_set_keymap("t", "`wn", "<C-\\><C-N>", mapopts)
vim.api.nvim_set_keymap("t", "<c-o>", "<C-\\><C-N>", mapopts)

-- Macro
--
vim.keymap.set('v', 'Q', ':norm Q<cr>', mapopts)

-- LUA DEVELOPMENT
--
vim.keymap.set({ 'n', 'v' }, '`<leader>', function()
  -- print(vim.inspect(require('scratch')))
  require('scratch'):open()
end
, mapopts)

vim.keymap.set({ 'n', 'v' }, '<leader>r', function()
  vim.cmd('so')
end, mapopts)

-- NOTIFICATIONS
vim.keymap.set({ 'n', 'v' }, '<space>ji', function() require('notify').dismiss() end, mapopts)

-- REGISTERS

vim.cmd [[
  nnoremap <C-j> "+y
  vnoremap <C-j> "+y
  nnoremap <C-p> "+p
  vnoremap <C-p> "+p
]]

-- TERMINAL MODE
--

vim.api.nvim_create_autocmd({ "TermEnter" }, {
  callback = function()
    local buffer = vim.fn.bufnr(vim.fn.expand("%"))
    -- vim.api.nvim_buf_set_keymap(buffer, 't', '<C-n>', '<C-c>nvrr<cr>', {})
    vim.api.nvim_buf_set_keymap(buffer, 'n', '<C-n>', '<cmd>startinsert<cr><C-n>', {})
  end
})

--- TABS
---

vim.api.nvim_set_keymap("t", "§h", "<C-\\><C-N><cmd>tabp<cr>", mapopts);
vim.api.nvim_set_keymap("t", "§l", "<C-\\><C-N><cmd>tabn<cr>", mapopts)
vim.api.nvim_set_keymap("t", "§k", "<C-\\><C-N><cmd>tabcl<cr>", mapopts)
vim.api.nvim_set_keymap("t", "§n", "<C-\\><C-N><cmd>tabnew<cr>", mapopts)
vim.api.nvim_set_keymap("t", "§H", "<C-\\><C-N><cmd>tabmove -1<cr>", mapopts)
vim.api.nvim_set_keymap("t", "§L", "<C-\\><C-N><cmd>tabmove +1<cr>", mapopts)
vim.api.nvim_set_keymap("t", "§i", "<C-\\><C-N><cmd>tabfir<cr>", mapopts)
vim.api.nvim_set_keymap("t", "§p", "<C-\\><C-N><cmd>tabl<cr>", mapopts)
vim.api.nvim_set_keymap("t", "<c-t>o", "<C-\\><C-N><cmd>tabonly<cr>", mapopts)
vim.api.nvim_set_keymap("t", "§<space>", "<C-\\><C-N>g<tab>", mapopts)

-- OVERSEER
--
vim.keymap.set({ 'n' }, "<leader>x", "<cmd>OverseerRun<cr>", mapopts)

-- NAVIGATOR

-- vim.keymap.set({ 'n' }, "gW", require('navigator.workspace').workspace_symbol_live, mapopts)

-- SOURCE CONTROL
vim.api.nvim_set_keymap("n", "<leader>ng", "<cmd>Neogit<cr>", mapopts);

-- WIKI
vim.api.nvim_set_keymap("n", "<leader>wp", "<Plug>(wiki-pages)", mapopts);
