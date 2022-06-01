vim.o.termguicolors = true

require'nvim-tree'.setup{
    disable_netrw = false,
    hijack_netrw = false,
    update_cwd = true,
    hijack_cursor = true,
    update_focused_file = {
        enable = true,
    },
    renderer = {
        special_files = {},
        highlight_opened_files = 'name',
        indent_markers = {
            enable = true
        },
        icons = {
            show = {
                git = false
            },
            glyphs = {
                --[[ default = ' ',
                symlink = ' ', ]]
                folder = {
                    default = '',
                    open = '',
                    symlink = ''
                }
            },
        }
    },
    view = {
        hide_root_folder = true,
        width = 50,
        auto_resize = true,
        mappings = {
            list = {
              { key = "<C-e>", action = "" },
              { key = "<C-j>", action = "" },
              { key = "<C-k>", action = "" },
              { key = "<C-t>", action = "" },
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
