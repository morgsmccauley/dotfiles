return {
  dir = '/Users/morganmccauley/Developer/Repositories/kitty-projects',
  config = function()
    require('kitty').setup({
      command = 'zsh --login -c nvim',
      workspaces = {
        { vim.env.HOME .. '/Developer/Repositories' },
        { vim.env.HOME .. '/.local/share/nvim/lazy' },
        vim.env.HOME .. '/.dotfiles'
      }
    })
  end
}
