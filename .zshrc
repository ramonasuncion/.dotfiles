# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random" to get random themes.
ZSH_THEME="pointer"

# Which plugins would you like to load?
plugins=(
	git
	zsh-syntax-highlighting 
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh


# Language environment
export LANG=en_US.UTF-8


# Aliases
alias ls="ls -la --color=auto"
alias tmuxreload="tmux source-file ~/.tmux.conf"
alias zshreload="source ~/.zshrc"
alias python="python3"

