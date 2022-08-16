local action_state = require'telescope.actions.state'
local builtin = require'telescope.builtin'
local utils = require'telescope.utils'
local actions = require'telescope.actions'
local previewers = require('telescope.previewers')
local Job = require "plenary.job"

function GetOsCommandOutput(cmd, cwd, env)
  if type(cmd) ~= "table" then
    print "Telescope: [GetOsCommandOutput]: cmd has to be a table"
    return {}
  end
  local command = table.remove(cmd, 1)
  local stderr = {}
  local stdout, ret = Job
    :new({
      command = command,
      args = cmd,
      cwd = cwd,
      env = env,
      on_stderr = function(_, data)
        table.insert(stderr, data)
      end,
    })
    :sync()
  return stdout, ret, stderr
end

return function()
  builtin.git_commits({
    -- previewer = previewers.git_commit_diff_as_was.new({}),
    attach_mappings = function(_, map)
      local fixup = function(prompt_bufnr)
        local cwd = action_state.get_current_picker(prompt_bufnr).cwd
        local commit = action_state.get_selected_entry().value

        local confirmation = vim.fn.input('Fix up commit: ' .. commit .. '? [Y/n] ')
        if string.lower(confirmation) ~= 'y' then return end
        print' '

        actions.close(prompt_bufnr)

        vim.api.nvim_command('silent !git commit --fixup '..commit)

        print('Created fixup commit')

        vim.api.nvim_command('silent !GIT_SEQUENCE_EDITOR=: git rebase -i --autostash --autosquash '..commit..'~1')

        print('Squashed commit: ' .. commit)
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
      map('i', '<C-r>', interactive_rebase)

      return true
    end
  })
end
