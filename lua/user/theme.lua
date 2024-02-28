-- Specs use palettes as the template source
local specs = {
  github_dark_dimmed = {
    diff = {
      add = {
        fg = 'green',
        bg = 'white'
      },
      delete = {
        fg = 'red',
        bg = 'white'
      },
      change = {
        fg = 'blue',
        bg = 'white'
      },
      text = {
        fg = 'orange',
        bg = 'white'
      }
    },
  }
}

-- Groups use specs as the template source
local groups = {
  all = {
    -- The template path is parsed as [`syntax`, `string`]. This is similar to calling into a Lua table, like:
    -- `spec.syntax.string`.
    String = nil,

    -- If `link` is defined, it will be applied over any other values defined
    Whitespace = nil,

    -- Specs are used as the template. Specs have their palettes as a field that can be accessed.
    IncSearch = nil,
  },
}

require('github-theme').setup({ specs = specs, groups = groups })
