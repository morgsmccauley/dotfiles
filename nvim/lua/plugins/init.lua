return {
  'alvan/vim-closetag',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'nathom/filetype.nvim',
  'lewis6991/impatient.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',
  {
    'jiangmiao/auto-pairs',
    --event = 'InsertEnter'
  },
  {
    'szw/vim-maximizer',
    cmd = 'MaximizerToggle'
  },
  {
    'folke/lazy.nvim'
  },
  {
    'b0o/incline.nvim',
    config = function()
      require('incline').setup({
        window = {
          margin = {
            horizontal = 0
          }
        }
      })
    end
  }
}
