return {
  'morgsmccauley/kitty-projects.nvim',
  config = function()
    require('kitty').setup({
      command = 'zsh --login -c /run/current-system/sw/bin/nvim',
      project_paths = {
        { vim.env.HOME .. '/Developer' },
        { vim.env.HOME .. '/.local/share/nvim/lazy' },
        vim.env.HOME .. '/.dotfiles'
      }
    })
  end
}
