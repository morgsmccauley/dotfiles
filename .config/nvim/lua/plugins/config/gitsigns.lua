require('gitsigns').setup {
    signs = {
        add = { text = '▌' },
        change = { text = '▌' },
        untracked = { text = '▌' },
    },
    watch_gitdir = {
        interval = 100
    },
}
