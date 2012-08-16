#!/usr/bin/env bash
set -e

vim --version | grep '+ruby' || (echo 'vim compiled without ruby support' >&2 && exit 1)

mkdir -p ~/.vim/
mkdir -p ~/.vim/autoload/
mkdir -p ~/.vim/bundle/

curl -so ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

name="ack"
dest=~/.vim/bundle/$name
repo="https://github.com/mileszs/ack.vim.git"
[ -d $dest ] || (git clone $repo $dest)

name="vim-colors-solarized"
dest=~/.vim/bundle/$name
repo="git://github.com/altercation/vim-colors-solarized.git"
[ -d $dest ] || (git clone $repo $dest)

name="command-t"
dest=~/.vim/bundle/$name
repo="git://git.wincent.com/command-t.git"
[ -d $dest ] || (git clone $repo $dest && cd $dest && bundle install && rake make)

name="git-vim"
dest=~/.vim/bundle/$name
repo="https://github.com/motemen/git-vim"
[ -d $dest ] || (git clone $repo $dest)
