require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'javascript',
        'html',
        'css',
        'bash',
        'cpp',
        'rust',
        'lua'
    },
    highlight = {
        enable = true,
        use_languagetree = true
    }
}
