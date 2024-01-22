return function(capabilities)
  local capabilities_configuration  = { capabilities }
  local coq = require('coq')
  capabilities = coq.lsp_ensure_capabilities(capabilities_configuration).capabilities
  -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp
  -- capabilities.textDocument.completion.completionItem.snippetSupport = true
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- Setup lspconfig.
  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    -- if client.server_capabilities.signatureHelpProvider then
    --   require('lsp-overloads').setup(client, {})
    -- if client.server_capabilities.signatureHelpProvider then
    --   require('lsp-overloads').setup(client, {})
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    --- Guard against servers without the signatureHelper capability
    -- if client.server_capabilities.signatureHelpProvider then
    --   require('lsp-overloads').setup(client, {})
    -- end

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>u', vim.lsp.buf.format, bufopts)
    vim.keymap.set('n', '<space>co', vim.lsp.buf.outgoing_calls, bufopts)
    vim.keymap.set('n', '<space>ci', vim.lsp.buf.incoming_calls, bufopts)
  end

  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  }

  require 'lspconfig'.clangd.setup {
    -- this was commented out before, for somre ason.
    capabilities = capabilities,
    on_attach = on_attach,
    -- why is this here?
    flags = lsp_flags,
  }
require'lspconfig'.lua_ls.setup {
    capabilities = capabilities,
    -- why is this here?
    flags = lsp_flags,
    on_attach = on_attach,
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
        client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              -- checkThirdParty = false,
              -- library = {
              --   vim.env.VIMRUNTIME
              --   -- "${3rd}/luv/library"
              --   -- "${3rd}/busted/library",
              -- }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              library = vim.api.nvim_get_runtime_file("", true)
            },
            completion = {
              callSnippet = "Replace"
            },
            diagnostics = {
              disable = { "missing-fields" },
            },
          }
-- example to setup lua_ls and enable call snippets
        })
        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
      end
      return true
  end
}  
  require 'lspconfig'.dhall_lsp_server.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
  }
  require 'lspconfig'.tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
  }
  -- require 'lspconfig'.jsonls.setup {
  --   capabilities = capabilities,
  --   cmd = { "vscode-json-languageserver", "--stdio" }
  -- }
  require('lspconfig').yamlls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
        }
      },
    }
  }
  require 'lspconfig'.bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "sh", "zsh" }
  }
  -- require 'lspconfig'.vimls.setup {}
  require'lspconfig'.pylsp.setup{
    capabilities = capabilities,
    flags = lsp_flags,
    on_attach = on_attach
  }
  require'lspconfig'.rust_analyzer.setup{
    capabilities = capabilities,
    flags = lsp_flags,
    on_attach = on_attach,
    settings = {
      ['rust-analyzer'] = {
        lens = {
          references = {
            trait = {
             enable = true
            },
            method = {
             enable = true
            },
            enumVariant = {
             enable = true
            },
            adt = {
             enable = true
            },
          }
        },
        hover = {
          actions = {
            references = {
             enable = true
            }
          }
        },
        diagnostics = {
          experimental = {
           enable = true
          }
        },
        completion = {
          fullFunctionSignatures = true
        },
        interpret = {
          tests = true
        }
      }
    }
  }
  require'lspconfig'.gopls.setup{}
  require'lspconfig'.elixirls.setup{
    -- Unix
    cmd = { "/path/to/elixir-ls/language_server.sh" };
  }
end

