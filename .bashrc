source ~/.profile

gcb='/usr/local/etc/bash_completion.d/git-completion.bash'

[[ -f $gcb ]] && . $gcb

export PS1='\u@\h:\w$(vcprompt -f " (%b%m%u)" ) ∫ '
