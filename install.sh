#!/usr/bin/env bash
set -e

dotfiles=".bash_login .bashrc .gitconfig .profile .vimrc"

read -r -p "overwrite dotfiles in $HOME ? "

if [[ $REPLY =~ ^[Yy]$ ]] ; then
  for f in $dotfiles ; do
    cp -f ./$f ~/
  done
else
  echo -e "cancelling installation"
fi
