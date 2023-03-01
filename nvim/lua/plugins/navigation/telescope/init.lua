return {
  'nvim-telescope/telescope.nvim',
  after = 'telescope-ui-select.nvim',
  requires = {
    {
      'nvim-telescope/telescope-ui-select.nvim',
      module = { 'telescope', 'plugins/navigation/telescope' },
      cmd = { 'Telescope', 'TelescopeCommits', 'TelescopeBranches', 'TelescopeStash', 'TelescopeBuffers' },
    },
    {
      'nvim-telescope/telescope-github.nvim',
      after = 'telescope-ui-select.nvim'
    },
    {

      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
      after = 'telescope-ui-select.nvim'
    },
  },
  config = function()
    local builtin = require 'telescope.builtin'
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'

    telescope.setup {
      defaults = {
        layout_strategy = 'flex',
        history = {
          limit = 500
        },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden',
          '-g',
          '!.git',
        },
        mappings = {
          i = {
            ['<esc>'] = actions.close,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-f>'] = actions.send_selected_to_qflist + actions.open_qflist,
            ['<C-e>'] = actions.cycle_previewers_next,
            ['<C-a>'] = actions.toggle_all,
            ['<C-/>'] = actions.which_key,
            ['<C-\\>n'] = { '<esc>', type = 'command' },
          },
        },
        set_env = { ['COLORTERM'] = 'truecolor' },
      },
      extensions = {
        fzf = {
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
        media_files = {
          filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
          find_cmd = 'rg'
        }
      }
    }

    telescope.load_extension('fzf')
    telescope.load_extension('gh')
    telescope.load_extension('ui-select')

    vim.api.nvim_create_user_command('TelescopeBuffers', function()
      builtin.buffers({
        show_all_buffers = true,
        sort_mru = true,
        ignore_current_buffer = true,
        attach_mappings = function(_, map)
          map('i', '<C-x>', actions.delete_buffer)
          return true
        end
      })
    end, {})
    vim.api.nvim_create_user_command('TelescopeCommits', require('plugins/navigation/telescope/commits'), {})
    vim.api.nvim_create_user_command('TelescopeBranches', require('plugins/navigation/telescope/branches'), {})
    vim.api.nvim_create_user_command('TelescopeStash', require('plugins/navigation/telescope/stash'), {})
  end
}
