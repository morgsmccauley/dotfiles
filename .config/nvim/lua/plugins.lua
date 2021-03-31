local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

vim.cmd("autocmd BufWritePost plugins.lua PackerCompile")

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
        use {"liuchengxu/vim-which-key"}
    end
)
