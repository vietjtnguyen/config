return {
  {
    'neovim/nvim-lspconfig',
    keys = {
      {']e', vim.diagnostic.goto_next, mode = {'n', 'v', 'o'}, desc = 'Next Diagnostic'},
      {'[e', vim.diagnostic.goto_prev, mode = {'n', 'v', 'o'}, desc = 'Previous Diagnostic'},
      {'ge', vim.diagnostic.open_float, mode = {'n', 'v', 'o'}, desc = 'Open Diagnostic'},
      {'gE', vim.diagnostic.setloclist, mode = {'n', 'v', 'o'}, desc = 'Diagnostics to Loc List'},
    },
    init = function()
      local lspconfig = require('lspconfig')
      lspconfig.clangd.setup {}
      lspconfig.cmake.setup {}
      lspconfig.jedi_language_server.setup {}
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set({'n', 'v'}, 'ga', vim.lsp.buf.code_action, opts)
          vim.keymap.set({'n', 'v'}, 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set({'n', 'v'}, 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set({'n', 'v'}, 'gF', vim.lsp.buf.format, opts)
          vim.keymap.set({'n', 'v'}, 'gk', vim.lsp.buf.hover, opts)
          vim.keymap.set({'n', 'v'}, 'gK', vim.lsp.buf.signature_help, opts)
          vim.keymap.set({'n', 'v'}, 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set({'n', 'v'}, 'gr', vim.lsp.buf.rename, opts)
          vim.keymap.set({'n', 'v'}, 'gy', vim.lsp.buf.type_definition, opts)
        end,
      })
    end,
  },
}
