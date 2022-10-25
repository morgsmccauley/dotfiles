vim.o.termguicolors = true

require 'nvim-tree'.setup {
    hijack_netrw = true,
    sync_root_with_cwd = true,
    hijack_cursor = true,
    update_focused_file = {
        enable = true,
    },
    git = {
        enable = true,
        ignore = false
    },
    renderer = {
        special_files = {},
        -- doesnt work well with hidden=true
        -- highlight_opened_files = 'name',
        indent_markers = {
            enable = true
        },
        highlight_git = true,
        icons = {
            show = {
                git = false
            },
            glyphs = {
                folder = {
                    default = '',
                    open = '',
                    symlink = ''
                }
            },
        }
    },
    view = {
        width = 50,
        mappings = {
            list = {
                { key = '<C-e>', action = '' },
                { key = '<C-j>', action = '' },
                { key = '<C-k>', action = '' },
                { key = '<C-t>', action = '' },
            }
        }
    },
    actions = {
        open_file = {
            window_picker = {
                enable = false
            }
        }
    }
}
