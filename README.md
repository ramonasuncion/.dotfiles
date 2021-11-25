# Dotfiles
Currently working on a MacOS system. 

# If on MacOS install the Command Line Tols for Mac. 
xcode-select --install 

# SSH if setup or do HTTPS 
git@github.com:RamonAsuncion/.dotfiles.git 
https://github.com/RamonAsuncion/.dotfiles.git 

# Symlinks to home directory
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

# Install HomeBrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Brewfile 
brew bundle --file ~/.dotfiles/Brewfile

