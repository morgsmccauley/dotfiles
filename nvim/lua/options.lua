vim.o.hidden = false
vim.o.splitright = true
vim.o.ignorecase = true
-- vim.o.splitright = true
vim.o.termguicolors = true
vim.o.number = true
vim.o.numberwidth = 2
vim.o.wrap = false
vim.o.showmode = false
vim.o.cursorline = true

vim.o.mouse = 'a'

vim.o.signcolumn = 'yes'
-- vim.o.cmdheight = 0

vim.o.updatetime = 250
vim.o.clipboard = 'unnamedplus'

vim.o.timeoutlen = 250

vim.o.laststatus = 3

vim.o.expandtab = true
vim.o.shiftwidth = 2

vim.o.completeopt = 'menuone,noselect,noinsert'
vim.cmd [[set shortmess+=c]]
vim.o.encoding = 'UTF-8'

-- FIX applied to all windows therefore conflicts, ideally want to set this for lsp hover
-- vim.o.winborder = 'single'

vim.o.undofile = true
vim.cmd [[set undodir=~/.vim/undo]]

vim.cmd 'syntax enable'
vim.cmd 'syntax on'

vim.diagnostic.config({
  signs = {
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
  underline = false,
  float = {
    border = 'single'
  },
  virtual_text = true,
  -- virtual_text = {
  --   format = function(diagnostic)
  --     local lines = vim.split(diagnostic.message, '\n')
  --     return lines[1]
  --   end,
  --   virt_text_pos = 'right_align',
  --   suffix = ' ',
  -- },
  -- virtual_lines = { current_line = true },
})

vim.opt.scrolloff = 8

vim.opt.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,options'
