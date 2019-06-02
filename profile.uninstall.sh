#!/bin/sh

echo "Are you sure? (y/N)"
read REPLY
if [ $REPLY = 'y' ]
then
    echo "Removing dotfiles..."
    rm "$HOME/.bash_profile"
    rm "$HOME/.bashrc"
    rm "$HOME/.gitconfig"
    rm "$HOME/.gitignore_global"
    rm "$HOME/.inputrc"
    rm "$HOME/.vimrc"
    rm -rf "$HOME/.dotfiles"
    rm -rf "$HOME/.passman"
    rm -rf "$HOME/.vim"

    echo "Uinstalling Homebrew..."
    yes | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"

    echo "Uninstalling Rust..."
    yes | rustup self uninstall

    echo "Restoring default shell..."
    sudo rm /etc/shells
    sudo mv /etc/shells~old /etc/shells
    chsh -s /bin/bash

    echo "Removing this script..."
    rm "$HOME/profile.uninstall.sh"
fi