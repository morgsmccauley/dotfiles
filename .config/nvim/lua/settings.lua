local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

opt('o', 'hidden', true)
opt('o', 'ignorecase', true)
opt('o', 'splitbelow', true)
opt('o', 'splitright', true)
opt('o', 'termguicolors', true)
opt('w', 'number', true)
opt('o', 'numberwidth', 2)

opt('o', 'mouse', 'a')

opt('w', 'signcolumn', 'yes')
opt('o', 'cmdheight', 1)

opt('o', 'updatetime', 250) -- update interval for gitsigns 
opt('o', 'clipboard', 'unnamedplus')

-- for indenline
opt('b', 'expandtab', true )
opt('b', 'shiftwidth', 2 )

vim.cmd 'set undofile'
vim.cmd 'set undodir=~/.vim/undo'

vim.cmd 'colorscheme base16-one-light'
vim.cmd 'syntax enable'
vim.cmd 'syntax on'
vim.cmd 'set completeopt=menuone,noinsert,noselect'
vim.cmd 'set shortmess+=c'
vim.cmd 'set encoding=UTF-8'

-- highlights
vim.cmd('hi LineNr guibg=NONE')
vim.cmd('hi SignColumn guibg=NONE')
vim.cmd('hi VertSplit guibg=NONE')
vim.cmd('hi DiffAdd guifg=#81A1C1 guibg = none')
vim.cmd('hi DiffChange guifg =#3A3E44 guibg = none')
vim.cmd('hi DiffModified guifg = #81A1C1 guibg = none')
vim.cmd('hi EndOfBuffer guifg=#282c34')

vim.cmd('hi TelescopeBorder   guifg=#3e4451')
vim.cmd('hi TelescopePromptBorder   guifg=#3e4451')
vim.cmd('hi TelescopeResultsBorder  guifg=#3e4451')
vim.cmd('hi TelescopePreviewBorder  guifg=#525865')
vim.cmd('hi PmenuSel  guibg=#98c379')

-- tree folder name , icon color
vim.cmd('hi NvimTreeFolderIcon guifg = #61afef')
vim.cmd('hi NvimTreeFolderName guifg = #61afef')
vim.cmd('hi NvimTreeIndentMarker guifg=#545862')
