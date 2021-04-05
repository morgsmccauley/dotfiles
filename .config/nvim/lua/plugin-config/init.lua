-- complex setup
require('plugin-config/galaxyline')
require('plugin-config/gitsigns')
require('plugin-config/nvim-lspconfig')
require('plugin-config/nvim-tree')
require('plugin-config/nvim-treesitter')
require('plugin-config/nvim-web-devicons')
require('plugin-config/telescope-nvim')
require('plugin-config/vim-which-key')
require('plugin-config/vim-startify')

-- minimal setup
require'colorizer'.setup()
--require('nvim-autopairs').setup()
require('lspkind').init(
    {
        File = ' '
    }
)

require('kommentary')
vim.g.kommentary_create_default_mappings = false

-- too lazy to migrate to lua yet
vim.api.nvim_command 'source ~/.config/nvim/lua/plugin-config/fzf.vim'

vim.cmd('autocmd BufEnter * lua require\'completion\'.on_attach()')

vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

require'nvim-lightbulb'.update_lightbulb {
    sign = {
        enabled = false,
    },
    virtual_text = {
        enabled = true,
        text = "💡",
    }
}
