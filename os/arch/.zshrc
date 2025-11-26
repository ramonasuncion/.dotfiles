export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR='nvim'
export TERMINAL="alacritty"
export BROWSER="zen"

alias vim="nvim"

export PATH=$PATH:/home/ramon/.spicetify:$HOME/Documents/airborne-fw/ardrone-tool/projects/plftool

if [ -e /home/ramon/.nix-profile/etc/profile.d/nix.sh ]; then . /home/ramon/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
