local lualine = require('lualine')
local theme = require('lualine/themes/catppuccin')

local function lsp_progress(_)
  local Lsp = vim.lsp.util.get_progress_messages()[1]

  if not Lsp then
    return ''
  end

  local msg = Lsp.message or ''
  local percentage = Lsp.percentage or 0
  local title = Lsp.title or ''

  local spinners = { '', '', '' }
  local success_icon = { '', '', '' }

  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners

  return string.format(
    ' %s %s %s (%s) ',
    percentage >= 70 and success_icon[frame + 1] or spinners[frame + 1],
    title,
    msg,
    percentage
  )
end

local function lsp_name(msg)
  msg = msg or ''
  local buf_clients = vim.lsp.buf_get_clients()
  if next(buf_clients) == nil then
    if type(msg) == 'boolean' or #msg == 0 then
      return ''
    end
    return msg
  end

  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    table.insert(buf_client_names, client.name)
  end

  return table.concat(buf_client_names, ', ')
end

lualine.setup({
  options = {
    theme = 'catppuccin',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  -- inactive_winbar = {
  --   lualine_a = {},
  --   lualine_b = {},
  --   lualine_c = { 'filename' },
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = {}
  -- },
  sections = {
    lualine_a = {
      {
        'mode'
      },
    },
    lualine_b = {
      {
        function()
          return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
        end,
      }
    },
    lualine_c = {
      {
        function()
          local head = vim.fn.expand('%:h'):gsub(vim.fn.getcwd(), '');
          return ' ' .. head .. (head ~= '' and '/' or '')
        end,
        color = { fg = theme.normal.a.bg },
        padding = { left = 0, right = 0 },
      },
      {
        'filename',
        file_status = true,
        path = 0,
        padding = { left = 0 },
        shorting_target = 0,
      },
      'progress',
      {
        'diagnostics',
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = ' ',
        }
      }
    },
    lualine_x = {
      {
        function()
          return require('dap').status()
        end,
        icon = { '', color = { fg = '#ed8796' } }
      },
      {
        lsp_progress,
      },
      {
        lsp_name,
        icon = { '', color = { fg = theme.normal.a.bg } },
      },
      {
        'encoding',
      },
      {
        'fileformat',
      },
      {
        'filetype',
      },
      {
        'branch',
      }
    },
    lualine_y = {},
    lualine_z = {}
  },
})
