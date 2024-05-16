return {
  {
    'echasnovski/mini.bracketed',
    version = '*',
    keys = { '[', ']' },
    config = function()
      require('mini.bracketed').setup()
    end,
  },
  {
    'echasnovski/mini.pairs',
    version = '*',
    event = 'InsertEnter',
    config = function()
      require('mini.pairs').setup()
    end
  },
  {
    'echasnovski/mini.files',
    version = '*',
    config = function()
      require('mini.files').setup()
    end
  }
}
