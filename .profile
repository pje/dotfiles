[ -f ~/.rvmrc ] && source ~/.rvmrc
[ -f ~/.scrc ] && source ~/.scrc

export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/share/python:$PATH
export PATH=~/bin:$PATH

function current_git_branch {
  git branch 2> /dev/null | ack '^\* (.*?)$' --output '$1' -h
}

alias gst="git status"
alias cgb="current_git_branch"
