source ~/.bash_profile

# Path to your oh-my-zsh installation.
export ZSH="/Users/ramonasuncion/.oh-my-zsh"
export TERM=xterm-256color

# Set name of the theme to load --- if set to "random" to get random themes.
ZSH_THEME="pointer"

# Which plugins would you like to load?
plugins=(
	git
	zsh-syntax-highlighting 
	zsh-autosuggestions
	dotenv
	autojump
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='micro'
else
export EDITOR='vim'
fi


# Aliases
alias ls="ls -la --color=auto"
alias tmuxreload="tmux source-file ~/.tmux.conf"
alias bucknell.wtf="ssh ramon@bucknell.wtf"
alias pi="ssh pi@134.82.137.7" # Raspberry Pi @ Bucknell.edu network
alias zshreload="source ~/.zshrc"
