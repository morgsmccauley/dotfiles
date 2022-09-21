vim.g['test#custom_strategies'] = {
  toggleterm = function(cmd)
    vim.api.nvim_command('TermExec cmd=\'' .. cmd .. '\'')
  end
}

vim.g['test#custom_transformations'] = {
  quotes = function(cmd)
    return cmd:gsub("\'", "\"")
  end
}

vim.g['test#strategy'] = 'toggleterm';
vim.g['test#transformation'] = 'quotes';
