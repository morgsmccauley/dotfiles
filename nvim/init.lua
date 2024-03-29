local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.env.PATH = '/opt/homebrew/bin:' .. vim.env.PATH

require('options')
require('maps')
require('highlights')
require('autocommand')
require('lazy').setup('plugins', {
  change_detection = {
    notify = false
  }
})
