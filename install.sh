echo "Installing Brew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing brew packages..."
brew bundle --verbose

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Cloning dotfiles..."
git clone git@github.com:morgsmccauley/dotfiles.git ~/.dotfiles

echo "Symlinking dotfiles..."
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.config ~/.config
ln -s ~/.dotfiles/.iterm ~/.iterm
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/lazygit-config.yml ~/Library/Application\ Support/lazygit/config.yml

echo "Installing neovim node/python dependencies..."
nvm install 12.16.1
pip3 install neovim
npm install -g neovim

echo "Opening iTerm"
open ~/Applications/iTerm.app
