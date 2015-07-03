source ~/.profile

source $(brew --prefix)/etc/bash_completion
source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh

export PS1='\u@\h:\w$(vcprompt -f " (%b%m%u)" ) ∫ '
export PATH="/usr/local/heroku/bin:$PATH"

HISTSIZE=5000
HISTFILESIZE=10000
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

