local galaxyline = require('galaxyline')
local fileinfo = require('galaxyline.provider_fileinfo')
local condition = require('galaxyline.condition')
local diagnostic = require('galaxyline.provider_diagnostic')
local tokyonight = require('tokyonight.theme').setup()

local theme = tokyonight.colors
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

local dark_colors = {
  bg = "#24283b",
  line_bg = "#24283b",
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
  green = theme.green,
  orange = theme.orange,
  magenta = theme.magenta,
  red = theme.red,
  lightbg = "#c4c8da",
  nord = '#81A1C1',
  yellow = "#e0af68",
}

local colors = dark_colors

local custom_icons = require('galaxyline.provider_fileinfo').define_file_icon()
custom_icons['term'] = {
  colors.darkblue,
  '',
}
custom_icons['NvimTree'] = {
  colors.darkblue,
  'פּ',
}
custom_icons['Jenkinsfile'] = {
  colors.red,
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

local mode_color_map = {
    n = colors.nord,
    i = colors.red,
    c = colors.green,
    V = colors.magenta,
    [''] = colors.magenta,
    v = colors.magenta,
    R = colors.yellow
}

section.left = {
  {
    LeftRounded = {
        provider = function()
          return ''
        end,
        highlight = {colors.lightbg, colors.bg}
    }
  },
  {
    ViMode = {
        provider = function()
          local color = mode_color_map[vim.fn.mode()] or mode_color_map['n']
          vim.api.nvim_command('hi GalaxyViMode guifg='..color)
          return '   '
        end,
        highlight = {colors.bg, colors.lightbg},
        separator = ' ',
        separator_highlight = {colors.lightbg, colors.lightbg}
    }
  },
  {
    FileIcon = {
        provider = 'FileIcon',
        condition = condition.buffer_not_empty,
        highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.lightbg}
    }
  },
  {
    FileName = {
      provider = function()
        return fileinfo.get_current_file_name()
      end,
      condition = condition.buffer_not_empty,
      highlight = {colors.fg, colors.lightbg}
    }
  },
  {
    PerCent = {
      provider = 'LinePercent',
      highlight = {colors.fg, colors.lightbg},
      condition = function()
        return filetype_not_disabled() and condition.buffer_not_empty()
      end,
    }
  },
  {
    teech = {
        provider = function()
            return ''
        end,
        separator = ' ',
        highlight = {colors.lightbg, colors.bg}
    }
  },
  {
    LeftEnd = {
        provider = function()
            return ' '
        end,
        separator = ' ',
        separator_highlight = {colors.line_bg, colors.line_bg},
        highlight = {colors.line_bg, colors.line_bg}
    }
  },
}

section.right = {
  {
    LspClient = {
      provider = function()
        return vim.g.coc_status;
      end,
      icon = ' ',
      condition = condition.hide_in_width,
      highlight = {colors.darkblue, colors.line_bg}
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
      highlight = {colors.green, colors.line_bg}
    }
  },
  {
    Space = {
      provider = function() return ' ' end,
      separator = ''
    },
  },
  {
    LeftRound = {
        provider = function()
          return ''
        end,
        highlight = {colors.lightbg, colors.bg}
    }
  },
  {
    DiagnosticError = {
      provider = function()
        local error = diagnostic.get_diagnostic_error()
        if error == nil or error == '' then
          return '- ' 
        end
        return error..' '
      end,
      icon = ' ',
      separator = ' ',
      separator_highlight = {colors.lightbg, colors.lightbg},
      highlight = {colors.red, colors.lightbg}
    }
  },
  {
    DiagnosticWarn = {
      provider = function()
        local warn = diagnostic.get_diagnostic_warn()
        if warn == nil or warn == '' then
          return '- ' 
        end
        return warn..' '
      end,
      icon = ' ',
      highlight = {colors.yellow, colors.lightbg}
    }
  },
  {
    DiagnosticInfo = {
      provider = function()
        local info = diagnostic.get_diagnostic_info()
        if info == nil or info == '' then
          return '- ' 
        end
        return info..' '
      end,
      icon = ' ',
      highlight = {colors.darkblue, colors.lightbg}
    }
  },
  {
    DiagnoticHint = {
      provider = function()
        local hint = diagnostic.get_diagnostic_hint()
        if hint == nil or hint == '' then
          return '- ' 
        end
        return hint..' '
      end,
      icon = ' ',
      highlight = {colors.green, colors.lightbg}
    }
  },
  {
    RightRound = {
        provider = function()
            return ''
        end,
        highlight = {colors.lightbg, colors.bg}
    }
  },
}
