vim.g['test#custom_strategies'] = {
  toggleterm = function(cmd)
    vim.fn.nvim_command('TermExec cmd="'..cmd..'"')
  end
}
vim.g['test#strategy'] = 'toggleterm';
