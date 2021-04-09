vim.o.hidden = false
vim.o.splitright = true
vim.o.ignorecase = true
vim.o.splitbelow = true
vim.o.termguicolors = true
vim.o.number = true
vim.o.numberwidth = 2
vim.o.wrap = false

vim.o.mouse = 'a'

vim.o.signcolumn = 'yes'
vim.o.cmdheight = 1

vim.o.updatetime = 250
vim.o.clipboard = 'unnamedplus'

-- for indenline
vim.o.expandtab = true
vim.o.shiftwidth = 2

vim.o.completeopt = 'menuone,noselect,noinsert'
vim.cmd[[set shortmess+=c]]
vim.o.encoding = 'UTF-8'

vim.g.node_host_prog = '/Users/morganmccauley/.nvm/versions/node/v15.2.0/bin/node'
vim.cmd[[let g:node_host_prog = '/Users/morganmccauley/.nvm/versions/node/v15.2.0/bin/node']]

vim.o.undofile = true
vim.cmd[[set undodir=~/.vim/undo]]

vim.cmd 'colorscheme base16-onedark'
vim.cmd 'syntax enable'
vim.cmd 'syntax on'

vim.api.nvim_command[[
autocmd BufEnter *SchemaChangesAreApproved*,*.gql,*.graphql :set filetype=graphql
]]

-- highlights
vim.cmd 'hi LineNr guibg=NONE'
vim.cmd 'hi SignColumn guibg=NONE'
vim.cmd 'hi VertSplit guibg=NONE'
vim.cmd 'hi DiffAdd guifg=#81A1C1 guibg = none'
vim.cmd 'hi DiffChange guifg =#3A3E44 guibg = none'
vim.cmd 'hi DiffModified guifg = #81A1C1 guibg = none'
vim.cmd 'hi EndOfBuffer guifg=#282c34'

vim.cmd 'hi TelescopeBorder   guifg=#3e4451'
vim.cmd 'hi TelescopePromptBorder   guifg=#3e4451'
vim.cmd 'hi TelescopeResultsBorder  guifg=#3e4451'
vim.cmd 'hi TelescopePreviewBorder  guifg=#525865'
vim.cmd 'hi PmenuSel  guibg=#98c379'

-- tree folder name , icon color
vim.cmd 'hi NvimTreeFolderIcon guifg = #61afef'
vim.cmd 'hi NvimTreeFolderName guifg = #61afef'
vim.cmd 'hi NvimTreeIndentMarker guifg=#545862'
