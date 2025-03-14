#!/bin/bash

SCRIPT_NAME="LinkCreator"
SCRIPT_VERSION="1.0"
DEFAULT_CONFIG_FILE="config.ini"
CONFIG_FILE="$DEFAULT_CONFIG_FILE"

# Directory where script loaded.
SCRIPT_DIR=$(dirname "$(realpath "$0")")

display_help() {
  echo "Usage: $SCRIPT_NAME [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  --help         Show this help message"
  echo "  --version      Show the version and name of the script"
  echo "  --config FILE  Specify a custom configuration file"
  echo ""
  echo "This script reads a config file and creates symlinks or hardlinks based on the configuration."
  echo "The configuration file should specify 'path', 'type', 'target' and optional 'script'."
}

for arg in "$@"; do
  case $arg in
    --help)
      display_help
      exit 0
      ;;
    --version)
      echo "$SCRIPT_NAME version $SCRIPT_VERSION"
      exit 0
      ;;
    --config)
      shift
      CONFIG_FILE="$1"
      if [ ! -f "$CONFIG_FILE" ]; then
        echo "Config file '$CONFIG_FILE' not found."
        exit 1
      fi
      break
      ;;
    *)
      echo "Unknown option: $arg"
      display_help
      exit 1
      ;;
  esac
done

if [ ! -f "$CONFIG_FILE" ]; then
  echo "Config file '$CONFIG_FILE' not found."
  exit 1
fi

create_link() {
  local path=$1
  local target=$2
  local link_type=$3
  local script=$4

  if [ -z "$target" ]; then
    echo "Error: target is empty!"
    return 1
  fi

  if [ "$link_type" = "symlink" ]; then
    if [ -L "$target" ] && [ "$(readlink '$target')" = "$path" ]; then
      echo "Symlink '$target' already exists! Skipping..."
      return
    elif [ -e "$target" ]; then # file existence, ignore type.
      echo "Removing existing '$target' and creating symlink."
      rm -rf "$target"
    fi
    ln -sf "$path" "$target"
  elif [ "$link_type" = "hardlink" ]; then
    if [ -e "$target" ]; then
      echo "Hardlink '$target' already exists! Skipping..."
      return
    fi
    ln "$path" "$target"
  else
    echo "Unsupported link type: \"$link_type\""
    exit 1
  fi

  # TODO: Install repos.

  if [ -n "$script" ] && [ -f "$script" ]; then
    echo "Running post-link script: $script"
    bash $script
  fi
}

while IFS= read -r line; do
  # Ignore if empty string or comment.
  if [[ -z "$line" || "$line" =~ ^\s*\; ]]; then
    continue
  fi

  # Capture sections [ Example ].
  if [[ "$line" =~ ^\[.*\]$ ]]; then
    section=$(echo "$line" | tr -d '[]')
    path=""
    target=""
    link_type=""
    script=""
    continue
  fi

  # Get the key and value from each line.
  key=$(echo "$line" | cut -d '=' -f 1)
  value=$(echo "$line" | cut -d '=' -f 2-)

  # Remove leading/trailing whitespaces.
  key=$(echo "$key" | tr -d '[:space:]')
  value=$(echo "$value" | tr -d '[:space:]')

  case $key in
    path)
      path=$(realpath "$SCRIPT_DIR/$value" 2>/dev/null || echo "$value")
      ;;
    type)
      link_type="$value"
      ;;
    target)
      target=$(eval echo "$value")
      ;;
    script)
      script="$value"
      ;;
    *)
      echo "Unknown key: \"$key\""
      ;;
  esac

  # Create the link.
  if [[ -n "$path" && -n "$target" && -n "$link_type" ]]; then
    create_link "$path" "$target" "$link_type" "$script"
    path=""
    target=""
    link_type=""
    script=""
  fi
done < "$CONFIG_FILE"
