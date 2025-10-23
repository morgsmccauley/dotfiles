return {
  'morgsmccauley/kitty-projects.nvim',
  config = function()
    require('kitty').setup({
      -- `--login` ensures env vars from .zprofile/.zlogin are sourced
      -- Required for nvim plugins to find LSPs, formatters, and other tools
      command = 'zsh --login -c /etc/profiles/per-user/morganmccauley/bin/nvim',
      project_paths = {
        { vim.env.HOME .. '/Developer/monorepo',    exclude_hidden = true },
        { vim.env.HOME .. '/Developer' },
        { vim.env.HOME .. '/Documents' },
        { vim.env.HOME .. '/.local/share/nvim/lazy' },
        vim.env.HOME .. '/.dotfiles'
      },
      picker = 'snacks'
    })
  end
}
