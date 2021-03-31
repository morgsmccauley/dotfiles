# Development environment setup
These are the configuration files for my development environment on macbook. I am currently using neovim, zshell, iterm2, and karabiner elements to achieve my desired workflow. Below are the steps required to get up and running.

## Install
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/morgsmccauley/dotfiles/master/install.sh)"
```

## Configuring iterm

Open iterm and load the configuation file:  
Preferences > General > Load preferences from a custom folder or URL > `~/.iterm`

Restart iterm so all dotfiles are loaded.

## Open neovim
```sh
v
```
Neovim is aliased as `v`. When neovim opens it will automatically download [vim-plug](https://github.com/junegunn/vim-plug) and all plugins listed in [plugins](./.config/plugins.vim). CoC will then install all language server dependencies listed in [plugin-config.vim](./config/nvim/plugin-config.vim).
