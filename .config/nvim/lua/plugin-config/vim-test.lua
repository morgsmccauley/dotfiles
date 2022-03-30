vim.g['test#custom_strategies'] = {
  monkey = function(cmd)
    vim.fn.MonkeyTerminalExec(cmd)
  end
}
vim.g['test#strategy'] = 'monkey';
