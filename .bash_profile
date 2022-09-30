#! /bin/bash
# sourced and executed once on login

OS="$(uname)"

export GOPATH=~/go

export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=/usr/local/lib/ruby/gems/3.1.0/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=/usr/local/heroku/bin:$PATH
export PATH=~/.yarn/bin:$PATH
export PATH=~/.config/yarn/global/node_modules/.bin:$PATH
export PATH=~/Library/Python/3.7/bin:$PATH
export PATH=~/bin:$PATH
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin":$PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

if [[ "${OS}" == "Linux" ]]; then
  export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
fi

export EDITOR=vim
export NVM_DIR="$HOME/.nvm"
export PYTHONSTARTUP=$HOME/.pythonstartup.py

alias g="git"
alias be="bundle exec"
alias ccat='pygmentize -g'
alias preview="fzf --preview 'bat --style=numbers --color=always {}'"

# in bash versions >= 4, this enabled zsh-like recursive globbing
shopt -s globstar

# https://www.thomaslaurenson.com/blog/2018-07-02/better-bash-history/
HISTFILESIZE=-1 # No limit on the number of history lines
HISTSIZE=-1 # No limit on the number of history lines
HISTCONTROL=ignoredups # Do not store a duplicate of the last entered command
shopt -s histappend # append to history instead of overwriting it
shopt -s cmdhist # # Attempt to save all lines of a multiple-line command in the same entry
# see also the additions to make_prompt which regenerate history after every command.

# Black       0;30     Dark Gray     1;30
# Red         0;31     Light Red     1;31
# Green       0;32     Light Green   1;32
# Brown       0;33     Yellow        1;33
# Blue        0;34     Light Blue    1;34
# Purple      0;35     Light Purple  1;35
# Cyan        0;36     Light Cyan    1;36
# Light Gray  0;37     White         1;37
RESET="\[\e[0m\]"
# FG_BLACK="\[\e[0;30m\]"
FG_RED="\[\e[0;31m\]"
# FG_GREEN="\[\e[0;32m\]"
FG_BROWN="\[\e[0;33m\]"
# FG_BLUE="\[\e[0;34m\]"
# FG_PURPLE="\[\e[0;35m\]"
# FG_CYAN="\[\e[0;36m\]"
# FG_GRAY="\[\e[0;37m\]"
BG_GREEN="\[\e[48;5;2m"
# BG_BLUE="\[\e[48;5;12m"

# for i in {1..255}; do echo -ne "\x1b[48;5;"$i"m "$i" build@ip-10-212-3-21 \e[0m\n"; done

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

[ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" # Make the `brew` command available
# shellcheck source=/dev/null
[ -s ~/.cargo/env ] && source ~/.cargo/env
# shellcheck source=/dev/null
[ -s "$(brew --prefix)/etc/bash_completion" ] && source "$(brew --prefix)/etc/bash_completion"
# shellcheck source=/dev/null
[ -s "$(brew --prefix)/etc/bash_completion.d/git-prompt.sh" ] && source "$(brew --prefix)/etc/bash_completion.d/git-prompt.sh"
# shellcheck source=/dev/null
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && source "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
# shellcheck source=/dev/null
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && source "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
# shellcheck source=/dev/null
[ -s ~/.fzf.bash ] && source ~/.fzf.bash

export PROMPT_COMMAND=make_prompt

# make fzf follow symlinks and NOT ignore .dotfiles by default
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# return 0 iff it looks like we're in an ssh session
function is_ssh_session {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    return 0
  else
    case $(ps -o comm= -p $PPID) in
      sshd|*/sshd) return 0;;
    esac

    return 1
  fi
}

function is_git_dir {
  local path="$1"
  git -C "$path" rev-parse 2>/dev/null
}

function make_prompt {
  local EXIT
  local githud_path
  local prompt_symbol
  EXIT="$?"
  githud_path=$(brew --prefix)/bin/githud
  prompt_symbol=$(is_ssh_session && echo "$" || echo "❍")

  if is_ssh_session; then
    PS1="${BG_GREEN}\u@\h \w${RESET}"
  else
    PS1="\u@\h \w"
  fi

  if is_git_dir "$(pwd)"; then
    if [[ $(basename "$(git rev-parse --show-toplevel)") != "github" ]]; then
      PS1+=" \$($githud_path bash)"
    else
      PS1+=" ? [\$(git rev-parse --abbrev-ref HEAD)]"
    fi
  fi

  PS1+="\n"

  if [ $EXIT == 0 ]; then
    PS1+="${FG_BROWN}${prompt_symbol}${RESET} "
  else
    PS1+="${FG_RED}${prompt_symbol}${RESET} "
  fi

  # side-effect to set the title in iterm2
  if [ "$ITERM_SESSION_ID" ]; then
    local h
    local u
    local p
    h="$(uname -n | sed 's/.local//')"
    u="$(whoami)"
    p=${PWD/#$HOME/'~'} # replace "/Users/pje" with "~"

    echo -ne "\033];$u@$h:$p\007"
  fi
}
