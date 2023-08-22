return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'andersevenrud/cmp-tmux',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'lukas-reineke/cmp-rg',
    },
    --event = 'InsertEnter',
    config = function()
      vim.api.nvim_set_hl(0, 'CmpGhostText', {link = 'Comment', default = true})
      local cmp = require('cmp')
      local defaults = require('cmp.config.default')()
      cmp.setup({
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        mapping = cmp.mapping.preset.insert({
          ['<c-n>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
          ['<c-p>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
          ['<c-b>'] = cmp.mapping.scroll_docs(-4),
          ['<c-f>'] = cmp.mapping.scroll_docs(4),
          ['<c-space>'] = cmp.mapping.complete(),
          ['<c-e>'] = cmp.mapping.abort(),
          ['<cr>'] = cmp.mapping.confirm({select = true}),
          ['<s-cr>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),
        sources = cmp.config.sources({
          --{name = 'luasnip'},
          {name = 'buffer'},
          {name = 'calc'},
          {name = 'nvim_lsp'},
          {name = 'nvim_lsp_document_symbol'},
          {name = 'nvim_lsp_signature_help'},
          {name = 'path'},
          {
            name = 'rg',
            keyword_length = 3,
          },
          {
            name = 'tmux',
            option = {
              -- Source from all panes in session instead of adjacent panes
              all_panes = true,
              -- Completion popup label
              label = '[tmux]',
              -- Trigger character
              --trigger_characters = {'.'},
              -- Specify trigger characters for filetype(s)
              -- {filetype = {'.'}}
              --trigger_characters_ft = {},
              -- Keyword patch mattern
              --keyword_pattern = [[\w\+]],
            },
          },
        }),
        experimental = {
          ghost_text = {
            hl_group = 'CmpGhostText',
          },
        },
        sorting = defaults.sorting,
      })
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          {name = 'buffer'},
          {name = 'path'},
          {name = 'rg'},
          {name = 'tmux'},
        }
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          {name = 'path'},
        },
        {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = {'Man'},
            }
          }
        })
      })
    end,
    version = false, -- last release is way too old
  },
}

