local action_state = require'telescope.actions.state'
local builtin = require'telescope.builtin'
local utils = require'telescope.utils'
local actions = require'telescope.actions'

return function()
  builtin.git_stash({
    attach_mappings = function (_, map)
      local pop = function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local _, ret, stderr = utils.get_os_command_output({ 'git', 'stash', 'pop', '--index', selection.value })
        actions.close(prompt_bufnr)
        if ret == 0 then
          print("popped: " .. selection.value)
        else
          print(string.format(
            'Error when popping: %s. Git returned: "%s"',
            selection.value,
            table.concat(stderr, '  ')
          ))
        end
      end

      local drop = function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local _, ret, stderr = utils.get_os_command_output({ 'git', 'stash', 'drop', selection.value })
        actions.close(prompt_bufnr)
        if ret == 0 then
          print("dropped: " .. selection.value)
        else
          print(string.format(
            'Error when dropping: %s. Git returned: "%s"',
            selection.value,
            table.concat(stderr, '  ')
          ))
        end
      end

      map('i', '<C-x>', drop)
      map('i', '<C-p>', pop)

      return true
    end
  })
end
