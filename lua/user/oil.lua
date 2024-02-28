require("oil").setup({
  buf_options = {
    buflisted = true,
    bufhidden = "",
  },
  delete_to_trash = true,
  prompt_save_on_select_new_entry = false,
  cleanup_delay_ms = 0,
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
