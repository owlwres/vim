cfg = {
	-- floating_window_above_cur_line = true,
	toggle_key = '<M-x>',
  select_signature_key = '<M-s>',
  move_cursor_key = '<M-w>'
} -- add you config here
require "lsp_signature".setup(cfg)
