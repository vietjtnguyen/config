return {
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end,
  },
  {
    'ggandor/leap-spooky.nvim',
    config = function()
      require('leap-spooky').setup({
        paste_on_remote_yank = true,
        prefix = true,
      })
    end,
    dependencies = {'ggandor/leap.nvim'},
  },
}
