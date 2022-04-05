# Path to your oh-my-zsh installation.
export ZSH="/Users/morganmccauley/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="avit"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git gitfast z)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# turn off autocorrect
unsetopt correct_all

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
export CLICOLOR=1

export EDITOR='nvim'
export GIT_EDITOR='nvim'

export COLORTERM="truecolor"

export BAT_THEME="OneHalfLight"

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7
--color=fg+:#c0caf5,bg+:#1a1b26,hl+:#7dcfff
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a'

alias ld='lazydocker'
alias lg='lazygit'
alias v='nvim'
alias config='v ~/.config/nvim/'
alias cht='cht.sh'
alias R='ramda-repl'
alias c='cargo'
alias ag='alias | grep '
alias gai='git add -i'
alias gcn='git commit -v --no-verify'
alias gcan='git commit -a -v --no-verify'
alias gpn='git push --no-verify'
alias gpod='git push origin --delete'
alias gcf='git commit --fixup'
alias gcaf='git commit --all --fixup'
alias grbia='git rebase --interactive --autosquash'

alias gpc='gh pr create'
alias gpv='gh pr view'
alias gps='gh pr status'
alias gpl='gh pr list'
alias gpch='gh pr checkout'

alias rn='node_modules/.bin/react-native'
alias rnri='rn run-ios'
alias rnra='rn run-android'
alias nvip='nvm use && npm install && npm prune'
alias dc='docker compose'
alias d='docker'
alias de='docker exec'

alias ave='aws-vault exec'
alias node12='/opt/homebrew/opt/node@12/bin/node'

if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.work-specific.zsh ] && source ~/.work-specific.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="$PATH:$HOME/go/bin"
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
