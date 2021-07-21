local action_state = require'telescope.actions.state'
local builtin = require'telescope.builtin'
local utils = require'telescope.utils'
local actions = require'telescope.actions'

return function()
  builtin.git_commits({
    attach_mappings = function(_, map)
      local fixup = function(prompt_bufnr)
        local cwd = action_state.get_current_picker(prompt_bufnr).cwd
        local commit = action_state.get_selected_entry().value

        local confirmation = vim.fn.input('Fix up commit: ' .. commit .. '? [Y/n] ')
        if string.lower(confirmation) ~= 'y' then return end
        print' '

        actions.close(prompt_bufnr)

        local _, ret, stderr = utils.get_os_command_output({
          'git',
          'commit',
          '--fixup',
          commit,
        }, cwd)

        if ret == 0 then
          print("Created fixup commit for: " .. commit)
        else
          print(string.format(
            'Error when fixing up commit: %s. Git returned: "%s"',
            commit,
            table.concat(stderr, '  ')
          ))
          return
        end

        local _, ret, stderr = utils.get_os_command_output(
          {
            'git',
            'rebase',
            '-i',
            '--autosquash',
            '--autostash',
            commit..'~1'
          },
          cwd,
          { GIT_SEQUENCE_EDITOR = ':' }
        )

        if ret == 0 then
          print('Squashed commit: ' .. commit)
        else
          print(string.format(
            'Error when squashing commit: %s. Git returned: "%s"',
            commit,
            table.concat(stderr, '  ')
          ))
          return
        end
      end

      local soft_reset = function(prompt_bufnr)
        local cwd = action_state.get_current_picker(prompt_bufnr).cwd
        local commit = action_state.get_selected_entry().value

        local confirmation = vim.fn.input('Soft reset to this commit: ' .. commit .. '? [Y/n] ')
        if string.lower(confirmation) ~= 'y' then return end
        print' '

        actions.close(prompt_bufnr)

        local _, ret, stderr = utils.get_os_command_output({
          'git',
          'reset',
          '--soft',
          commit..'~1'
        }, cwd)

        if ret == 0 then
          print("Soft reset to commit: " .. commit)
        else
          print(string.format(
            'Error soft reseting commit: %s. Git returned: "%s"',
            commit,
            table.concat(stderr, '  ')
          ))
          return
        end
      end

      local interactive_rebase = function(prompt_bufnr)
        -- local cwd = action_state.get_current_picker(prompt_bufnr).cwd
        local commit = action_state.get_selected_entry().value

        local confirmation = vim.fn.input('Interactive rebase from commit: ' .. commit .. '? [Y/n] ')
        if string.lower(confirmation) ~= 'y' then return end
        print' '

        actions.close(prompt_bufnr)

        vim.api.nvim_command('silent Git rebase -i --autostash --autosquash '..commit..'~1')
      end

      map('i', '<C-f>', fixup)
      map('i', '<C-s>', soft_reset)
      map('i', '<C-r>', interactive_rebase)

      return true
    end
  })
end
