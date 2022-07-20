# Ramon's  Dotfiles
Currently working on a MacOS system.
I'm hoping to add my linux system files into this repository.


## Installation 

### If on MacOS install the Command Line Tols for Mac. 
```bash
xcode-select --install 
```

### Install through HTTP on a new device.  
```basg
git clone https://github.com/RamonAsuncion/.dotfiles.git 
```

### Symlinks to home directory
```bash
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
```

### Install HomeBrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install Brewfile 
```bash
brew bundle --file ~/.dotfiles/Brewfile
```

## Author 

Made by me. 

### Thanks to

Matt Compton and helping me out figure out problems I had with the .zshrc file. 
