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

    vim.keymap.set(
      'n',
      '[h',
      require('gitsigns').prev_hunk,
      { noremap = true }
    )

    vim.keymap.set(
      'n',
      ']h',
      require('gitsigns').next_hunk,
      { noremap = true }
    )

    vim.keymap.set(
      'n',
      'vah',
      require('gitsigns').select_hunk,
      { noremap = true }
    )

    vim.keymap.set(
      'n',
      'dah',
      require('gitsigns').reset_hunk,
      { noremap = true }
    )
  end
}
