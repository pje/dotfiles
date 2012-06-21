set -e
# TODO

# vim & plugins

# which brew || echo 'no brew' >&2
# which brew || echo '/usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"' >&2
brew -v

vim --version | grep '+ruby' || echo 'vim compiled without ruby support' >&2 && exit 1
# TODO:
# (mvim --version | grep '+ruby') || brew install macvim --override-system-vim

mkdir -p ~/.vim
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/bundle

# pathogen
curl -so ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# solarized
#   vim plugin
[ -d ~/.vim/bundle/vim-colors-solarized ] || git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized

# ack
#   dependency: ack
which ack || brew install ack
#   vim plugin
[ -d ~/.vim/bundle/ack ] || git clone https://github.com/mileszs/ack.vim.git ~/.vim/bundle/ack

# command-t
#   vim plugin
[ -d ~/.vim/bundle/command-t ] || git clone git://git.wincent.com/command-t.git ~/.vim/bundle/command-t
cd ~/.vim/bundle/command-t
rake make
