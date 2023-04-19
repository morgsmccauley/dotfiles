return {
  'tpope/vim-dotenv',
  config = function()
    -- always load the .env file in my dotfiles directory
    -- move all variables to relevant directories?
    vim.cmd('Dotenv ' .. os.getenv('HOME') .. '/.dotfiles/.env')

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'SessionLoadPost',
      callback = function()
        pcall(
          function()
            vim.cmd('Dotenv ' .. vim.fn.getcwd())
          end
        )
      end
    })
  end
}
