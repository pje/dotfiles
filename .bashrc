source ~/.profile

which brew && gcb="`brew --prefix`/etc/bash_completion"
[[ -f $gcb ]] && . $gcb

export PS1='\u@\h:\w$(vcprompt -f " (%b%m%u)" ) ∫ '

