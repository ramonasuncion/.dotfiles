#!/bin/bash
# NOTE: bash scripts are under /usr/local/bin.

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# Disable ctrl-s and ctrl-q.
stty -ixon

# Allows you to cd into directory merely by typing the directory name.
shopt -s autocd

# Use #vi mode for command line editing.
set -o vi

# Path to programs that are compilied locally.
export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin/:/usr/local/bin

# Bind Ctrl + L to clear terminal
bind -m vi-insert "\C-l":clear-screen

# Autocomplete for Bash
#bind 'set show-all-if-ambiguous on'
#bind 'TAB:menu-complete'

# Set vim as the default editor.
export EDITOR='nvim'
export VISUAL=$EDITOR

# Infinite history.
HISTSIZE=
HISTFILESIZE=

# Flags for the default C compilre (e.g. make example)
export CC=gcc
#export CFLAGS="-Wall -Werror -std=c99 -g"
#export LDFLAGS="-lm -lpthread"
#export CXXFLAGS="-Wall -Werror -std=c++17 -g"

# Set a customized prompt.
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]\[\033[0m\]"

# Load shortcut aliases (if the file exists).
[ -f "$HOME/.config/inputrc" ] && source "$HOME/.config/inputrc"

# Set colorized output for ls command.
alias ls='ls --color'
alias sl=ls
alias grep='grep --color=auto'
alias vim='nvim'
alias path='readlink -f'
alias ..='cd ..'
alias ...='cd ../..'

doas() {
  if [[ $1 == "vim" ]]; then
    shift; command doas nvim "$@"
  else
    command doas "$@"
  fi
}

LS_COLORS='di=1;35:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90:*.png=35:*.gif=36:*.jpg=35:*.c=92:*.jar=33:*.py=93:*.h=90:*.txt=94:*.doc=104:*.docx=104:*.odt=104:*.csv=102:*.xlsx=102:*.xlsm=102:*.rb=31:*.cpp=92:*.sh=92:*.html=96:*.zip=4;33:*.tar.gz=4;33:*.mp4=105:*.mp3=106'
export LS_COLORS

# Creates a python virtual environment.
function create_venv() {
  python -m venv "$1"
  source "$1/bin/activate"
}

function header() {
  head -n1 "$1" | tr , ', '
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
