return {
  'tpope/vim-dadbod',
  dependencies = {
    'kristijanhusak/vim-dadbod-ui',
  },
  cmd = { 'DB', 'DBUI' },
  init = function()
    vim.g.db_ui_show_help = 0
    vim.g.db_ui_winwidth = 30

    vim.o.previewheight = vim.fn.float2nr(vim.fn.winheight(0) / 2)
  end
}
