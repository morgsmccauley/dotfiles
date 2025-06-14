return {
  'morgsmccauley/kitty-projects.nvim',
  config = function()
    require('kitty').setup({
      command = 'zsh --login -c /etc/profiles/per-user/morganmccauley/bin/nvim',
      project_paths = {
        { vim.env.HOME .. '/Developer' },
        { vim.env.HOME .. '/.local/share/nvim/lazy' },
        vim.env.HOME .. '/Developer/monorepo/monorepo-main',
        vim.env.HOME .. '/Developer/monorepo/monorepo-dev',
        vim.env.HOME .. '/Developer/monorepo/monorepo-review',
        vim.env.HOME .. '/Developer/monorepo/monorepo-scratch',
        vim.env.HOME .. '/.dotfiles'
      }
    })
  end
}
