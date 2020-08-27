source $HOME/.config/nvim/terminal.vim
source $HOME/.config/nvim/general.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/maps.vim
for f in split(glob('$HOME/.config/nvim/plugin-conf/*'), '\n')
  exe 'source' f
endfor

set shell=zsh\ -l
