local builtin = require'telescope.builtin'
local make_entry = require'telescope.make_entry'
local finders = require'telescope.finders'
local actions = require'telescope.actions'
local action_utils = require'telescope.actions.utils'

return function(opts)
  local new_finder = function(opts)
    local opts = opts or {}

    local bufnrs = vim.tbl_filter(function(b)
      if 1 ~= vim.fn.buflisted(b) then
          return false
      end
      -- only hide unloaded buffers if opts.show_all_buffers is false, keep them listed if true or nil
      if opts.show_all_buffers == false and not vim.api.nvim_buf_is_loaded(b) then
        return false
      end
      if opts.ignore_current_buffer and b == vim.api.nvim_get_current_buf() then
        return false
      end
      if opts.only_cwd and not string.find(vim.api.nvim_buf_get_name(b), vim.loop.cwd(), 1, true) then
        return false
      end
      return true
    end, vim.api.nvim_list_bufs())
    if not next(bufnrs) then return end

    local buffers = {}
    for _, bufnr in ipairs(bufnrs) do
      local flag = bufnr == vim.fn.bufnr('') and '%' or (bufnr == vim.fn.bufnr('#') and '#' or ' ')

      local element = {
        bufnr = bufnr,
        flag = flag,
        info = vim.fn.getbufinfo(bufnr)[1],
      }

      if opts.sort_lastused and (flag == "#" or flag == "%") then
        local idx = ((buffers[1] ~= nil and buffers[1].flag == "%") and 2 or 1)
        table.insert(buffers, idx, element)
      else
        table.insert(buffers, element)
      end
    end

    if not opts.bufnr_width then
      local max_bufnr = math.max(unpack(bufnrs))
      opts.bufnr_width = #tostring(max_bufnr)
    end

    return finders.new_table {
      results = buffers,
      entry_maker = opts.entry_maker or make_entry.gen_from_buffer(opts)
    }
  end

  builtin.buffers({
    show_all_buffers = true,
    sort_lastused = true,
    attach_mappings = function(_, map)
      map('i', '<C-x>', actions.delete_buffer)
      return true
    end
  })
end
