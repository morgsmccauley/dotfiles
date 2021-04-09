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
    'c_sharp',
    'graphql',
    'comment',
    'jsdoc',
    'json',
    'toml',
    'tsx'
  },
  highlight = {
    enable = true,
    use_languagetree = true
  }
}
