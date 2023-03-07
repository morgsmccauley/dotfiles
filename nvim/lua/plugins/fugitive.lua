return {
  'tpope/vim-fugitive',
  keys = {
    {
      '<C-g>',
      function()
        if vim.bo.filetype == 'fugitive' then
          vim.api.nvim_command('q')
        else
          vim.api.nvim_command('tab Git')
        end
      end,
    }
  },
  dependencies = {
    'https://github.com/tpope/vim-rhubarb'
  },
  cmd = { 'Git', 'G', 'GBrowse' }
}
