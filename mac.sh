#!/bin/bash
GITHUB_USERNAME="RamonAsuncion"
REPOSITORY="dotfiles" 
FILE=".dotfiles"

# Download the dotfiles to the home directory.
git clone https://github.com/$GITHUB_USERNAME/$REPOSITORY.git $HOME/$FILE

# Create the symbolic links.
ln -s $HOME/$FILE/.zshrc $HOME/.zshrc
ln -s $HOME/$FILE/.gitconfig $HOME/.gitconfig

# Ask the user if they want to install homebrew.
read -r -p "Install Homebrew [Y/n]: " response 

# Check the response the user inputted.
if [ "$response" != "${response#[Yy]}" ] || [ "$response" = "" ]; then
	# Check if the brew command already exist. 
	if command -v brew &>/dev/null; then
		echo "Homebrew is already installed."
	else 
		echo "Installing Homebrew..."
		/usr/bin/ruby -e \
		"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

		echo "Adding Homebrew to path..."
	    export PATH="/usr/local/bin:$PATH"

		echo "Installing Brewfile packages..."
		brew bundle --file $FILE/Brewfile

		echo "Checking for updates..."
		brew update
	fi
fi

echo "Exiting." 
