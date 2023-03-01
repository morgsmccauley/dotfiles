return {
  'numToStr/Comment.nvim',
  keys = {
    {
      '<C-/>',
      function()
        require('Comment.api').toggle.linewise.current()
      end,
    },
    {
      '<C-/>',
      '<Plug>(comment_toggle_blockwise_visual)',
      mode = 'v',
      { expr = true }
    }
  },
  config = function()
    require('Comment').setup({
      mappings = false
    })
  end
}
