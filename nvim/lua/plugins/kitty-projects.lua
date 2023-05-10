return {
  dir = '/Users/morganmccauley/Developer/Repositories/kitty-projects',
  config = function()
    require('kitty').setup({
      command = 'nvim',
      workspaces = {
        { vim.env.HOME .. '/Developer/Repositories' },
        vim.env.HOME .. '/.dotfiles'
      }
    })
  end
}
