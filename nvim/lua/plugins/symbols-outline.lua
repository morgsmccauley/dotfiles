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
      relative_width = false,
      width = 50,
      position = 'left',
      autofold_depth = 2,
    })
  end,
}
