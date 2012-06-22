source ~/.profile

gcb='/usr/local/etc/bash_completion.d/git-completion.bash'

if [[ -f $gcb ]] ; then
  . $gcb
  export PS1='\u@\h:\w$(__git_ps1 " (%s)" ) ∫ '
fi
