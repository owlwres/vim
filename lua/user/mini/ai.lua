local spec_treesitter = require('mini.ai').gen_spec.treesitter
local spec_pair = require('mini.ai').gen_spec.pair

require('mini.ai').setup({
  mappings = {
    -- Main textobject prefixes
    around = 'a',
    inside = 'i',

    -- Next/last textobjects
    around_next = 'an',
    inside_next = 'in',
    around_last = 'al',
    inside_last = 'il',

    -- Move cursor to corresponding edge of `a` textobject
    goto_left = 'g[',
    goto_right = 'g]',
  },
  custom_textobjects = {
    'w',
    -- _ = spec_pair('_', '_', {}),
    F = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
    z = spec_treesitter({
      a = { '@conditional.outer', '@loop.outer' },
      i = { '@conditional.inner', '@loop.inner' },
    })
  }
})

