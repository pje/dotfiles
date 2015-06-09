export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=~/bin:$PATH

[[ -x /usr/libexec/java_home ]] && export JAVA_HOME="`/usr/libexec/java_home`"

export EDITOR=vim
export GOPATH=~/go

function current_git_branch {
  git branch 2> /dev/null | ack '^\* (.*?)$' --output '$1' -h
}

function filenames_of_git_changes {
  cat <( git ls-files --others --exclude-standard ) <( git diff --name-only HEAD )
}

function cwd_sublime_project {
  find . -name '*.sublime-project' -depth 1 | head -n1
}

function sublp {
  subl --project `cwd_sublime_project`
}

function sublch {
  filenames_of_git_changes | xargs subl --project `cwd_sublime_project`
}

alias g="git"
alias be="bundle exec"
alias bzk="bazooka"
