local action_state = require 'telescope.actions.state'
local previewers = require('telescope.previewers')
local utils = require('telescope.utils')
local defaulter = utils.make_default_callable
local putils = require('telescope.previewers.utils')
local actions = require('telescope.actions')
local finders = require('telescope.finders')
local previewers = require('telescope.previewers')
local pickers = require('telescope.pickers')
local conf = require('telescope.config').values
local make_entry = require('telescope.make_entry')
local utils = require('telescope.utils')
local popup = require('popup')

local issue_previewer = function(opts)
  return previewers.new_buffer_previewer {
    get_buffer_by_name = function(_, entry)
      return entry.ticket
    end,

    define_preview = function(self, entry, status)
      local filetype = 'yaml'

      putils.job_maker({ 'jira', 'view', entry.ticket }, self.state.bufnr, {
        value = entry.value .. filetype,
        bufname = self.state.bufname,
        cwd = opts.cwd
      })

      putils.regex_highlighter(self.state.bufnr, filetype)
    end
  }
end

return function(opts)
  opts = opts or {}
  pickers.new {
    results_title = 'Jira Issues',
    finder = finders.new_oneshot_job({ 'jira', 'list', '--assignee=morgan.mccauley' }, {
      entry_maker = function(line)
        if line == "" then return {} end

        local tmp_table = vim.split(line, ":");
        local ticket = tmp_table[1]
        local priority = tmp_table[2]
        local status = tmp_table[3]
        local description = tmp_table[4]

        return {
          value = ticket,
          ordinal = line,
          display = ticket .. ' ' .. description .. ' (' .. status .. '/' .. priority .. ')',
          ticket = ticket,
          description = description,
          priority = priority,
          status = status,
        }
      end
    }),
    sorter = conf.file_sorter(opts),
    previewer = issue_previewer(opts),
    attach_mappings = function(_, map)
      map('i', '<c-y>', function(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        vim.fn.setreg('*', entry.ticket)
        actions.close(prompt_bufnr)
      end)

      map('i', '<c-t>', function(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        os.execute('jira browse ' .. entry.ticket)
        actions.close(prompt_bufnr)
      end)

      actions.select_default:replace(function(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        vim.api.nvim_command(':call MonkeyTerminalExec(' .. '"jira edit ' .. entry.ticket .. '")')
        actions.close(prompt_bufnr)
      end)
      return true
    end,
  }:find()
end
