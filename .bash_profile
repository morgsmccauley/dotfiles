alias ls='ls -l -a'
alias v=openNvim
alias n='npm'
alias g='git'
alias config='v ~/.config/nvim/'
alias cht='cht.sh'
alias ta='tmux a -t'
alias R='ramda-repl'
alias c='clear'

function openNvim {
  if [ $# -eq 0 ]; then
    nvim ./
  else
    nvim $1
  fi
}

export CLICOLOR=1

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
  . `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi
export GIT_EDITOR=nvim
