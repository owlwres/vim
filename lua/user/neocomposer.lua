local config = {
  notify = false,
  delay_timer = 150,
  queue_most_recent = true,
  window = {
    width = 60,
    height = 10,
    border = "rounded",
    winhl = {
      Normal = "ComposerNormal",
    },
  },
  colors = {
    bg = "#16161e",
    fg = "#ff9e64",
    red = "#ec5f67",
    blue = "#5fb3b3",
    green = "#99c794",
  },
  keymaps = {
    play_macro = "Q",
    yank_macro = "yq",
    stop_macro = "cq",
    toggle_record = "q",
    cycle_next = "<c-m>n",
    cycle_prev = "<c-m>p",
    toggle_macro_menu = "<m-q>",
  },
}
require('NeoComposer').setup(config)
