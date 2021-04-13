local galaxyline = require('galaxyline')
local fileinfo = require('galaxyline.provider_fileinfo')
local condition = require('galaxyline.condition')
local diagnostic = require('galaxyline.provider_diagnostic')
local section = galaxyline.section

-- disables statusline in these filetypes
galaxyline.short_line_list = {'LuaTree', 'vista', 'dbui'}

local colors = {
    bg = '#282c34',
    --bg = '#fafafa',
    line_bg = '#282c34',
    --line_bg = '#fafafa',
    fg = '#D8DEE9',
    dark_fg = '#989ba3',
    --fg = '#282c34',
    fg_green = '#65a380',
    army = '#A3BE8C',
    darkblue = '#61afef',
    green = '#BBE67E',
    orange = '#FF8800',
    magenta = '#c678dd',
    red = '#DF8890',
    lightbg = '#3C4048',
    --lightbg = '#f0f0f1',
    nord = '#81A1C1',
    yellow = '#EBCB8B'
}

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

local function parent_dir(path)
  local i = path:find("[\\/:][^\\/:]*$")
  if not i then return end
  return path:sub(1, i)
end

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
    c = colors.fg_green,
    V = colors.magenta,
    [''] = colors.magenta,
    v = colors.magenta,
    R = colors.yellow
}

section.left = {
  {
    LeftRounded = {
        provider = function()
          --[[ local color = mode_color_map[vim.fn.mode()] or mode_color_map['n']
          vim.api.nvim_command('hi GalaxyLeftRounded guifg='..color) ]]
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
  --[[ {
    FilePath = {
      provider = function()
        local parent_path = parent_dir(vim.api.nvim_buf_get_name(0)):gsub('-', '')
        local git_path = parent_dir(vcs.get_git_dir()):gsub('-', '')
        local a = parent_path:gsub(git_path, '')
        return a
      end,
      condition = function()
        return condition.buffer_not_empty() and condition.hide_in_width() and filetype_not_disabled()
      end,
      highlight = {colors.dark_fg, colors.lightbg}
    },
  }, ]]
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
    DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.hide_in_width,
        icon = ' ',
        highlight = {colors.green, colors.line_bg}
    }
  },
  {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = ' ',
        highlight = {colors.orange, colors.line_bg}
    }
  },
  {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = ' ',
        highlight = {colors.red, colors.line_bg}
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

-- section.short_line_left = section.left

section.right = {
  {
    LspClient = {
      provider = 'GetLspClient',
      icon = ' ',
      condition = function()
        local lsp = require'galaxyline.provider_lsp'
        return lsp.get_lsp_client() ~= 'No Active Lsp' and condition.hide_in_width()
      end,
      highlight = {colors.darkblue, colors.line_bg}
    }
  },
  {
    GitBranch = {
      provider = 'GitBranch',
      icon = function()
        --local vcs = require('galaxyline.provider_vcs')
        --local dirty = vcs.diff_add() + vcs.diff_modified() + vcs.diff_remove()
        if false then
          return ' '
        end
        return ' '
      end,
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
        return diagnostic.get_diagnostic_error() or '- ' 
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
        return diagnostic.get_diagnostic_warn() or '- '
      end,
      icon = ' ',
      highlight = {colors.yellow, colors.lightbg}
    }
  },
  {
    DiagnosticInfo = {
      provider = function()
        return diagnostic.get_diagnostic_info() or '- '
      end,
      icon = ' ',
      highlight = {colors.darkblue, colors.lightbg}
    }
  },
  {
    DiagnoticHint = {
      provider = function()
        return diagnostic.get_diagnostic_hint() or '- '
      end,
      icon = ' ',
      highlight = {colors.army, colors.lightbg}
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
