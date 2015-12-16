export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=/Applications/IntelliJ\ IDEA\ 15\ CE.app/Contents/MacOS:$PATH
export PATH=~/bin:$PATH

[[ -x /usr/libexec/java_home ]] && export JAVA_HOME="`/usr/libexec/java_home`"

export EDITOR=vim
export GOPATH=~/go

eval $(boot2docker shellinit 2>/dev/null)

alias g="git"
alias be="bundle exec"
alias bzk="bazooka"
