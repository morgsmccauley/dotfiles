return {
  'wbthomason/packer.nvim',
  'jiangmiao/auto-pairs',
  'alvan/vim-closetag',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'nathom/filetype.nvim',
  'lewis6991/impatient.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',
  {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.g.tmux_navigator_no_wrap = 1
    end
  },
  {
    'szw/vim-maximizer',
    cmd = 'MaximizerToggle'
  },
}
