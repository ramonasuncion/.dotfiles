# .bashrc

# shell
export PS1='\[\e[1;34m\]\h \[\e[0;36m\]\$ \[\e[0m\]'

# history
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# add alert alias for long running commands. e.g. sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias which="type -p"
alias ssh='custom_ssh_wrapper'

# usage:
# ssh XXX.XXX or XXX.XXX.XXX.XXX
custom_ssh_wrapper() {
  if [[ $1 =~ ^[0-9]+\.[0-9]+$ ]]; then
    ip="192.168.$1"
  else
    ip="$1"
  fi
  echo "Connecting to $ip..."
  /usr/bin/ssh "$ip" "${@:2}"
}

export PATH=$PATH:$HOME/bin
