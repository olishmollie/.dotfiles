#!/usr/bin/env bash

# Copies and symlinks dotfiles into home folder

cp -R .vim ~
cp .gitignore_global ~
cp .gitconfig ~

ln -s .bash_profile ~/.bash_profile
ls -s .vimrc ~/.vimrc

cp .olishmollie.uninstall.sh ~
