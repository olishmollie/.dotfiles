# Default Editor
export VISUAL=vim
export EDITOR=vim

# Prompt
Red='\[\e[0;31m\]'
ColorReset='\[\e[0m\]'

if [ -f "/usr/local/etc/bash_completion.d/git-prompt.sh" ]; then
  source /usr/local/etc/bash_completion.d/git-prompt.sh

  GIT_PS1_SHOWCOLORHINTS=1
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUPSTREAM="auto"
  PROMPT_COMMAND="__git_ps1 '$Red\u$ColorReset \W' ':> '; venv_info; $PROMPT_COMMAND"
else
  export PS1="$Red\u$ColorReset \W:> "
fi

# Source bash completions
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

function mkcd() {
  mkdir "$1"
  cd "$1" || return
}

function venv() {
  python3 -m venv "$1"
  . "$1/bin/activate"
}

function venv_up() {
  . "$1/bin/activate"
}

function venv_info() {
  if [ -z "$VIRTUAL_ENV_DISABLE_PROMPT" ]; then
    if [ "$VIRTUAL_ENV" != "" ]; then
      PS1="($(basename "$VIRTUAL_ENV")) $PS1"
    fi
  fi
}

export CLICOLOR=1
export GREP_OPTIONS='--color=always'

# Add rust executables to path
export PATH="$HOME/.cargo/bin:$PATH"

# Set main go directory
export GOPATH=$HOME/Dev/go
# Add GO bin to path
export PATH="$GOPATH/bin:$PATH"

