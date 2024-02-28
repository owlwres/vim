vim.g.coq_settings = {
  auto_start = 'shut-up',
  keymap = {
    recommended = true,
    pre_select = true,
  },
  clients = {
    registers = {
      words = {
        "0",
        "a",
        "b",
        "c",
        "d",
        "e",
        "f",
      }
    }
  }
}

vim.cmd('COQnow --shut-up')
