#!/bin/sh

echo "Are you sure? (y/N)"
read -r REPLY
if [ "$REPLY" = 'y' ]
then
    echo "Removing dotfiles..."
    rm "$HOME/.zhrc"
    rm "$HOME/.gitconfig"
    rm "$HOME/.gitignore_global"
    rm "$HOME/.inputrc"

    rm -rf "$HOME/.dotfiles"
    rm -rf "$HOME/.oh-my-zsh"

    echo "Uninstalling oh-my-zsh..."
    uninstall_oh_my_zsh

    echo "Uninstalling Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"

    echo "Uninstalling Rust..."
    yes | rustup self uninstall
fi
