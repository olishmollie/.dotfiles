# Default Editor
export VISUAL=vim
export EDITOR=$VISUAL

# Gmail Username and Password
export GMAIL_USERNAME='olishmollie@gmail.com'
export GMAIL_PASSWORD='k#>6yu}O>fjgrI,g.<dD9)[sh'

# Prompt
Red='\[\e[0;31m\]'
ColorReset='\[\e[0m\]'
li=$'\xe2\x98\xb2'

if [ -d "/usr/local/etc/bash_completion.d" ]; then
  source /usr/local/etc/bash_completion.d/git-prompt.sh

  GIT_PS1_SHOWCOLORHINTS=1
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUPSTREAM="auto"
  PROMPT_COMMAND="__git_ps1 '$Red$li$ColorReset \W' ':> '; $PROMPT_COMMAND"

  # git completion
  source /usr/local/etc/bash_completion.d/git-completion.bash

  # pass completion
  source /usr/local/etc/bash_completion.d/pass-completion.bash
fi

# tmuxinator completion
if [ -d "~/.tmuxinator" ]; then
  source ~/.tmuxinator.bash
fi

# Aliases/functions
alias be='bundle exec'
alias vim='mvim -v'

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
eval "$(rbenv init -)"
