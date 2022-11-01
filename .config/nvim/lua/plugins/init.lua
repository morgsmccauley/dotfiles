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
    use {
      'RRethy/vim-illuminate',
      config = function()
        require('plugins/config/vim-illuminate')
      end
    }
    use {
      'simrat39/rust-tools.nvim',
      config = function()
        require 'plugins/config/rust-tools'
      end
    }
    use {
      'pwntester/octo.nvim',
      cmd = 'Octo',
      config = function()
        require 'octo'.setup()
      end
    }
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
      'catppuccin/nvim',
      as = 'catppuccin',
      run = ':CatppuccinCompile',
      config = function()
        require 'plugins/config/catppuccin'
      end
    })
    use {
      'ggandor/leap.nvim',
      config = function()
        require 'plugins/config/leap'
      end
    }
    use {
      'ggandor/flit.nvim',
      config = function()
        require 'flit'.setup({
          keys = { f = 'f', F = 'F', t = 't', T = 'T' },
          labeled_modes = 'nv',
          multiline = false,
        })
      end
    }
    use {
      'numToStr/Comment.nvim',
      config = function()
        require 'plugins/config/comment'
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
      module = 'neogit/integrations/diffview',
      config = function()
        require 'diffview'.setup {
          enhanced_diff_hl = true
        }
      end
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
      'onsails/lspkind.nvim',
      event = 'InsertEnter',
    }
    use {
      'hrsh7th/nvim-cmp',
      after = 'lspkind.nvim',
      config = function()
        require 'plugins/config/nvim-cmp'
      end
    }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp' }

    use {
      'TimUntersberger/neogit',
      module = 'neogit',
      config = function()
        require 'plugins/config/neogit'
      end
    }
    use {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        { 'sheerun/vim-polyglot' },
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
        { 'romgrk/nvim-treesitter-context' }
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
      -- cmd = { 'Telescope', 'SessionManager' },
      -- module = 'plugins/config/telescope-nvim',
      config = function()
        require 'plugins/config/telescope-nvim'
      end
    }
    use {
      'akinsho/toggleterm.nvim',
      cmd = { 'ToggleTerm', 'TermExec' },
      config = function()
        require 'plugins/config/toggleterm'
      end
    }

    if packer_bootstrap then
      require('packer').sync()
    end
  end
)
