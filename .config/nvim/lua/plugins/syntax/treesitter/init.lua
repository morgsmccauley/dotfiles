return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'v0.8.0',
  requires = {
    { 'sheerun/vim-polyglot' },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'romgrk/nvim-treesitter-context' }
  },
  run = ':TSUpdate',
  config = function()
    require('plugins.syntax.treesitter.treesitter')
  end
}
