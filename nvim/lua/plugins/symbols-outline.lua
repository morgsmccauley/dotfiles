return {
  'simrat39/symbols-outline.nvim',
  keys = {
    {
      '<C-p>',
      '<Cmd>SymbolsOutline<Cr>',
      { silent = true, noremap = true }
    }
  },
  config = function()
    require('symbols-outline').setup({
      position = 'left'
    })
  end,
}
