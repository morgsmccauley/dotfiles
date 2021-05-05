local telescope = require'telescope'
local actions = require'telescope.actions'
local action_state = require'telescope.actions.state'
local builtin = require'telescope.builtin'
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local utils = require('telescope.utils')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
    set_env = {['COLORTERM'] = 'truecolor'},
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

telescope.load_extension('fzf')
telescope.load_extension('media_files')
telescope.load_extension('gh')
telescope.load_extension('session_manager')

local M = {}

M.buffers = function()
  builtin.buffers({
    show_all_buffers = true,
    sort_lastused = true,
    attach_mappings = function(_, map) 
      map('i', '<C-x>', function(prompt_bufnr)
        local picker = actions.get_current_picker(prompt_bufnr)
        local multi_selection = picker:get_multi_selection()
        if (next(multi_selection) ~= nil) then
          for _, selected in ipairs(multi_selection) do
            pcall(vim.cmd, string.format([[silent bdelete! %s]], selected.bufnr))
          end
          actions.close(prompt_bufnr)
          return
        end

        local selected = actions.get_selected_entry()
        pcall(vim.cmd, string.format([[silent bdelete! %s]], selected.bufnr))
        actions.close(prompt_bufnr)
      end)

      return true
    end
  })
end

M.branches = function()
  builtin.git_branches({
    attach_mappings = function(_, map)
      map('i', '<C-d>', actions.preview_scrolling_down)
      map('i', '<C-x>', actions.git_delete_branch)
      map('i', '<C-n>', actions.git_create_branch)
      map('i', '<Cr>', function(prompt_bufnr)
        local cwd = action_state.get_current_picker(prompt_bufnr).cwd
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        local branch = selection.value
        local is_remote = string.find(branch, 'origin/')

        local ret
        local stderr
        if is_remote then
          _, ret, stderr = utils.get_os_command_output({ 'git', 'checkout',  '-t', branch }, cwd)
        else
          _, ret, stderr = utils.get_os_command_output({ 'git', 'checkout', branch }, cwd)
        end

        if ret == 0 then
          print("Checked out: " .. selection.value)
        else
          print(string.format(
            'Error when checking out: %s. Git returned: "%s"',
            selection.value,
            table.concat(stderr, '  ')
          ))
        end
      end)

      return true
    end
  })
end

M.sessions = function()
  local results = utils.get_os_command_output({
    'ls',
    '-tA',
    '/Users/morganmccauley/.local/share/nvim/session',
    '|',
    'grep',
    '-v',
    '__LAST__',
  })
  pickers.new({}, {
    prompt_title = 'Sessions',
    finder = finders.new_table(results),
    attach_mappings = function()
      actions.select_default:replace(function(prompt_bufnr)
        local selected = actions.get_selected_entry()
        vim.api.nvim_command('SLoad! '..selected[1])
      end)

      return true
    end
  }):find()
end

return M
