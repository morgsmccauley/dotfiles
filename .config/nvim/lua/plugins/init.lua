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
    use 'wbthomason/packer.nvim'
    use 'jiangmiao/auto-pairs'
    use 'alvan/vim-closetag'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'nathom/filetype.nvim'
    use 'lewis6991/impatient.nvim'
    use '~/Developer/Repositories/http-client.nvim'
    use 'nvim-lua/plenary.nvim'
    use {
      'folke/neodev.nvim',
      config = function()
        require('neodev').setup()
      end
    }
    use {
      'szw/vim-maximizer',
      cmd = 'MaximizerToggle'
    }
    use {
      'ray-x/lsp_signature.nvim',
      event = 'InsertEnter',
      config = function()
        require('lsp_signature').setup({
          bind = true,
          hint_enable = false,
        })
      end
    }
    use {
      'RRethy/vim-illuminate',
      config = function()
        require('plugins/config/vim-illuminate')
      end
    }
    use {
      'simrat39/rust-tools.nvim',
      ft = 'rust',
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
      module = 'dap',
      requires = {
        'nvim-telescope/telescope-dap.nvim'
      },
      config = function()
        require 'plugins/config/nvim-dap'
      end
    }
    use {
      'kyazdani42/nvim-web-devicons',
      module = 'nvim-web-devicons',
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
      keys = { 's', 'S', 'f', 'F', 't', 'T' },
      config = function()
        require 'plugins/config/leap'
      end
    }
    use {
      'ggandor/flit.nvim',
      after = 'leap.nvim',
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
      cmd = { 'TestFile', 'TestLast', 'TestNearest', 'TestSuite' },
      config = function()
        require 'plugins/config/vim-test'
      end
    }
    use {
      'williamboman/mason.nvim',
      after = 'neodev.nvim',
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
      'tpope/vim-fugitive',
      cmd = 'Git',
    }
    use {
      'nvim-treesitter/nvim-treesitter',
      branch = 'v0.8.0',
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
      'nvim-telescope/telescope-ui-select.nvim',
      module = { 'telescope', 'plugins/config/telescope-nvim' },
      cmd = 'Telescope',
    }
    use {
      'nvim-telescope/telescope-github.nvim',
      after = 'telescope-ui-select.nvim'
    }
    use {

      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
      after = 'telescope-ui-select.nvim'
    }
    use {
      'nvim-telescope/telescope.nvim',
      after = 'telescope-ui-select.nvim',
      requires = {
        'nvim-lua/popup.nvim',
      },
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
