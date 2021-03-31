-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

return require("packer").startup(
    function()
        use {"wbthomason/packer.nvim", opt = true}
        use {"kyazdani42/nvim-web-devicons"}
        use {"kyazdani42/nvim-tree.lua"}
        use {"lewis6991/gitsigns.nvim"}
        use {"glepnir/galaxyline.nvim"}
        use {"nvim-treesitter/nvim-treesitter"}
        use {"chriskempson/base16-vim"}
        use {"norcalli/nvim-colorizer.lua"}
        use {"neovim/nvim-lspconfig"}
        use {"nvim-lua/completion-nvim"}
        use {"windwp/nvim-autopairs"}
        use {"alvan/vim-closetag"}
        use {"tweekmonster/startuptime.vim"}
        use {"onsails/lspkind-nvim"}
        use {
          'nvim-telescope/telescope.nvim',
          requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
        }
        use {"nvim-telescope/telescope-media-files.nvim"}
    end
)
