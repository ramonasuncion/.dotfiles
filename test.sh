#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

filename="$1"

name="${filename%.*}"
extension="${filename##*.}"

echo "File: $filename"
echo "Filename $name"
echo "Extension $extension"
