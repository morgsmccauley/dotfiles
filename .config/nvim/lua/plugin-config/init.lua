-- complex setup
require('plugin-config/galaxyline')
require('plugin-config/gitsigns')
require('plugin-config/nvim-lspconfig')
require('plugin-config/nvim-tree')
require('plugin-config/nvim-treesitter')
require('plugin-config/nvim-web-devicons')
require('plugin-config/telescope-nvim')
require('plugin-config/vim-which-key')

-- minimal setup
require 'colorizer'.setup()
require('nvim-autopairs').setup()
require('lspkind').init(
    {
        File = ' '
    }
)
vim.g.startify_disable_at_vimenter = 1

-- too lazy to migrate to lua yet
vim.api.nvim_command 'source ~/.config/nvim/lua/plugin-config/fzf.vim'
