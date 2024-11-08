#!/bin/bash

install_gnome_extensions() {
    extension_uuid=$1
    echo "Installing GNOME extension: ${extension_uuid}"

    gnome_version=$(gnome-shell --version | grep -oP '[0-9]+\.[0-9]+')
    extension_url="https://extensions.gnome.org/extension-info/?uuid=${extension_uuid}&shell_versions=${gnome_version}"

    extension_info=$(curl -s $extension_url)
    download_url=$(echo "${extension_url}" | jq -r '.download_url')

    if [ -n "$download_url" ]; then
        full_url="https://extensions.gnome.org$download_url"
        tmp_dir=$(mktemp -d)
        wget -O "${tmp_dir}/extension.zip" "$full_url"
        mkdir -p ~/.local/share/gnome-shell/extensions/$extension_uuid
        unzip "${tmp_dir}/extension.zip" -d ~/.local/share/gnome-shell/extensions/$extension_uuid
        rm -rf "tmp_dir"

        gnome-extensions enable $extension_uuid
    else
        echo "Failed to download extension ${extension_uuid}"
    fi
}

while IFS= read -r extension_uuid; do
    install_gnome_extensions "$extension_uuid"
done < ~/dotfiles/gnome-extensions.txt


