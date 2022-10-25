require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  ignore_install = { 'phpdoc' },
  highlight = {
    enable = true,
    use_languagetree = true
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@call.outer',
        ['ic'] = '@call.inner',
        ['aC'] = '@class.outer',
        ['iC'] = '@class.inner',
        ['a/'] = '@comment.outer',
        ['il'] = '@loop.inner',
        ['al'] = '@loop.outer',
      },
    },
  },
})

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.markdown.filetype_to_parsername = 'octo'
