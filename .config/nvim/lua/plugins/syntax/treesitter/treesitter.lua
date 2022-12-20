require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  ignore_install = { 'phpdoc' },
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = { query = '@function.outer', desc = 'Outer function' },
        ['if'] = { query = '@function.inner', desc = 'Inner function' },

        ['ac'] = { query = '@call.outer', desc = 'Outer call' },
        ['ic'] = { query = '@call.inner', desc = 'Inner call' },

        ['aC'] = { query = '@class.outer', desc = 'Outer class' },
        ['iC'] = { query = '@class.inner', desc = 'Inner class' },

        ['a/'] = { query = '@comment.outer', desc = 'Outer comment' },

        ['al'] = { query = '@loop.outer', desc = 'Outer loop' },
        ['il'] = { query = '@loop.inner', desc = 'Inner loop' },

        ['am'] = { query = '@parameter.outer', desc = 'Outer parameter' },
        ['im'] = { query = '@parameter.inner', desc = 'Inner parameter' },
      },
      include_surrounding_whitespace = function(args)
        return args.query_string:gmatch('.outer$') ~= nil and args.selection_mode == 'V'
      end
    },
  },
})

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.markdown.filetype_to_parsername = 'octo'

require('treesitter-context').setup {
  enable = false
}

-- catppuccin wipes these?
-- vim.api.nvim_command [[hi link TreesitterContext Visual]]
