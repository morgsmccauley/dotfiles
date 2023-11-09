return {
  'tpope/vim-dotenv',
  config = function()
    -- always load the .env file in my dotfiles directory
    -- move all variables to relevant directories?
    vim.cmd('Dotenv ' .. os.getenv('HOME') .. '/.dotfiles/.env')

    vim.api.nvim_create_autocmd({ 'VimEnter' }, {
      pattern = '*',
      callback = function()
        pcall(
          function()
            vim.cmd('Dotenv ' .. vim.fn.getcwd())
          end
        )
      end
    })

    -- only new/updated environment variables will be loaded
    -- `Dotenv` will only load the file as is, and not unload removed variables
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      pattern = { '.env' },
      callback = function()
        vim.cmd('verbose Dotenv ' .. vim.fn.expand('<afile>'))
      end
    })
  end
}
