return {
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('undo')
    end,
    dependencies = {
      'debugloop/telescope-undo.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    keys = {
      {'<space>b', function() require('telescope.builtin').buffers() end, mode = {'n', 'v', 'o'}, desc = 'Buffers'},
      {'<space>e', function() require('telescope.builtin').diagnostics() end, mode = {'n', 'v', 'o'}, desc = 'Diagnostics'},
      {'<space>F', function() require('telescope.builtin').current_buffer_fuzzy_find() end, mode = {'n', 'v', 'o'}, desc = 'Buffer Fuzzy Find'},
      {'<space>f', function() require('telescope.builtin').live_grep() end, mode = {'n', 'v', 'o'}, desc = 'Live Grep'},
      {'<space>gb', function() require('telescope.builtin').git_branches() end, mode = {'n', 'v', 'o'}, desc = 'Git Branches'},
      {'<space>gC', function() require('telescope.builtin').git_bcommits() end, mode = {'n', 'v', 'o'}, desc = 'Git Commits (buffer)'},
      {'<space>gc', function() require('telescope.builtin').git_commits() end, mode = {'n', 'v', 'o'}, desc = 'Git Commits'},
      {'<space>gs', function() require('telescope.builtin').git_status() end, mode = {'n', 'v', 'o'}, desc = 'Git Status'},
      {'<space>J', function() require('telescope.builtin').jumplist() end, mode = {'n', 'v', 'o'}, desc = 'Jump List'},
      {'<space>k', function() require('telescope.builtin').keymaps() end, mode = {'n', 'v', 'o'}, desc = 'Key Maps'},
      {'<space>K', function() require('telescope.builtin').man_pages() end, mode = {'n', 'v', 'o'}, desc = 'Man Pages'},
      {'<space>L', function() require('telescope.builtin').loclist() end, mode = {'n', 'v', 'o'}, desc = 'Location List'},
      {'<space>p', function() require('telescope.builtin').find_files() end, mode = {'n', 'v', 'o'}, desc = 'Find Files'},
      {'<space>P', function() require('telescope.builtin').oldfiles() end, mode = {'n', 'v', 'o'}, desc = 'Recent Files'},
      {'<space>q', function() require('telescope.builtin').builtin() end, mode = {'n', 'v', 'o'}, desc = 'Telescope Built In'},
      {'<space>Q', function() require('telescope.builtin').quickfix() end, mode = {'n', 'v', 'o'}, desc = 'Quick Fix List'},
      {'<space>T', function() require('telescope.builtin').treesitter() end, mode = {'n', 'v', 'o'}, desc = 'Treesitter'},
    },
    opts = {
    },
    tag = '0.1.2',
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  {'debugloop/telescope-undo.nvim'},
}

