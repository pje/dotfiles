source ~/.profile

# in bash versions >= 4, this enabled zsh-like recursive globbing
shopt -s globstar

source $(brew --prefix)/etc/bash_completion
source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh

export PATH="$HOME/.git-radar:$PATH"

HISTSIZE=100000
HISTFILESIZE=100000
shopt -s histappend # append to history instead of overwriting it
PROMPT_COMMAND='history -a' # save history after each command instead of session exit

# Black       0;30     Dark Gray     1;30
# Red         0;31     Light Red     1;31
# Green       0;32     Light Green   1;32
# Brown       0;33     Yellow        1;33
# Blue        0;34     Light Blue    1;34
# Purple      0;35     Light Purple  1;35
# Cyan        0;36     Light Cyan    1;36
# Light Gray  0;37     White         1;37

FG_BLACK="\[\e[0;30m\]"
FG_RED="\[\e[0;31m\]"
FG_GREEN="\[\e[0;32m\]"
FG_BROWN="\[\e[0;33m\]"
FG_BLUE="\[\e[0;34m\]"
FG_PURPLE="\[\e[0;35m\]"
FG_CYAN="\[\e[0;36m\]"
FG_GRAY="\[\e[0;37m\]"
FG_RESET="\[\e[0m\]"

# b     red
# c     green
# d     brown
# e     blue
# f     magenta
# g     cyan
# h     light grey
# A     bold black, usually shows up as dark grey
# B     bold red
# C     bold green
# D     bold brown, usually shows up as yellow
# E     bold blue
# F     bold magenta
# G     bold cyan
# H     bold light grey; looks like bright white
# x     default foreground or background
#
#               ┌─ directory
#               | ┌─ symbolic link
#               | | ┌─ socket
#               | | | ┌─ pipe
#               | | | | ┌─ executable
#               | | | | | ┌─ block special
#               | | | | | | ┌─ character special
#               | | | | | | | ┌─ executable with setuid bit set
#               | | | | | | | | ┌─ executable with setgid bit set
#               | | | | | | | | | ┌─ directory writable to others, with sticky bit
#               | | | | | | | | | | ┌─ directory writable to others, without sticky bit
#               v v v v v v v v v v v
export LSCOLORS=gxfxcxdxfxegedabagacad
export CLICOLOR=1

export PROMPT_COMMAND=make_prompt

function make_prompt {
  local EXIT="$?"
  PS1="\u@\h \w\$(git-radar --bash --fetch | sed 's/git://' | sed 's/30m/33m/g' | sed 's/1;/0;/g')\n"

  if [ $EXIT == 0 ]; then
    PS1+="${FG_BROWN}❍${FG_RESET} "
  else
    PS1+="${FG_RED}❍${FG_RESET} "
  fi

  # side-effect to set the title in iterm2
  if [ $ITERM_SESSION_ID ]; then
    local h=`uname -n | tr -d '.local'`
    local u=`whoami`
    local p=${PWD/#$HOME/'~'} # replace "/Users/pje" with "~"

    echo -ne "\033];$u@$h:$p\007"
  fi
}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
source "$HOME/.cargo/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
