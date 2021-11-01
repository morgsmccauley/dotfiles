require'plugin-config/gitsigns'
require'plugin-config/nvim-tree'
require'plugin-config/nvim-treesitter'
require'plugin-config/nvim-web-devicons'
require'plugin-config/telescope-nvim'
require'plugin-config/kommentary'
--lequire'plugin-config/vim-sneak'
require'plugin-config/tokyonight'
require'plugin-config/which-key-nvim'
require'plugin-config/coc-nvim'
require'plugin-config/galaxyline'
--require'plugin-config/neogit'
require'plugin-config/nvim-lspconfig'
require'plugin-config/nvim-cmp'
require'plugin-config/indent-blankline'

require'dark_notify'.run()
require'colorizer'.setup()

-- too lazy to migrate to lua yet
vim.api.nvim_command 'source ~/.config/nvim/lua/plugin-config/fzf.vim'
