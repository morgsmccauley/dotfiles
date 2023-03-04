return {
  'alvan/vim-closetag',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'nathom/filetype.nvim',
  'lewis6991/impatient.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',
  {
    'simrat39/symbols-outline.nvim',
    config = true,
  },
  {
    'declancm/maximize.nvim',
    keys = {
      {
        '<leader>wm',
        function()
          require('maximize').toggle()
        end,
      }
    },
    config = function()
      require('maximize').setup({
        default_keymaps = false
      })
    end
  },
  {
    'folke/lazy.nvim'
  },
}
