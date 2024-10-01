#!/bin/bash
CONFIG_FILE="config.ini"

# FIXME: Should $PWD be necessary?
# I can't use ~/ or ./ on config.ini.

create_link() {
  local path=$1
  local target=$2
  local link_type=$3

  if [ "$link_type" = "symlink" ]; then
    ln -sf "$path" "$target"
  elif [ "$link_type" = "hardlink" ]; then
    ln -hf "$path" "$target"
  else
    echo "Unsupported link type: \"$link_type\""
    exit 1
  fi
}

while IFS= read -r line; do
  # Ignore if empty string or comment.
  if [[ -z "$line" || "$line" =~ ^\s*# ]]; then
    continue
  fi

  # Capture sections [ Example ].
  if [[ "$line" =~ ^\[.*\]$ ]]; then
    section=$(echo "$line" | tr -d '[]')
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
      path=$(eval echo "$value")
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

  # Create the link.
  if [[ -n "$path" && -n "$target" && -n "$link_type" ]]; then
    create_link "$path" "$target" "$link_type"
    path=""
    target=""
    link_type=""
  fi
done < "$CONFIG_FILE"

