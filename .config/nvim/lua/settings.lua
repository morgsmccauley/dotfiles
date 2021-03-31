local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

opt("o", "hidden", true)
opt("o", "ignorecase", true)
opt("o", "splitbelow", true)
opt("o", "splitright", true)
opt("o", "termguicolors", true)
opt("w", "number", true)
opt("o", "numberwidth", 2)

opt("o", "mouse", "a")

opt("w", "signcolumn", "yes")
opt("o", "cmdheight", 1)

opt("o", "updatetime", 250) -- update interval for gitsigns 
opt("o", "clipboard", "unnamedplus")

-- for indenline
opt("b", "expandtab", true )
opt("b", "shiftwidth", 2 )

vim.cmd "colorscheme base16-onedark"
vim.cmd "syntax enable"
vim.cmd "syntax on"

-- highlights
vim.cmd("hi LineNr guibg=NONE")
vim.cmd("hi SignColumn guibg=NONE")
vim.cmd("hi VertSplit guibg=NONE")
vim.cmd("hi DiffAdd guifg=#81A1C1 guibg = none")
vim.cmd("hi DiffChange guifg =#3A3E44 guibg = none")
vim.cmd("hi DiffModified guifg = #81A1C1 guibg = none")
vim.cmd("hi EndOfBuffer guifg=#282c34")

vim.cmd("hi TelescopeBorder   guifg=#3e4451")
vim.cmd("hi TelescopePromptBorder   guifg=#3e4451")
vim.cmd("hi TelescopeResultsBorder  guifg=#3e4451")
vim.cmd("hi TelescopePreviewBorder  guifg=#525865")
vim.cmd("hi PmenuSel  guibg=#98c379")

-- tree folder name , icon color
vim.cmd("hi NvimTreeFolderIcon guifg = #61afef")
vim.cmd("hi NvimTreeFolderName guifg = #61afef")
vim.cmd("hi NvimTreeIndentMarker guifg=#545862")

vim.cmd("autocmd BufEnter * lua require'completion'.on_attach()")


local M = {}

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

return M
