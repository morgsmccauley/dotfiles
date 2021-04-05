local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
  execute 'PackerInstall'
end

vim.cmd("autocmd BufWritePost plugins.lua PackerCompile")

return require("packer").startup(
    function(use)
        use 'wbthomason/packer.nvim'
        use 'kyazdani42/nvim-web-devicons'
        use 'kyazdani42/nvim-tree.lua'
        use 'lewis6991/gitsigns.nvim'
        use 'glepnir/galaxyline.nvim'
        use 'nvim-treesitter/nvim-treesitter'
        use 'chriskempson/base16-vim'
        use 'norcalli/nvim-colorizer.lua'
        use 'neovim/nvim-lspconfig'
        use 'hrsh7th/nvim-compe'
        use 'jiangmiao/auto-pairs'
        use 'alvan/vim-closetag'
        use 'tweekmonster/startuptime.vim'
        use 'onsails/lspkind-nvim'
        use 'tpope/vim-surround'
        use 'tpope/vim-fugitive'
        use 'tpope/vim-repeat'
        use 'mhinz/vim-startify'
        use 'b3nj5m1n/kommentary'
        use 'kosayoda/nvim-lightbulb'
        use {
          'nvim-telescope/telescope.nvim',
          requires = {
            {'nvim-lua/popup.nvim'},
	    {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-media-files.nvim'}
          }
        }
        use {
	  'liuchengxu/vim-which-key',
	  requires = {{'AckslD/nvim-whichkey-setup.lua'}}
        }
        use {
          'junegunn/fzf.vim',
          requires = {{'junegunn/fzf'}},
          run = 'fzf#install'
        }
    end
)
