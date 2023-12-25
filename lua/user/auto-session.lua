local opts = {
  log_level = 'error',
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_session_enabled = true,
  auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  auto_session_use_git_branch = nil,
  -- the configs below are lua only
  bypass_session_save_file_types = nil,
  cwd_change_handling = { -- table: Config for handling the DirChangePre and DirChanged autocmds, can be set to nil to disable altogether
    restore_upcoming_session = true, -- boolean: restore session for upcoming cwd on cwd change
    pre_cwd_changed_hook = nil, -- function: This is called after auto_session code runs for the `DirChangedPre` autocmd
    post_cwd_changed_hook = nil, -- function: This is called after auto_session code runs for the `DirChanged` autocmd
  }
}

require("auto-session").setup(opts)

