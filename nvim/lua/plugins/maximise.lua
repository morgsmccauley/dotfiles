return {
  'declancm/maximize.nvim',
  keys = {
    {
      '<leader>wm',
      function()
        require('maximize').toggle()
      end,
    },
    {
      '<C-z>',
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
}
