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
      function()
        require('gitsigns').prev_hunk()
      end,
      { noremap = true }
    )

    vim.keymap.set(
      'n',
      ']h',
      function()
        require('gitsigns').next_hunk()
      end,
      { noremap = true }
    )
  end
}
