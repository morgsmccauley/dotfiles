# Development environment setup
These are the configuration files for my development environment on macbook. I am currently using neovim, zshell, iterm2, and karabiner elements to achieve my desired workflow. Below are the steps required to get up and running.

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
brew install the_silver_searcher
brew install nvm

brew cask install karabiner-elements
brew cask install --HEAD iterm2
```
* The nightly build of neovim is required for [CoC](https://github.com/neoclide/coc.nvim) (Intellisense) pop up windows
* Python 3 is required by [UltiSnips](https://github.com/SirVer/ultisnips)
* [Karabiner elements](https://github.com/tekezo/Karabiner-Elements) is used for soft keyboard modifiers
* [The silver searcher](https://github.com/ggreer/the_silver_searcher) (Ag) is used to search for text globally

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
Restart iterm so all dotfiles are loaded.

## Configuring iterm

Open iterm and load the configuation file:  
Preferences > General > Load preferences from a custom folder or URL > ``~/.iterm``

## install node 10 for intellisense
Node 10.5.0 is targetted directly by CoC.
```sh
nvm install 10.5.0
```
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
Neovim is aliased as `v`. When neovim opens it will automatically download [vim-plug](https://github.com/junegunn/vim-plug) and all plugins listed in [plugins](./.config/plugins.vim). CoC then install all language server dependencies.
Remember to install all node dependencies of the project as CoC will sometimes target these directly for intellisense.

## To Do
- [ ] Remove tmux config files
- [ ] Replace inputrc with zshell config
