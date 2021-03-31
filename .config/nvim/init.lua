local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

-- load plugins
require("plugins.lua")
require("web-devicons.lua")

require("utils.lua")
require("nvimTree.lua")
require("statusline.lua")
require("telescope-nvim.lua")

-- lsp
require("nvim-lspconfig.lua")

require("gitsigns.lua")

require "colorizer".setup()

local cmd = vim.cmd
local g = vim.g
local indent = 2

cmd "colorscheme base16-onedark"
cmd "syntax enable"
cmd "syntax on"

g.auto_save = 1
g.indentLine_enabled = 1
g.indentLine_char_list = {'▏'}

g.mapleader = " "

require("treesitter.lua")
require("mappings.lua")

cmd("inoremap <expr> <Tab>   pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"")
cmd("inoremap <expr> <S-Tab>   pumvisible() ? \"\\<C-p>\" : \"\\<S-Tab>\"")

cmd("autocmd BufEnter * lua require'completion'.on_attach()")

cmd("autocmd BufWritePost plugins.lua PackerCompile")


-- highlights
cmd("hi LineNr guibg=NONE")
cmd("hi SignColumn guibg=NONE")
cmd("hi VertSplit guibg=NONE")
cmd("hi DiffAdd guifg=#81A1C1 guibg = none")
cmd("hi DiffChange guifg =#3A3E44 guibg = none")
cmd("hi DiffModified guifg = #81A1C1 guibg = none")
cmd("hi EndOfBuffer guifg=#282c34")

cmd("hi TelescopeBorder   guifg=#3e4451")
cmd("hi TelescopePromptBorder   guifg=#3e4451")
cmd("hi TelescopeResultsBorder  guifg=#3e4451")
cmd("hi TelescopePreviewBorder  guifg=#525865")
cmd("hi PmenuSel  guibg=#98c379")

-- tree folder name , icon color
cmd("hi NvimTreeFolderIcon guifg = #61afef")
cmd("hi NvimTreeFolderName guifg = #61afef")
cmd("hi NvimTreeIndentMarker guifg=#545862")

require("nvim-autopairs").setup()

require("lspkind").init(
    {
        File = " "
    }
)
