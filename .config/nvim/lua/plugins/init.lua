local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(
  function(use)
    use 'nvim-lua/plenary.nvim'
    use 'wbthomason/packer.nvim'
    use 'jiangmiao/auto-pairs'
    use 'alvan/vim-closetag'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'nathom/filetype.nvim'
    use 'lewis6991/impatient.nvim'
    use 'szw/vim-maximizer'
    use '~/Developer/Repositories/http-client.nvim'
    --[[ use {
      "Pocco81/auto-save.nvim",
      config = function()
         require("auto-save").setup {}
      end,
    } ]]
    use {
      'f-person/auto-dark-mode.nvim',
      config = function()
        require 'plugins/config/auto-dark-mode'
      end
    }
    use {
      'mfussenegger/nvim-dap',
      requires = {
        'nvim-telescope/telescope-dap.nvim'
      },
      config = function()
        require 'plugins/config/nvim-dap'
      end
    }
    use {
      'kyazdani42/nvim-web-devicons',
      config = function()
        require 'plugins/config/nvim-web-devicons'
      end
    }
    use {
      'kyazdani42/nvim-tree.lua',
      cmd = { 'NvimTreeFindFileToggle' },
      config = function()
        require 'plugins/config/nvim-tree'
      end
    }
    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require 'plugins/config/gitsigns'
      end
    }
    use {
      'nvim-lualine/lualine.nvim',
      config = function()
        require 'plugins/config/lualine'
      end
    }
    use({
      "catppuccin/nvim",
      as = "catppuccin",
      run = ":CatppuccinCompile",
      config = function()
        require 'plugins/config/catppuccin'
      end
    })
    use {
      'norcalli/nvim-colorizer.lua',
      opt = true,
      config = function()
        require 'colorizer'.setup()
      end
    }
    use {
      'phaazon/hop.nvim',
      config = function()
        require 'plugins/config/hop'
      end
    }
    use {
      'b3nj5m1n/kommentary',
      config = function()
        require 'plugins/config/kommentary'
      end
    }
    use {
      'folke/which-key.nvim',
      keys = { '<leader>', '"', '\'', '`' },
      config = function()
        require 'plugins/config/which-key-nvim'
      end
    }
    use {
      'sindrets/diffview.nvim',
      opt = true,
      cmd = 'DiffviewOpen',
      module = 'neogit/integrations/diffview'
    }
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require 'plugins/config/indent-blankline'
      end
    }
    use {
      'neovim/nvim-lspconfig',
      config = function()
        require 'plugins/config/nvim-lspconfig'
      end
    }
    use {
      'ruanyl/vim-gh-line',
      config = function()
        require 'plugins/config/vim-gh-line'
      end
    }
    use {
      'vim-test/vim-test',
      config = function()
        require 'plugins/config/vim-test'
      end
    }
    use {
      'williamboman/mason.nvim',
      config = function()
        require 'plugins/config/mason'
      end,
      requires = {
        { 'williamboman/mason-lspconfig.nvim' },
        { 'neovim/nvim-lspconfig' }
      }
    }
    use {
      'rafamadriz/friendly-snippets',
      event = 'InsertEnter',
    }
    use {
      'L3MON4D3/LuaSnip',
      after = 'friendly-snippets',
      config = function()
        require 'luasnip'.filetype_extend('typescript', { 'javascript' })
      end
    }
    use {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      config = function()
        require 'plugins/config/nvim-cmp'
      end
    }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }

    use {
      'TimUntersberger/neogit',
      cmd = { 'Neogit' },
      config = function()
        require 'plugins/config/neogit'
      end
    }
    use {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        { 'sheerun/vim-polyglot' },
        -- doesnt work with which key https://github.com/romgrk/nvim-treesitter-context/issues/40
        -- {'romgrk/nvim-treesitter-context'}
      },
      run = ':TSUpdate',
      config = function()
        require 'plugins/config/nvim-treesitter'
      end
    }
    use {
      'Shatur/neovim-session-manager',
      config = function()
        require 'plugins.config.neovim-session-manager'
      end,
    }
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-telescope/telescope-github.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      },
      --[[ cmd = 'Telescope',
      keys = {'<leader>sl'}, -- need a better way of lazy loading before vim.ui.select
      module = 'plugins/config/telescope-nvim', ]]
      config = function()
        require 'plugins/config/telescope-nvim'
      end
    }
    use {
      'akinsho/toggleterm.nvim',
      cmd = 'ToggleTerm',
      config = function()
        require 'plugins/config/toggleterm'
      end
    }

    if packer_bootstrap then
      require('packer').sync()
    end
  end
)
