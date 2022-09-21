require('gitsigns').setup {
    signs = {
        add = { text = '▌' },
        change = { text = '▌' },
    },
    watch_gitdir = {
        interval = 100
    },
}
