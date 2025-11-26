#!/usr/bin/env bash

DEFAULT_CONFIG_FILE="config.ini"
CONFIG_FILE="$DEFAULT_CONFIG_FILE"

SCRIPT_DIR=$(dirname "$(realpath "$0")")

display_help() {
  echo "Usage: deploy.sh [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  -h, --help        Show this help"
  echo "  -c, --config F    Use config file F"
  echo "  -p, --preview     Preview only (no changes)"
  echo ""
  echo "Config: specify 'path', 'type', and 'target' in the config file."
}

for arg in "$@"; do
  case $arg in
    -h |--help)
      display_help
      exit 0
      ;;
    -c | --config)
      shift
      CONFIG_FILE="$1"
      if [ ! -f "$CONFIG_FILE" ]; then
        echo "Config file '$CONFIG_FILE' not found."
        exit 1
      fi
      break
      ;;
    -p | --preview)
      PREVIEW_MODE=0
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

show_preview() {
  local path=$1
  local target=$2
  local link_type=$3

  if [[ -z "$path" || -z "$target" || -z "$link_type" ]]; then
    return
  fi

  if [[ "$link_type" = "symlink" ]]; then
    echo "$target -> $path"
  fi

  if [[ "$link_type" = "hardlink" ]]; then
    echo "$target"
  fi
}

create_link() {
  local path=$1
  local target=$2
  local link_type=$3

  if [ -z "$target" ]; then
    echo "Error: target is empty!"
    return 1
  fi

  if [ "$link_type" = "symlink" ]; then
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$path" ]; then
      return
    elif [ -e "$target" ]; then
      rm -rf "$target"
    fi
    ln -sf "$path" "$target"
  elif [ "$link_type" = "hardlink" ]; then
    # https://unix.stackexchange.com/questions/167610/determining-if-a-file-is-a-hard-link-or-symbolic-link
    if [ -e "$target" ]; then
      link_count=$(stat -f '%h' "$target")
      if [ "$link_count" -gt 1 ]; then
        return
      else
        rm -rf "$target"
      fi
    fi
    ln "$path" "$target"
  else
    echo "Error: unsupported link type: $link_type"
    exit 1
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
    continue
  fi

  # Parse path="$HOME/example.txt"
  key=$(echo "$line" | cut -d '=' -f 1)
  value=$(echo "$line" | cut -d '=' -f 2-)
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
    *)
      echo "Unknown key: \"$key\""
      ;;
  esac

  if [[ -n "$path" && -n "$target" && -n "$link_type" && "$PREVIEW_MODE" -ne 0 ]]; then
    create_link "$path" "$target" "$link_type"
    path=""
    target=""
    link_type=""
  else
    show_preview "$path" "$target" "$link_type"
  fi
done < "$CONFIG_FILE"
