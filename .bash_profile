# Default Editor
export VISUAL=vim
export EDITOR="vi -e"
alias e='code $1'

# CDPATH - cd directly into dev
export CDPATH=$HOME/dev

# Prompt
Red='\[\e[0;31m\]'
ColorReset='\[\e[0m\]'

function add_venv_info() {
  if [ -z "$VIRTUAL_ENV_DISABLE_PROMPT" ]; then
    if [ "$VIRTUAL_ENV" != "" ]; then
      PS1="(`basename \"$VIRTUAL_ENV\"`) $PS1"
    fi
  fi
}

if [ -f "/usr/local/etc/bash_completion.d/git-prompt.sh" ]; then
  source /usr/local/etc/bash_completion.d/git-prompt.sh

  GIT_PS1_SHOWCOLORHINTS=1
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUPSTREAM="auto"
  PROMPT_COMMAND="__git_ps1 '$Red\u$ColorReset \W' ':> '; add_venv_info; $PROMPT_COMMAND"
else
  export PS1="$Red\u$ColorReset \W :>"
fi

# Source bash completions
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

function mkcd() {
  mkdir $1; cd $1;
}

function restart() {
  exec -l bash
}

function serve() {
  ruby -run -e httpd $1 -p $2
}

function gclonecd() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

# Venv
function venv_activate() {
  . $1/bin/activate
}

# Postgres
function pg_start() {
  eval "pg_ctl -D /usr/local/var/postgres start"
}

function pg_stop() {
  eval "pg_ctl -D /usr/local/var/postgres stop"
}

# Colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export GREP_OPTIONS='--color=always'

# Auto-load rbenv
if type "rbenv" > /dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# Aliases/functions
if type "bundle" > /dev/null 2>&1; then
  alias be='bundle exec'
fi

if type "nvim" > /dev/null 2>&1
then
  alias vim='nvim'
elif type "mvim" > /dev/null 2>&1
then
  alias vim='mvim'
fi

# Move to H: drive if on ACC windows computer
if [ "-d /h" ] && [ "$(uname)" = "MINGW64_NT-6.1" ]; then
  cd /h
fi

# Set GOPATH and add go bin to PATH
export GOPATH=$HOME/dev/go
export PATH=$GOPATH/bin:$PATH

# Add rust executables to path
export PATH="$HOME/.cargo/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/ajbond/.sdkman"
[[ -s "/Users/ajbond/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/ajbond/.sdkman/bin/sdkman-init.sh"
