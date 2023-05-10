return {
  'numToStr/Comment.nvim',
  keys = {
    { 'gc', mode = { 'v', 'n' } },
    { 'gb', mode = { 'n', 'v' } }
  },
  config = function()
    require('Comment').setup({})
  end
}
