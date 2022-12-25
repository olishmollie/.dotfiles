#!/bin/sh

echo "Are you sure? (y/N)"
read -r REPLY
if [ "$REPLY" = 'y' ]
then
    echo "Removing dotfiles..."
    rm "$HOME/.bash_profile"
    rm "$HOME/.bashrc"
    rm "$HOME/.gitconfig"
    rm "$HOME/.gitignore_global"
    rm "$HOME/.inputrc"

    rm -rf "$HOME/.dotfiles"

    echo "Uninstalling Homebrew..."
    /bin/bash -c "sudo $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
fi
