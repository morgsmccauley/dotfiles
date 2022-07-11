local builtin = require'telescope.builtin'
local pickers = require'telescope.pickers'
local finders = require'telescope.finders'
local telescope = require'telescope'
local actions = require'telescope.actions'
local conf = require("telescope.config").values

telescope.setup {
  defaults = {
    -- scroll_strategy = 'limit',
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
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-f>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-e>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.toggle_all,
        ["<C-/>"] = actions.which_key,
        ["<C-\\>n"] = { "<esc>", type = "command" },
      },
    },
    set_env = {['COLORTERM'] = 'truecolor'},
    -- removes all files with *git* in them
    -- file_ignore_patterns = { '.git/*' }
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
telescope.load_extension('ui-select')

return {
  jira = require('plugins/config/telescope-nvim/jira'),
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
  commits = require('plugins/config/telescope-nvim/commits'),
  bcommits = function()
    builtin.git_bcommits({
      -- previewer = previewers.git_commit_diff_as_was.new({})
    })
  end,
  branches = require('plugins/config/telescope-nvim/branches'),
  stash = require('plugins/config/telescope-nvim/stash'),
}
