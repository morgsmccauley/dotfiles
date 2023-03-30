return {
    'kyazdani42/nvim-tree.lua',
    branch = '2088-actions-change-dir-enable-false-does-not-update-tree-root',
    keys = {
        {
            '<C-n>',
            '<Cmd>NvimTreeFindFileToggle<Cr>',
            { silent = true, noremap = true }
        }
    },
    init = function()
        vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#545862' })
        vim.api.nvim_set_hl(0, 'NvimTreeOpenedFile', { underline = true })

        vim.fn.sign_define('NvimTreeSignError', { texthl = 'NvimTreeSignError', text = '' })
        vim.fn.sign_define('NvimTreeSignHint', { texthl = 'NvimTreeSignError', text = '' })
        vim.fn.sign_define('NvimTreeSignWarning', { texthl = 'NvimTreeSignError', text = '' })
        vim.fn.sign_define('NvimTreeSignInformation', { texthl = 'NvimTreeSignError', text = '' })
    end,
    config = function()
        require 'nvim-tree'.setup {
            hijack_netrw = false,
            sync_root_with_cwd = true,
            hijack_cursor = true,
            update_focused_file = {
                enable = true,
            },
            git = {
                show_on_dirs = true,
                enable = true,
                ignore = false
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                icons = {
                    hint = '',
                    info = '',
                    warning = '',
                    error = '',
                }
            },
            renderer = {
                special_files = {},
                highlight_opened_files = 'name',
                root_folder_modifier = ':t',
                indent_markers = {
                    enable = true,
                    icons = {
                        corner = '│'
                    },
                },
                highlight_git = true,
                icons = {
                    show = {
                        git = false,
                        folder_arrow = false
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
                -- hide_root_folder = true,
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
                },
                change_dir = {
                    global = true,
                }
            }
        }
    end
}
