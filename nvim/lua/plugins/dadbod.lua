return {
  'tpope/vim-dadbod',
  dependencies = {
    'kristijanhusak/vim-dadbod-ui',
  },
  cmd = { 'DB', 'DBUI' },
  init = function()
    vim.g.dbs = {
      queryapi = 'postgres://postgres@34.83.250.216/postgres'
    }
  end,
}
