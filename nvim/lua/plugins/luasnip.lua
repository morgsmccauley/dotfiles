return {
  'L3MON4D3/LuaSnip',
  event = 'InsertEnter',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  init = function()
    vim.keymap.set('i', '<C-l>', '<Plug>luasnip-expand-or-jump', { noremap = true, silent = true })
    vim.keymap.set('s', '<C-l>', '<Plug>luasnip-jump-next', { noremap = true, silent = true })
    vim.keymap.set('i', '<C-h>', '<Plug>luasnip-jump-prev', { noremap = true, silent = true })
    vim.keymap.set('s', '<C-h>', '<Plug>luasnip-jump-prev', { noremap = true, silent = true })
  end,
  config = function()
    require('luasnip').filetype_extend('typescript', { 'javascript' })
    require('luasnip.loaders.from_snipmate').lazy_load({ paths = { '~/.config/nvim/snippets' } })
  end,
}
