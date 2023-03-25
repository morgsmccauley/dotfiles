return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'sheerun/vim-polyglot',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/playground'
    },
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = 'all',
            highlight = {
                enable = true,
                use_languagetree = true,
                additional_vim_regex_highlighting = false
            },
            playground = {
                enable = true,
                disable = {},
                updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                persist_queries = false, -- Whether the query persists across vim sessions
                keybindings = {
                    toggle_query_editor = 'o',
                    toggle_hl_groups = 'i',
                    toggle_injected_languages = 't',
                    toggle_anonymous_nodes = 'a',
                    toggle_language_display = 'I',
                    focus_language = 'f',
                    unfocus_language = 'F',
                    update = 'R',
                    goto_node = '<cr>',
                    show_help = '?',
                },
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
    end
}
