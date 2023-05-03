return {
    'kyazdani42/nvim-tree.lua',
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
        local api = require 'nvim-tree.api'

        require 'nvim-tree'.setup {
            on_attach = function(bufnr)
                api.config.mappings.default_on_attach(bufnr)

                vim.keymap.set('n', '<C-e>', '', { buffer = bufnr })
                vim.keymap.del('n', '<C-e>', { buffer = bufnr })
                vim.keymap.set('n', '<C-j>', '', { buffer = bufnr })
                vim.keymap.del('n', '<C-j>', { buffer = bufnr })
                vim.keymap.set('n', '<C-k>', '', { buffer = bufnr })
                vim.keymap.del('n', '<C-k>', { buffer = bufnr })
                vim.keymap.set('n', '<C-t>', '', { buffer = bufnr })
                vim.keymap.del('n', '<C-t>', { buffer = bufnr })
            end,
            hijack_netrw = true,
            hijack_cursor = true,
            sync_root_with_cwd = true,
            hijack_directories = {
                enable = true,
                auto_open = true,
            },
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
                width = 50,
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
