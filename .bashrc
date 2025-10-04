[ -z "$PS1" ] && return

case "$TERM" in
  xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${PWD}\007"'
    ;;
esac

eval $(keychain --eval id_rsa)

COLOR_DIR="\[\033[1;34m\]"
COLOR_BRANCH="\[\033[1;32m\]"
COLOR_RESET="\[\033[0m\]"
COLOR_WHITE="\[\033[1;37m\]"

git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

set_prompt() {
  if [[ "$PWD" == "$HOME" ]]; then
    dir_name="~"
  else
    dir_name=$(basename "$PWD")
  fi
  branch_name=$(git_branch)
  if [ -n "$branch_name" ]; then
    PS1="${COLOR_WHITE}[${COLOR_DIR}${dir_name}${COLOR_WHITE}[${COLOR_BRANCH}$branch_name${COLOR_WHITE}]]${COLOR_RESET}\$ "
  else
    PS1="${COLOR_WHITE}[${COLOR_DIR}${dir_name}${COLOR_WHITE}]${COLOR_RESET}\$ "
  fi
}

PROMPT_COMMAND=set_prompt

alias ll='ls -la'
alias grep='grep --color=auto'
alias cls='clear'
alias sudo='sudo '
alias vim='nvim'
alias reload='source ~/.bashrc'
alias sl='ls'
alias ..="cd .."
alias ...="cd ../.."

function reload_gtk_theme() {
  theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
  gsettings set org.gnome.desktop.interface gtk-theme ''
  sleep 1
  gsettings set org.gnome.desktop.interface gtk-theme $theme
}

export PATH="$HOME/.local/bin:$HOME/bin:$PATH:$HOME/opt/cross/bin:/home/ramon/.spicetify"

if command -v dircolors &>/dev/null; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)"
  alias ls='ls --color=auto'
fi

export FLYCTL_INSTALL="/home/ramon/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

. "$HOME/.cargo/env"

export PATH=$PATH:/home/ramon/.spicetify
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
export TMPDIR=~/pip_cache
source /etc/profile.d/bash_completion.sh
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
export PATH=$PATH:/usr/local/go/bin
