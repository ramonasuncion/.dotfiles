export TERM=xterm-256color
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="pointer"
source $ZSH/oh-my-zsh.sh
plugins=(git)
alias vim="nvim"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="$PATH:/usr/local/bin:/opt/homebrew/bin:/opt/homebrew/opt/postgresql@15/bin:/Users/ramon/.spicetify:/Usrs/ramon/.local/bin"
eval "$(rbenv init -)"
export PATH="/Users/ramon/Developer/Odin-dev:$PATH"
alias python3="/opt/homebrew/bin/python3"
export SCCACHE_CACHE_SIZE="50G"
