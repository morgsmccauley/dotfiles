# Development environment setup
These are the configuration files for my development environment setup on macbook. I am currently using neovim, zshell, iterm2, and karabiner to achieve my desired workflow. Below are the steps required to get up and running.

## Install brew & brew packages
```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
```sh
brew install git
brew install --HEAD neovim
brew install node
brew install python3
brew install zsh

brew cask install karabiner-elements
brew cask install --HEAD iterm2
```
* The nightly build of neovim is required for CoC (intellisense in vim) pop up windows
* Python 3 is required for UltiSnips
* karabiner-elements is used for soft keyboard modifiers. After symlinking `.config`, it will automatically point to the configuration file defined here.

## Download oh-my-zsh
```sh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
This creates `.pre-oh-my-zsh` files to preserve anything it replaces. Make sure to remove these as this repo has the files we want.

## Clone this repository
Clone this repository in to `~/.dotfiles`
```sh
cd ~
git clone git@github.com:morgsmccauley/dotfiles.git .dotfiles
```

## Symlink all dotfiles to ~
```sh
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.config ~/.config
ln -s ~/.dotfiles/.inputrc ~/.inputrc
ln -s ~/.dotfiles/.iterm ~/.iterm
ln -s ~/.dotfiles/.zshrc ~/.zshrc
```
## Configuring iterm

Open iterm and point it to the configuration file
Preferences > General > Load preferences from a custom folder or URL > ``~/.iterm``

## install nvm and node
```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
```
Restart iterm so nvm is loaded correctly in to zshell. `.zshrc` already contains the correct path config so don't worrty about updating that.
```sh
nvm install 10.5.0
```
This is the only version needed off the bat as it is targetted directly by CoC. All other versions can be installed as required.


## Install python and node neovim packages
This is used for communication between Python/Node and neovim. This is not neovim itself.
```sh
pip3 install neovim
npm install -g neovim
```

## Open neovim
```sh
v
```
Neovim (nvim) is aliased as `v`. When neovim opens it will automatically download [vim-plug](https://github.com/junegunn/vim-plug) and all plugins listed in [plugins](./.config/plugins.vim). Coc will also install all language server dependencies.
Remember to install all node dependencies of the project as Coc will sometimes target these directly for intellisense.

## All done!
