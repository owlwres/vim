vim.g.wiki_root = '~/wiki'
vim.g.wiki_select_method = {
  pages = require("wiki.telescope").pages,
  tags = require("wiki.telescope").tags,
  toc = require("wiki.telescope").toc,
  links = require("wiki.telescope").links
}
vim.g.wiki_mappings_global = {
  {
    mode = 'n',
    lhs = '<leader>wp',
    rhs = '<Plug>(wiki-pages)'
  },
  {
    mode = 'n',
    lhs = '<leader>wt',
    rhs = '<Plug>(wiki-toc)'
  }
}

local wiki_mappings_local_altered = vim.g.wiki_mappings_local or {}
-- vim.g.wiki_mappings_local = vim.tbl_deep_extend('force', wiki_mappings_local_altered, vim.g.wiki_mappings_global)
-- vim.g.wiki_mappings_local = {}
