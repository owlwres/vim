local cmp = require 'cmp'
local luasnip = require('luasnip')
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<c-l>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- that way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<c-h>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    -- [';'] = cmp.mapping.confirm({ select = true}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<c-k>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    -- { name = "async_path" },
    -- { name = "nvim_lua" },
    -- { name = "fuzzy_buffer" },
    -- { name = "async_path" },
    { name = "buffer" },
    { name = "nvim_lsp" },
    { name = "nvim_lsp_document_symbol" },
    { name = "nvim_lsp_signature_help" },
    { name = 'luasnip' },    -- For luasnip users.
    { name = 'luasnip_choice' },    -- For luasnip users.
    -- { name = "rg" },
    -- { name = "git" },
  }),
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})
--
-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'fuzzy_buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'fuzzy_path' },
    { name = 'cmdline' },
    { name = 'cmdline_history' }
  })
})
