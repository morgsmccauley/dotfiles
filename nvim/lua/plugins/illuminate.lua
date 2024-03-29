return {
  'RRethy/vim-illuminate',
  event = 'VeryLazy',
  init = function()
    vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'Visual' })
    vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'Visual' })
    vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'Visual' })
  end,
  config = function()
    require('illuminate').configure({
      filetypes_denylist = {
        'NvimTree',
        'NeogitStatus'
      },
      under_cursor = false,
    })
  end
}
