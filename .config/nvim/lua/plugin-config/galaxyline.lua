local gl = require('galaxyline')
local left = gl.section.left
local right = gl.section.right
local middle = gl.section.middle

gl.short_line_list = {'LuaTree', 'vista', 'dbui'}

local colors = {
    bg = '#282c34',
    line_bg = '#282c34',
    fg = '#D8DEE9',
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
    nord = '#81A1C1',
    greenYel = '#EBCB8B'
}

left[1] = {
    leftRounded = {
        provider = function()
            return ''
        end,
        highlight = {colors.nord, colors.bg}
    }
}

left[2] = {
    ViMode = {
        provider = function()
            return '   '
        end,
        highlight = {colors.bg, colors.nord},
        separator = ' ',
        separator_highlight = {colors.lightbg, colors.lightbg}
    }
}

left[3] = {
    FileIcon = {
        provider = 'FileIcon',
        condition = buffer_not_empty,
        highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.lightbg}
    }
}

left[4] = {
    FileName = {
      -- full path
        provider = {'FileName', 'FileSize'},
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.lightbg}
    }
}

left[5] = {
    teech = {
        provider = function()
            return ''
        end,
        separator = ' ',
        highlight = {colors.lightbg, colors.bg}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

left[6] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = checkwidth,
        icon = '   ',
        highlight = {colors.greenYel, colors.line_bg}
    }
}

left[7] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = ' ',
        highlight = {colors.orange, colors.line_bg}
    }
}

left[8] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = ' ',
        highlight = {colors.red, colors.line_bg}
    }
}

left[9] = {
    LeftEnd = {
        provider = function()
            return ' '
        end,
        separator = ' ',
        separator_highlight = {colors.line_bg, colors.line_bg},
        highlight = {colors.line_bg, colors.line_bg}
    }
}

left[10] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = {colors.red, colors.bg}
    }
}

left[11] = {
    Space = {
        provider = function()
            return ' '
        end,
        highlight = {colors.line_bg, colors.line_bg}
    }
}

left[12] = {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = {colors.blue, colors.bg}
    }
}

right[1] = {
    GitIcon = {
        provider = function()
            return '   '
        end,
        condition = require('galaxyline.provider_vcs').check_git_workspace,
        highlight = {colors.green, colors.line_bg}
    }
}

right[2] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = require('galaxyline.provider_vcs').check_git_workspace,
        highlight = {colors.green, colors.line_bg}
    }
}

right[3] = {
    right_LeftRounded = {
        provider = function()
            return ''
        end,
        separator = ' ',
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.red, colors.bg}
    }
}

right[4] = {
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
}

right[5] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = {colors.red, colors.red},
        highlight = {colors.bg, colors.fg}
    }
}

right[6] = {
    rightRounded = {
        provider = function()
            return ''
        end,
        highlight = {colors.fg, colors.bg}
    }
}
