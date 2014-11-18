export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=~/bin:$PATH

export JAVA_HOME="`/usr/libexec/java_home`"

export EDITOR=vim
export GOPATH=~/go

function current_git_branch {
  git branch 2> /dev/null | ack '^\* (.*?)$' --output '$1' -h
}

function sublp {
  find . -name '*.sublime-project' -depth 1 | head -n1 | xargs subl --project
}

alias g="git"
alias be="bundle exec"
alias bzk="bazooka"
