# Default Editor
export VISUAL=emacs
export EDITOR=$VISUAL

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
  PROMPT_COMMAND="__git_ps1 '$Red\u$ColorReset \W' ':> '; $PROMPT_COMMAND"
else
  export PS1="$Red\u$ColorReset \W :> "
fi

# git completion
if [ -f "/usr/local/etc/bash_completion.d/git-completion.bash" ]; then
  source /usr/local/etc/bash_completion.d/git-completion.bash
fi

# tmuxinator completion
if [ -d "~/.tmuxinator" ]; then
  source ~/.tmuxinator.bash
fi

# timer completion
if [ -d "$HOME/.timer" ]; then
  source /usr/local/etc/bash_completion.d/timer-completion.bash
fi

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

if type "mvim" > /dev/null 2>&1; then
  alias vim='mvim -v'
fi

# Move to H: drive if on ACC windows computer
if [ "-d /h" ] && [ "$(uname)" = "MINGW64_NT-6.1" ]; then
  cd /h
fi

