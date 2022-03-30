vim.o.termguicolors = true

vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_root_folder_modifier = ':~'
vim.g.nvim_tree_allow_resize = 1
vim.g.nvim_tree_highlight_opened_files = true
vim.g.nvim_tree_special_files = {}

vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1
}

vim.g.nvim_tree_icons = {
    default = ' ',
    symlink = ' ',
    git = {
        unstaged = '✗',
        staged = '✓',
        unmerged = '',
        renamed = '➜',
        untracked = '★'
    },
    folder = {
        default = '',
        open = '',
        symlink = ''
    }
}

require'nvim-tree'.setup{
    disable_netrw = false,
    hijack_netrw = false,
    update_cwd = true,
    ignore = { '.git', '.DS_STORE' },
    hijack_cursor = true,
    update_focused_file = {
        enable = true,
    },
    view = {
        width = 50,
        auto_resize = true,
        mappings = {
            list = {
              { key = "<C-e>", action = "" },
            }
        }
    },
    git = {
        ignore = false
    },
    actions = {
        open_file = {
            window_picker = {
                enable = false
            }
        }
    }
}
