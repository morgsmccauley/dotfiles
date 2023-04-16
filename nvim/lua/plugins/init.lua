return {
  'alvan/vim-closetag',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'nathom/filetype.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',
  'folke/lazy.nvim',
  {
    'tpope/vim-dotenv',
    config = function()
      vim.cmd('Dotenv ' .. os.getenv('HOME') .. '/.dotfiles/.env')
    end
  }
}
