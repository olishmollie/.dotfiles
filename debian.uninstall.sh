#!/bin/sh

restore() {
    file=$1
    if [ -f "$file~old" ]; then
        cp "$file~old" "$file"
    else
        rm "$file"
    fi
}

echo "Are you sure? (y/N)"
read -r REPLY
if [ "$REPLY" = 'y' ]
then
    echo "Removing dotfiles..."
    restore "$HOME/.bash_profile"
    restore "$HOME/.bashrc"
    restore "$HOME/.gitconfig"
    restore "$HOME/.gitignore_global"
    restore "$HOME/.inputrc"

    rm -rf "$HOME/.config"
    rm -rf "$HOME/.dotfiles"

    echo "Uninstalling core packages"
    sudo apt remove -y clang-format
    sudo apt remove -y curl
    sudo apt remove -y gdb
    sudo apt remove -y python3
    sudo apt remove -y python3-pip
    sudo apt remove -y shellcheck
    sudo apt remove -y valgrind
    sudo apt remove -y vim
    sudo apt remove -y wget
fi
