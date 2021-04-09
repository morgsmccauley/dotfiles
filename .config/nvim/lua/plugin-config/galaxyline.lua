local galaxyline = require('galaxyline')
local section = galaxyline.section

galaxyline.short_line_list = {'LuaTree', 'vista', 'dbui'}

local colors = {
    bg = '#282c34',
    --bg = '#fafafa',
    line_bg = '#282c34',
    --ling_bg = '#fafafa',
    fg = '#D8DEE9',
    --fg = '#282c34',
    fg_green = '#65a380',
    yellow = '#A3BE8C',
    cyan = '#22262C',
    darkblue = '#61afef',
    green = '#BBE67E',
    orange = '#FF8800',
    purple = '#252930',
    magenta = '#c678dd',
    blue = '#22262C',
    red = '#DF8890',
    lightbg = '#3C4048',
    --lightbg = '#f0f0f1',
    nord = '#81A1C1',
    greenYel = '#EBCB8B'
}

local function buffer_not_empty()
	return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
end

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

section.left = {
  {
    leftRounded = {
        provider = function()
            return ''
        end,
        highlight = {colors.nord, colors.bg}
    }
  },
  {
    ViMode = {
        provider = function()
            return '   '
        end,
        highlight = {colors.bg, colors.nord},
        separator = ' ',
        separator_highlight = {colors.lightbg, colors.lightbg}
    }
  },
  {
    FileIcon = {
        provider = 'FileIcon',
        condition = buffer_not_empty,
        highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.lightbg}
    }
  },
  {
    FileName = {
      -- full path
        provider = {'FileName', 'FileSize'},
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.lightbg}
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
        condition = checkwidth,
        icon = '   ',
        highlight = {colors.green, colors.line_bg}
    }
  },
  {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = ' ',
        highlight = {colors.orange, colors.line_bg}
    }
  },
  {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = ' ',
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
  {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = {colors.red, colors.bg}
    }
  },
  {
    Space = {
        provider = function()
            return ' '
        end,
        highlight = {colors.line_bg, colors.line_bg}
    }
  },
  {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = {colors.blue, colors.bg}
    }
  }
}

section.right = {
  {
    LspClient = {
      provider = 'GetLspClient',
      icon = '  ',
      condition = function()
        local lsp = require'galaxyline.provider_lsp'
        return lsp.get_lsp_client() ~= 'No Active Lsp'
      end,
      highlight = {colors.blue, colors.bg}
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
      condition = require('galaxyline.provider_vcs').check_git_workspace,
      highlight = {colors.green, colors.line_bg}
    }
  },
  {
    right_LeftRounded = {
        provider = function()
            return ''
        end,
        separator = ' ',
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.red, colors.bg}
    }
  },
  {
    SiMode = {
        provider = function()
            local alias = {
                n = 'NORMAL',
                i = 'INSERT',
                c = 'COMMAND',
                V = 'VISUAL',
                [''] = 'VISUAL',
                v = 'VISUAL',
                R = 'REPLACE'
            }
            return alias[vim.fn.mode()]
        end,
        highlight = {colors.bg, colors.red}
    }
  },
  {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = {colors.red, colors.red},
        highlight = {colors.bg, colors.fg}
    }
  },
  {
    rightRounded = {
        provider = function()
            return ''
        end,
        highlight = {colors.fg, colors.bg}
    }
  }
}
