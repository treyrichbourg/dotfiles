#!/bin/bash

# Symlink helper function
dotfilesDir=~/dotfiles

function linkDotfile {
  dest="${HOME}/${1}"
  dateStr=$(date +%Y-%m-%d-%H%M)

  if [ -h "${dest}" ]; then
    echo "Removing existing symlink: ${dest}"
    rm "${dest}"

  elif [ -f "${dest}" ]; then
    echo "Backing up existing file: ${dest}"
    mv "${dest}"{,.${dateStr}}

  elif [ -d "${dest}" ]; then
    echo "Backing up existing dir: ${dest}"
    mv "${dest}"{,.${dateStr}}
  fi

  echo "Creating new symlink: ${dest}"
  ln -s "${dotfilesDir}/${1}" "${dest}"
}

# Create symlinks for dotfiles
echo "Creating symlinks for dotfiles..."
linkDotfile ".config/nvim"
linkDotfile ".config/neofetch"
linkDotfile ".config/kitty/kitty.conf"

