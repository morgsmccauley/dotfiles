local is_open = false

return {
  'simrat39/symbols-outline.nvim',
  keys = {
    {
      '<C-p>',
      function()
        if not is_open then
          vim.api.nvim_exec_autocmds('User', { pattern = 'SymbolsOutlineOpen' })
          vim.api.nvim_command('SymbolsOutlineOpen')
          is_open = true
        else
          vim.api.nvim_command('SymbolsOutlineClose')
          is_open = false
        end
      end,
      '<Cmd>SymbolsOutline<Cr>',
      { silent = true, noremap = true }
    }
  },
  config = function()
    require('symbols-outline').setup({
      position = 'left'
    })

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = { 'NvimTreeOpen' },
      callback = function()
        if is_open then
          vim.api.nvim_command('SymbolsOutlineClose')
          is_open = false
        end
      end
    })
  end,
}
