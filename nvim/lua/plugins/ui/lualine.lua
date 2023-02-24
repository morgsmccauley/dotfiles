return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local lualine = require('lualine')
    local theme = require('lualine/themes/catppuccin')

    local function lsp_progress(_)
      local Lsp = vim.lsp.util.get_progress_messages()[1]

      if not Lsp then
        return ''
      end

      local msg = Lsp.message or ''
      local title = Lsp.title or ''

      return string.format(
        '%s %s',
        title,
        msg
      )
    end

    local function lsp_name(msg)
      msg = msg or ''
      local buf_clients = vim.lsp.get_active_clients()
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
      --[[ winbar = {
    lualine_x = { 'filename' }
  },
  inactive_winbar = {
    lualine_x = { 'filename' }
  }, ]]
      sections = {
        lualine_a = {
          {
            function()
              return ' '
            end,
            padding = { left = 0, right = 0 }
          },
        },
        lualine_b = {
        },
        lualine_c = {
          {
            'filetype',
            colored = true,
            icon_only = true,
            padding = { right = 1, left = 2 }
          },
          {
            function()
              local rel_path = vim.fn.expand('%:~:.:h')
              return rel_path == '.' and '' or rel_path .. '/'
            end,
            color = { fg = theme.inactive.c.fg },
            padding = { left = 0, right = 0 }
          },
          {

            'filename',
            file_status = true,
            path = 0,
            shorting_target = 0,
            padding = { left = 0, right = 1 }
          },
          'progress',
        },
        lualine_x = {
          {
            function()
              return require('dap').status()
            end,
            icon = { '', color = { fg = '#ed8796' } },
            cond = function()
              return packer_plugins['nvim-dap'].loaded
            end
          },
          {
            'diagnostics',
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = ' ',
            }
          },
          {
            lsp_progress,
            color = { fg = theme.inactive.c.fg },
          },
          {
            lsp_name,
            icon = { ' ' },
          },
          {
            'branch',
            icon = ''
          }
        },
        lualine_y = {},
        lualine_z = {}
      },
    })
  end
}
