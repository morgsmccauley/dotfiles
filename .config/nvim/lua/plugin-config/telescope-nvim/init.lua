local telescope = require'telescope'
local actions = require'telescope.actions'

telescope.setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
    set_env = {['COLORTERM'] = 'truecolor'},
    file_ignore_patterns = { '.git/*' }
  },
  extensions = {
    fzf = {
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    media_files = {
      filetypes = {'png', 'webp', 'jpg', 'jpeg'},
      find_cmd = 'rg'
    }
  }
}

--telescope.load_extension('media_files')
telescope.load_extension('fzf')
telescope.load_extension('gh')
telescope.load_extension('session_manager')
telescope.load_extension('coc')

return {
  buffers = require('plugin-config.telescope-nvim.buffers'),
  commits = require('plugin-config.telescope-nvim.commits'),
  branches = require('plugin-config.telescope-nvim.branches'),
  stash = require('plugin-config.telescope-nvim.stash'),
}
