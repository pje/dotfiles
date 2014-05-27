source ~/.profile

source $(brew --prefix)/etc/bash_completion
source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh

export PS1='\u@\h:\w$(vcprompt -f " (%b%m%u)" ) ∫ '
