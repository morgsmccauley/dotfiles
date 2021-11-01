local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packloadall'
  execute 'PackerInstall'
end

return require("packer").startup(
    function(use)
        use 'wbthomason/packer.nvim'
        use 'kyazdani42/nvim-web-devicons'
        use 'kyazdani42/nvim-tree.lua'
        use 'lewis6991/gitsigns.nvim'
        use 'glepnir/galaxyline.nvim'
        use 'folke/tokyonight.nvim'
        use 'norcalli/nvim-colorizer.lua'
        use 'jiangmiao/auto-pairs'
        use 'alvan/vim-closetag'
        use 'tweekmonster/startuptime.vim'
        use 'tpope/vim-surround'
        -- use 'tpope/vim-fugitive'
        use 'tpope/vim-repeat'
        use 'phaazon/hop.nvim'
        use 'b3nj5m1n/kommentary'
        use 'folke/which-key.nvim'
        use 'sindrets/diffview.nvim'
        use 'pantharshit00/vim-prisma'
        --use 'pwntester/octo.nvim'
        use 'neovim/nvim-lspconfig'
        use 'cormacrelf/dark-notify'
        use 'tpope/vim-fugitive'
        use {
          'hrsh7th/nvim-cmp',
          requires = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-buffer'}
          }
        }
        -- use {
          -- 'TimUntersberger/neogit',
          -- requires = 'nvim-lua/plenary.nvim'
        -- }
        --[[ use {
          'neoclide/coc.nvim',
          -- make sure yarn is installed
          run = 'yarn install --frozen-lockfile'
        } ]]
        use {
          'nvim-treesitter/nvim-treesitter',
          requires = {
            {'sheerun/vim-polyglot'},
            -- doesnt work with which key https://github.com/romgrk/nvim-treesitter-context/issues/40
            -- {'romgrk/nvim-treesitter-context'}
          },
          run = ':TSUpdate'
        }
        use {
          'morgsmccauley/neovim-session-manager',
          branch = 'stable'
        }
        use {
          'nvim-telescope/telescope.nvim',
          requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-media-files.nvim'},
            {'nvim-telescope/telescope-github.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            {'fannheyward/telescope-coc.nvim'}
          }
        }
        use {
          'junegunn/fzf.vim',
          requires = {{'junegunn/fzf'}},
          run = 'call fzf#install'
        }
    end
)
