source ~/.profile

export PS1="\u@\h:\w \$(vcprompt)\$ "

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
eval "$(rbenv init -)"
