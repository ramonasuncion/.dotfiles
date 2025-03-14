#!/bin/bash

if ! command -v zsh 2>&1 >/dev/null; then
  echo "zsh could not be found"
  exit 1
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "install oh my zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "done"
