return {
  {
    'folke/todo-comments.nvim',
    config = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      {'<space>tl', function() vim.cmd('TodoLocList') end, mode = {'n', 'v', 'o'}, desc = 'TODOs Loc List'},
      {'<space>tq', function() vim.cmd('TodoQuickFix') end, mode = {'n', 'v', 'o'}, desc = 'TODOs Quick Fix'},
      {'<space>tt', function() vim.cmd('TodoTelescope') end, mode = {'n', 'v', 'o'}, desc = 'TODOs'},
    },
    opts = {
      colors = {
        error = {'DiagnosticError', 'ErrorMsg', '#DC2626'},
        warning = {'DiagnosticWarn', 'WarningMsg', '#FBBF24'},
        info = {'DiagnosticInfo', '#2563EB'},
        hint = {'DiagnosticHint', '#10B981'},
        default = {'Identifier', '#7C3AED'},
        test = {'Identifier', '#FF00FF'}
      },
      gui_style = {
        fg = 'NONE',
        bg = 'BOLD',
      },
      keywords = {
        FIX = {
          icon = ' ',
          color = 'error',
          alt = {'FIXME', 'BUG', 'FIXIT', 'ISSUE'},
        },
        TODO = {icon = ' ', color = 'info'},
        HACK = {icon = ' ', color = 'warning'},
        WARN = {icon = ' ', color = 'warning', alt = {'WARNING', 'XXX'}},
        PERF = {icon = ' ', alt = {'OPTIM', 'PERFORMANCE', 'OPTIMIZE'}},
        NOTE = {icon = ' ', color = 'hint', alt = {'INFO'}},
        TEST = {icon = '⏲ ', color = 'test', alt = {'TESTING', 'PASSED', 'FAILED'}},
      },
      signs = true,
      sign_priority = 8,
    },
  },
}

