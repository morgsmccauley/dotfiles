return {
  'nvim-telescope/telescope.nvim',
  after = 'telescope-ui-select.nvim',
  requires = {
    {
      'nvim-telescope/telescope-ui-select.nvim',
      module = { 'telescope', 'plugins/navigation/telescope/telescope' },
      cmd = 'Telescope',
    },
    {
      'nvim-telescope/telescope-github.nvim',
      after = 'telescope-ui-select.nvim'
    },
    {

      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
      after = 'telescope-ui-select.nvim'
    },
  },
  config = function()
    require('plugins/navigation/telescope/telescope')
  end
}
