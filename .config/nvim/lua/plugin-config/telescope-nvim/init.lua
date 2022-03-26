local builtin = require'telescope.builtin'
local telescope = require'telescope'
local actions = require'telescope.actions'
local previewers = require('telescope.previewers')

telescope.setup {
  defaults = {
    -- scroll_strategy = 'limit',
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
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-f>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-e>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.toggle_all,
        ["<C-\\>n"] = { "<esc>", type = "command" },
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
  jira = require('plugin-config.telescope-nvim.jira'),
  buffers = function ()
    builtin.buffers({
      show_all_buffers = true,
      sort_mru = true,
      ignore_current_buffer = true,
      attach_mappings = function(_, map)
        map('i', '<C-x>', actions.delete_buffer)
        return true
      end
    })
  end,
  commits = require('plugin-config.telescope-nvim.commits'),
  bcommits = function()
    builtin.git_bcommits({
      -- previewer = previewers.git_commit_diff_as_was.new({})
    })
  end,
  branches = require('plugin-config.telescope-nvim.branches'),
  stash = require('plugin-config.telescope-nvim.stash'),
}
