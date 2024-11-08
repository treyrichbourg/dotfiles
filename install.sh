#!/bin/bash

# Update and install basic packages with apt
sudo apt update && sudo apt upgrade -y

# List of packages to install (modify as needed)
packages=(
    git
    zsh
    neofetch
    kitty
    curl
    build-essential
    gnome-tweaks
)

# Add any third-party PPAs (modify as needed)
ppas=(
    ppa:neovim-ppa/stable
    # Add other PPAs here
)

# Install PPAs
echo "Adding third-party PPAs..."
for ppa in "${ppas[@]}"; do
    sudo add-apt-repository -y "$ppa"
done

# Update package list after adding PPAs
sudo apt update

# Install packages
echo "Installing packages..."
sudo apt install -y "${packages[@]}"

# Pull and install the latest Neovim AppImage
echo "Fetching latest Neovim AppImage..."
neovim_url=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep 'browser_download_url.*AppImage' | cut -d '"' -f 4)
neovim_appimage=$(basename "$neovim_url")

curl -L "$neovim_url" -o "/tmp/$neovim_appimage"
sudo chmod +x "/tmp/$neovim_appimage"
sudo mv "/tmp/$neovim_appimage" /usr/bin/nvim

# Clone your dotfiles from GitHub
echo "Cloning dotfiles repository..."
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles

# Restore GNOME settings
echo "Restoring GNOME settings..."
dconf load / < ~/dotfiles/gnome-settings-backup.dconf

# Restore GNOME extensions
echo "Reinstalling GNOME extensions..."
xargs -a ~/dotfiles/gnome-extensions.txt -I {} gnome-extensions install {}

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
linkDotfile ".zshrc"

# Set Zsh as the default shell
echo "Setting Zsh as the default shell..."
sudo chsh -s $(which zsh) "$USER"

# Final message
echo "Setup complete. Please restart your session for changes to take effect."
