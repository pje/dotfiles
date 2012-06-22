source ~/.functions
source ~/.aliases
source ~/.scrc

export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/share/python:$PATH
export PATH=~/.rbenv/bin:$PATH
export PATH=~/bin:$PATH

[ -f `which rbenv` ] && eval "$(rbenv init -)"
