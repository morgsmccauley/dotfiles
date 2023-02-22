return {
    'kyazdani42/nvim-tree.lua',
    cmd = { 'NvimTreeFindFileToggle' },
    setup = function()
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
                hide_root_folder = true,
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

        --[[ vim.cmd 'hi NvimTreeGitDirty NONE'
    vim.cmd 'hi NvimTreeGitStaged NONE'
    vim.cmd 'hi NvimTreeGitMerge NONE'
    vim.cmd 'hi NvimTreeGitRenamed NONE'
    vim.cmd 'hi NvimTreeGitNew NONE'
    vim.cmd 'hi NvimTreeGitDeleted NONE' ]]
        --[[ vim.fn.sign_define('NvimTreeSignError', { texthl = 'NvimTreeSignError', text = '' })
    vim.fn.sign_define('NvimTreeSignHint', { texthl = 'NvimTreeSignError', text = '' })
    vim.fn.sign_define('NvimTreeSignWarning', { texthl = 'NvimTreeSignError', text = '' })
    vim.fn.sign_define('NvimTreeSignInformation', { texthl = 'NvimTreeSignError', text = '' }) ]]
    end
}