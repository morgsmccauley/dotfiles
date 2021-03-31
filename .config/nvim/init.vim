set shell=zsh\ -l

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  source $HOME/.config/nvim/plugins.vim
else
  source $HOME/.config/nvim/general.vim
  source $HOME/.config/nvim/plugins.vim
  source $HOME/.config/nvim/terminal.vim
  source $HOME/.config/nvim/coc.vim
  source $HOME/.config/nvim/fzf.vim
  source $HOME/.config/nvim/plugin-conf.vim
  source $HOME/.config/nvim/maps.vim
endif
