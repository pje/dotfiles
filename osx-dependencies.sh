#!/usr/bin/env bash
set -e

# [ -f `which brew` ] || echo 'no brew' >&2
# [ -f `which brew` ] || echo '/usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"' >&2
brew -v

[ -d /Applications/Sublime Text 2.app ] && (which subl || ln -fs "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl

vim --version | grep '+ruby' || (echo 'vim compiled without ruby support' >&2 && exit 1)

# (mvim --version | grep '+ruby') || (brew install macvim --override-system-vim && brew linkapps)

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
[ -d $dest ] || (git clone $repo $dest && cd $dest/ruby/command-t && ruby extconf.rb && rake make)

name="git-vim"
dest=~/.vim/bundle/$name
repo="https://github.com/motemen/git-vim"
[-d $dest ] || (git clone $repo $dest)
