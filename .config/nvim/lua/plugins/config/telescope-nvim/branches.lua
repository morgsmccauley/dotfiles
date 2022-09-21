local action_state = require 'telescope.actions.state'
local builtin = require 'telescope.builtin'
local utils = require 'telescope.utils'
local actions = require 'telescope.actions'

return function()
  builtin.git_branches({
    attach_mappings = function(_, map)
      local checkout = function(prompt_bufnr)
        local cwd = action_state.get_current_picker(prompt_bufnr).cwd
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        local branch = selection.value
        local is_remote = string.find(branch, 'origin/')

        local ret
        local stderr
        if is_remote then
          _, ret, stderr = utils.get_os_command_output({ 'git', 'checkout', '-t', branch }, cwd)
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
      end

      map('i', '<C-d>', actions.preview_scrolling_down)
      map('i', '<C-x>', actions.git_delete_branch)
      map('i', '<C-n>', actions.git_create_branch)
      map('i', '<Cr>', checkout)

      return true
    end
  })
end
