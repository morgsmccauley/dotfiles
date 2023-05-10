return {
  'nvim-telescope/telescope.nvim',
  cmd = { 'Telescope', 'TelescopeCommits', 'TelescopeBranches', 'TelescopeStash', 'TelescopeBuffers' },
  dependencies = {
    {
      'nvim-telescope/telescope-ui-select.nvim',
    },
    {
      'nvim-telescope/telescope-github.nvim',
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  config = function()
    local builtin = require 'telescope.builtin'
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'

    telescope.setup {
      defaults = {
        sorting_strategy = 'ascending',
        layout_strategy = 'vertical',
        layout_config = {
          prompt_position = 'top',
          mirror = true
        },
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
        ['ui-select'] = {
          require('telescope.themes').get_dropdown()
        },
        fzf = {
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      }
    }

    require('telescope').load_extension('ui-select')
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('gh')
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
    vim.api.nvim_create_user_command('TelescopeCommits', require('plugins/telescope/commits'), {})
    vim.api.nvim_create_user_command('TelescopeBranches', require('plugins/telescope/branches'), {})
    vim.api.nvim_create_user_command('TelescopeStash', require('plugins/telescope/stash'), {})

    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'NONE' })
  end
}
