return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      signs = {
        add = { text = '▌' },
        change = { text = '▌' },
        untracked = { text = '▌' },
      },
      watch_gitdir = {
        interval = 100
      },
    }

  end
}
