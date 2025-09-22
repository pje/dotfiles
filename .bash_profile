#! /bin/bash
# sourced and executed once on login

if [ "$(uname -s)" == "Darwin" ]; then
  if [ "$(uname -m)" == arm64 ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

fi

export GOPATH=~/go

export PATH=/usr/bin:$PATH
export PATH="$HOMEBREW_PREFIX"/bin:$PATH
export PATH="$HOMEBREW_PREFIX"/sbin:$PATH
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=/usr/local/lib/ruby/gems/3.1.0/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=~/.yarn/bin:$PATH
export PATH=~/.config/yarn/global/node_modules/.bin:$PATH
export PATH=~/Library/Python/3.7/bin:$PATH
export PATH=~/bin:$PATH
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin":$PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

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

# make fzf follow symlinks and NOT ignore .dotfiles by default
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

if [ "$(which brew)" ]; then
  # shellcheck source=/dev/null
  [ -s "$HOMEBREW_PREFIX/etc/bash_completion" ] && source "$HOMEBREW_PREFIX/etc/bash_completion"

  # shellcheck source=/dev/null
  [ -s "$HOMEBREW_PREFIX/etc/bash_completion.d/git-prompt.sh" ] && source "$HOMEBREW_PREFIX/etc/bash_completion.d/git-prompt.sh"

  # shellcheck source=/dev/null
  [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm

  # shellcheck source=/dev/null
  [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && source "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
fi

if [ -n "$CODESPACES" ]; then
  # shellcheck source=/dev/null
  [ -s /usr/share/bash-completion/completions/git ] && source /usr/share/bash-completion/completions/git

  # workaround for `xterm-ghostty` not being recognized by codespaces yet: https://ghostty.org/docs/help/terminfo
  export TERM=xterm-256color
fi

# shellcheck source=/dev/null
[ -s ~/.cargo/env ] && source ~/.cargo/env
# shellcheck source=/dev/null
[ -s ~/.fzf.bash ] && source ~/.fzf.bash

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
  local prompt_symbol
  local user
  local host
  local path
  EXIT="$?"
  prompt_symbol="❍"
  host="$(which scutil > /dev/null && scutil --get ComputerName || uname -n | sed 's/.local//')"
  user="$(whoami)"
  path=${PWD/#$HOME/'~'} # replace e.g. "/Users/pje" with "~"

  if [ -n "$CODESPACES" ]; then
    host="$(echo "$CODESPACE_NAME" | sed 's/^\w\+-//' | sed 's/-[a-z0-9]\+$//')"
  fi

  PS1="$user@$host $path"

  if is_git_dir "$(pwd)"; then
    if [[ $(basename "$(git rev-parse --show-toplevel)") != "github" ]]; then
      gitstatus_prompt_update
      PS1+='${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT}'    # git status (requires promptvars option)
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
    echo -ne "\033];$user@$host:$path\007"
  fi
}

# git status prompt
source ~/git_status_prompt.sh

# Start gitstatusd in the background.
gitstatus_stop && gitstatus_start -s -1 -u -1 -c -1 -d -1

# Enable promptvars so that ${GITSTATUS_PROMPT} in PS1 is expanded.
shopt -s promptvars

# On every prompt, fetch git status and set GITSTATUS_PROMPT.
export PROMPT_COMMAND=make_prompt
export PROMPT_DIRTRIM=3

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Created by `pipx`
export PATH="$PATH:/Users/pje/.local/bin"


