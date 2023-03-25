return {
  'szw/vim-maximizer',
  keys = {
    {
      '<C-z>',
      '<Cmd>MaximizerToggle<Cr>'
    }
  },
  init = function()
    _G.maximizer_set_default_mapping = 1
  end
}
