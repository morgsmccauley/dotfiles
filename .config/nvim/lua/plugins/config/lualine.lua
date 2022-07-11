local lualine = require('lualine')

local function lsp_progress(_)
  local Lsp = vim.lsp.util.get_progress_messages()[1]

  if Lsp then
    local msg = Lsp.message or ""
    local percentage = Lsp.percentage or 0
    local title = Lsp.title or ""

    local spinners = { "", "", "" }
    local success_icon = { "", "", "" }

    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 120) % #spinners

    if percentage >= 70 then
      return string.format(" %s %s %s (%s%%) ", success_icon[frame + 1], title, msg, percentage)
    end

    return string.format(" %s %s %s (%s%%) ", spinners[frame + 1], title, msg, percentage)
  end

  return ""
end

local function lsp_name(msg)
  msg = msg or ""
  local buf_clients = vim.lsp.buf_get_clients()
  if next(buf_clients) == nil then
    if type(msg) == "boolean" or #msg == 0 then
      return ""
    end
    return msg
  end

  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    table.insert(buf_client_names, client.name)
  end

  return table.concat(buf_client_names, ", ")
end

local function hide_in_width()
  return  vim.fn.winwidth(0) > 120
end

lualine.setup({
  options = {
    theme = 'catppuccin',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {
        function()
          return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
        end,
        cond = hide_in_width
      },
    },
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1,
        shorting_target = 0
      },
      'location',
      'diagnostics'
    },
    lualine_x = {
      {
        lsp_progress,
        -- cond = hide_in_width
      },
      {
        lsp_name,
        -- cond = hide_in_width
      },
      {
        'encoding',
        -- cond = hide_in_width
      },
      {
        'fileformat',
        -- cond = hide_in_width
      },
      {
        'filetype',
        -- cond = hide_in_width
      },
    },
    lualine_y = {},
    lualine_z = {
      {
        'branch',
        -- cond = hide_in_width
      }
    }
  },
})
