require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'javascript',
        'typescript',
        'html',
        'css',
        'bash',
        'cpp',
        'rust',
        'lua',
        'c_sharp'
    },
    highlight = {
        enable = true,
        use_languagetree = true
    }
}
