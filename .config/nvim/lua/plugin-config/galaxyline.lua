local galaxyline = require('galaxyline')
local condition = require('galaxyline.condition')
local diagnostic = require('galaxyline.provider_diagnostic')
local fileinfo = require('galaxyline.provider_fileinfo')
local lsp = require('galaxyline.provider_lsp')

local section = galaxyline.section

galaxyline.short_line_list = {'NvimTree', 'term', 'LuaTree', 'vista', 'dbui'}
section.short_line_left = {
  {
    empty = {
      provider = function ()
        return ''
      end
    }
  }
}

section.short_line_right = {}

local dark_colors = {
  bg = "#1a1b26",
  line_bg = "#1a1b26",
  fg = "#c0caf5",
  army = '#A3BE8C',
  darkblue = '#61afef',
  green = "#9ece6a",
  orange = "#ff9e64",
  magenta = "#bb9af7",
  red = "#f7768e",
  lightbg = "#3b4261",
  nord = '#81A1C1',
  yellow = "#e0af68",
}

local light_colors = {
  bg = "#e1e2e6",
  line_bg = "#e1e2e6",
  fg = '#3760bf',
  darkblue = '#61afef',
  green = "#9ece6a",
  orange = "#ff9e64",
  magenta = "#bb9af7",
  red = "#f7768e",
  lightbg = "#c4c8da",
  nord = '#81A1C1',
  yellow = "#e0af68",
}

function getThemedColor(color) 
  return function ()
    if vim.o.background ~= nil and vim.o.background == "light" then
        return light_colors[color]
    elseif vim.o.background ~= nil and vim.o.background == "dark" then
        return dark_colors[color]
    end
  end
end

local custom_icons = require('galaxyline.provider_fileinfo').define_file_icon()
custom_icons['term'] = {
  getThemedColor('darkblue')(),
  '',
}
custom_icons['NvimTree'] = {
  getThemedColor('darkblue')(),
  'פּ',
}
custom_icons['Jenkinsfile'] = {
  getThemedColor('red')(),
  '',
}

local disabled_filetypes = {
  NvimTree = true,
  term = true,
}

local filetype_not_disabled = function()
  local ft = vim.api.nvim_buf_get_option(0, 'filetype')
  return not disabled_filetypes[ft]
end

--[[ local mode_color_map = {
    n = colors.nord,
    i = colors.red,
    c = colors.green,
    V = colors.magenta,
    [''] = colors.magenta,
    v = colors.magenta,
    R = colors.yellow
} ]]

local icons = {
  locker = '',
  unsaved = ''
}

section.left = {
  --[[ {
    ViMode = {
        provider = function()
          local color = mode_color_map[vim.fn.mode()] or mode_color_map['n']
          vim.api.nvim_command('hi GalaxyViMode guifg='..color)
          return '   '
        end,
        highlight = {colors.bg, colors.line_bg},
        separator = ' ',
        separator_highlight = {colors.lightbg, colors.line_bg}
    }
  }, ]]
  {
    Space = {
      provider = function() return ' ' end,
      separator = ' ',
      separator_highlight = {getThemedColor('line_bg'), getThemedColor('line_bg')},
    },
  },
  {
    FileIcon = {
        provider = 'FileIcon',
        condition = condition.buffer_not_empty,
        highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, getThemedColor(line_bg)}
    }
  },
  {
    FileName = {
      provider = function()
        if not condition.buffer_not_empty() then
          return ''
        end

        local fname

        if not condition.hide_in_width() or vim.fn.expand('%'):len() > 50 then
          fname = vim.fn.expand '%:t' -- filename only
        else
          fname = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.') -- full path
        end

        if #fname == 0 then
          return ''
        end

        if vim.bo.readonly then
          fname = fname .. '   '
        end

        if vim.bo.modified then
          fname = fname .. '   '
        end

        return ' ' .. fname .. ' '
      end,
      highlight = {getThemedColor('fg'), getThemedColor('line_bg')}
    }
  },
  {
    PerCent = {
      provider = 'LinePercent',
      highlight = {getThemedColor('fg'), getThemedColor('line_bg')},
      condition = function()
        return filetype_not_disabled() and condition.buffer_not_empty()
      end,
    }
  },
  {
    DiagnosticError = {
      provider = diagnostic.get_diagnostic_error,
      icon = ' ',
      separator = ' ',
      separator_highlight = {getThemedColor('lightbg'), getThemedColor('line_bg')},
      highlight = {getThemedColor('red'), getThemedColor('line_bg')}
    }
  },
  {
    DiagnosticWarn = {
      provider = diagnostic.get_diagnostic_warn,
      icon = ' ',
      separator = ' ',
      separator_highlight = {getThemedColor('lightbg'), getThemedColor('line_bg')},
      highlight = {getThemedColor('yellow'), getThemedColor('line_bg')}
    }
  },
  {
    DiagnosticInfo = {
      provider = diagnostic.get_diagnostic_info,
      icon = ' ',
      separator = ' ',
      separator_highlight = {getThemedColor('lightbg'), getThemedColor('line_bg')},
      highlight = {getThemedColor('darkblue'), getThemedColor('line_bg')}
    }
  },
  {
    DiagnoticHint = {
      provider = diagnostic.get_diagnostic_hint,
      icon = ' ',
      separator = ' ',
      separator_highlight = {getThemedColor('lightbg'), getThemedColor('line_bg')},
      highlight = {getThemedColor('green'), getThemedColor('line_bg')}
    }
  },
}

function lsp_progress(_)
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

function lsp_name(msg)
  msg = msg or "Inactive"
  local buf_clients = vim.lsp.buf_get_clients()
  if next(buf_clients) == nil then
    if type(msg) == "boolean" or #msg == 0 then
      return "Inactive"
    end
    return msg
  end

  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    table.insert(buf_client_names, client.name)
  end

  return table.concat(buf_client_names, ", ")
end

section.right = {
  {
    LspProgress = {
      provider = lsp_progress,
      highlight = {getThemedColor('darkblue'), getThemedColor('line_bg')}
    }
  },
  {
    LspClient = {
      provider = lsp_name,
      icon = '  ',
      highlight = {getThemedColor('darkblue'), getThemedColor('line_bg')}
    }
  },
  {
    GitBranch = {
      provider = 'GitBranch',
      icon =  ' ',
      separator = '  ',
      condition = function()
        return condition.check_git_workspace() and condition.hide_in_width()
      end,
      separator_highlight = {getThemedColor('lightbg'), getThemedColor('line_bg')},
      highlight = {getThemedColor('green'), getThemedColor('line_bg')}
    }
  },
  {
    Space = {
      provider = function() return ' ' end,
      separator = ''
    },
  },
}
