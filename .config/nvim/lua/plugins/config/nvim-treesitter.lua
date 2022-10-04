require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  ignore_install = { 'phpdoc' },
  highlight = {
    enable = true,
    use_languagetree = true
  }
}

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.markdown.filetype_to_parsername = 'octo'
