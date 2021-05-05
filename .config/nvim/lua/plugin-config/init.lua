require'plugin-config/galaxyline'
require'plugin-config/gitsigns'
require'plugin-config/nvim-tree'
require'plugin-config/nvim-treesitter'
require'plugin-config/nvim-web-devicons'
require'plugin-config/telescope-nvim'
require'plugin-config/vim-which-key'
require'plugin-config/kommentary'
require'plugin-config/vim-sneak'

require'colorizer'.setup()

-- too lazy to migrate to lua yet
vim.api.nvim_command 'source ~/.config/nvim/lua/plugin-config/fzf.vim'
