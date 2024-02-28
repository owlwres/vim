return function(opts)
  local ls = require 'luasnip'
  if opts then ls.config.setup(opts) end
  vim.tbl_map(
    function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
    { "vscode", "lua" }
  )

  -- friendly-snippets - enable standardized comments snippets
  ls.filetype_extend("typescript", { "tsdoc" })
  ls.filetype_extend("javascript", { "jsdoc" })
  ls.filetype_extend("lua", { "luadoc" })
  ls.filetype_extend("python", { "pydoc" })
  ls.filetype_extend("rust", { "rustdoc" })
  ls.filetype_extend("cs", { "csharpdoc" })
  ls.filetype_extend("java", { "javadoc" })
  ls.filetype_extend("c", { "cdoc" })
  ls.filetype_extend("cpp", { "cppdoc" })
  ls.filetype_extend("php", { "phpdoc" })
  ls.filetype_extend("kotlin", { "kdoc" })
  ls.filetype_extend("ruby", { "rdoc" })
  ls.filetype_extend("sh", { "shelldoc" })
end
