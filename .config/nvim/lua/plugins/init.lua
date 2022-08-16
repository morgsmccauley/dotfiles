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
      use 'jiangmiao/auto-pairs'
      use 'alvan/vim-closetag'
      use 'tpope/vim-surround'
      use 'tpope/vim-repeat'
      use 'nathom/filetype.nvim'
      use 'mfussenegger/nvim-dap'
      use 'szw/vim-maximizer'
      use {
        'mfussenegger/nvim-dap',
        requires = {
          'rcarriga/nvim-dap-ui'
        },
        config = function()
          require("dapui").setup()
          require'plugins/config/nvim-dap'
        end
      }
      use {
        'kyazdani42/nvim-web-devicons',
        config = function()
          require'plugins/config/nvim-web-devicons'
        end
      }
      use {
        'kyazdani42/nvim-tree.lua',
        config = function()
          require'plugins/config/nvim-tree'
        end
      }
      use {
        'lewis6991/gitsigns.nvim',
        config = function()
          require'plugins/config/gitsigns'
        end
      }
      use {
        'nvim-lualine/lualine.nvim',
        config = function()
          require'plugins/config/lualine'
        end
      }
      use({
        "catppuccin/nvim",
        as = "catppuccin",
        config = function ()
          require'plugins/config/catppuccin'
        end
      })
      use {
        'norcalli/nvim-colorizer.lua',
        config = function()
          require'colorizer'.setup()
        end
      }
      use {
        'phaazon/hop.nvim',
        config = function()
          require'plugins/config/hop'
        end
      }
      use {
        'b3nj5m1n/kommentary',
        config = function()
          require'plugins/config/kommentary'
        end
      }
      use {
        'folke/which-key.nvim',
        config = function()
          require'plugins/config/which-key-nvim'
        end
      }
      use {
        'sindrets/diffview.nvim'
      }
      use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
          require'plugins/config/indent-blankline'
        end
      }
      use {
        'neovim/nvim-lspconfig',
        config = function()
          require'plugins/config/nvim-lspconfig'
        end
      }
      use {
        'tpope/vim-fugitive'
      }
      use {
        'ruanyl/vim-gh-line',
        config = function()
          require'plugins/config/vim-gh-line'
        end
      }
      use {
        'simrat39/symbols-outline.nvim',
        config = function()
          require'plugins/config/symbols-outline'
        end
      }
      use {
        'vim-test/vim-test',
        config = function()
          require'plugins/config/vim-test'
        end
      }
      use {
        'williamboman/nvim-lsp-installer',
        config = function()
          require 'plugins/config/nvim-lsp-installer'
        end,
        requires = {
          {'neovim/nvim-lspconfig'}
        }
      }
      use {
        'L3MON4D3/LuaSnip',
        requires = {
          {'rafamadriz/friendly-snippets'}
        },
        config = function()
          require 'luasnip'.filetype_extend("typescript", {"javascript"})
        end
      }
      use {
        'hrsh7th/nvim-cmp',
        requires = {
          {'hrsh7th/cmp-nvim-lsp'},
          {'hrsh7th/cmp-path'},
          {'hrsh7th/cmp-buffer'},
          {'saadparwaiz1/cmp_luasnip'}
        },
        config = function()
          require'plugins/config/nvim-cmp'
        end
      }
      use {
        'TimUntersberger/neogit',
        requires = {
          {'nvim-lua/plenary.nvim'}
        },
        config = function()
          require'plugins/config/neogit'
        end
      }
      use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
          {'sheerun/vim-polyglot'},
          -- doesnt work with which key https://github.com/romgrk/nvim-treesitter-context/issues/40
          -- {'romgrk/nvim-treesitter-context'}
        },
        run = ':TSUpdate',
        config = function()
          require'plugins/config/nvim-treesitter'
        end
      }
      use {
        'Shatur/neovim-session-manager',
        config = function ()
          require'plugins.config.neovim-session-manager'
        end
      }
      use {
        'nvim-telescope/telescope.nvim',
        requires = {
          {'nvim-lua/popup.nvim'},
          {'nvim-lua/plenary.nvim'},
          {'nvim-telescope/telescope-media-files.nvim'},
          {'nvim-telescope/telescope-github.nvim'},
          {'nvim-telescope/telescope-ui-select.nvim'},
          {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        },
        config = function()
          require'plugins/config/telescope-nvim'
        end
      }
      use {
        'akinsho/toggleterm.nvim',
        config = function()
          require'plugins/config/toggleterm'
        end
      }
  end
)
