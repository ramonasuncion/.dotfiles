export ZSH="$HOME/.oh-my-zsh"
export TERM=xterm-256color

plugins=(
  git
  zsh-autosuggestions
  zsh-history-substring-search
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

source ~/.config/zsh/options.zsh
source ~/.config/zsh/bindings.zsh
source ~/.config/zsh/theme.zsh

export GPG_TTY=$(tty)
export PATH=$HOME/.local/bin:$PATH
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
export LIBVIRT_DEFAULT_URI="qemu:///system"


# Added by Hugging Face CLI installer
export PATH="/home/ramon/.local/bin:$PATH"
export PATH="/home/ramon/ripe/compiler/_build/install/default/bin:$PATH"
export PATH="/home/ramon/Documents/ceramic/build/compiler:$PATH"

eval $(opam env)

# Swift toolchain (swiftly)
. "$HOME/.local/share/swiftly/env.sh"

alias swift-test="/usr/local/bin/swift-test"

# fnm
FNM_PATH="/home/ramon/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi
