# dotfiles

Configuration files used throughout my different systems.

## Run

```sh
$ ./link_creator.sh --help
Usage: LinkCreator [OPTIONS]

Options:
  -h --help         Show this help message
  -v --version      Show the version and name of the script
  -c --config FILE  Specify a custom configuration file
  -p --preview      Show a preview where files will be moved
This script reads a config file and creates symlinks or hardlinks based on the configuration.
The configuration file should specify 'path', 'type', 'target' and optional 'script'.
```

## Software

- Neovim
- Zsh w/ Oh My Zsh
- Git
- Tmux
