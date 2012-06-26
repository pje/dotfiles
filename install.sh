#!/usr/bin/env bash
set -e

dotfiles=".ackrc .bash_login .bashrc .ghci .gitconfig .gitignore .profile .vimrc com.googlecode.iterm2.plist"

read -r -p "overwrite dotfiles in $HOME ? "

if [[ $REPLY =~ ^[Yy]$ ]] ; then
  for f in $dotfiles ; do
    cp -f ./$f ~/
  done
else
  echo -e "cancelling installation"
fi
