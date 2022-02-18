# Default Editor
export VISUAL=vi
export EDITOR=vi

export CLICOLOR=1
alias grep=grep --color=auto

# Set main go directory
export GOPATH=$HOME/Dev/go

# Configure Python virtual env awareness
set_venv() {
	if [ -n "$VIRTUAL_ENV" ]; then
		PS1="($(basename "$VIRTUAL_ENV")) $PS1"
		export PS1
	fi
}

# Source bash completions
[ -r "/usr/local/etc/profile.d/bash_completion.sh" ] && source "/usr/local/etc/profile.d/bash_completion.sh"
[ -r "/etc/profile.d/bash_completion.sh" ] && source "/etc/profile.d/bash_completion.sh"

# Prompt
PROMPT_COMMAND=set_venv

Red='\[\e[0;31m\]'
ColorReset='\[\e[0m\]'

export PS1="$Red\u$ColorReset \W:> "

# Configure git awareness
if [ -f "/usr/local/etc/bash_completion.d/git-prompt.sh" ] ||
   [ -f "/etc/bash_completion.d/git-prompt" ]; then
	# TODO: -- I would rather not silence errors here.
	source /usr/local/etc/bash_completion.d/git-prompt.sh 2>/dev/null
	source /etc/bash_completion.d/git-prompt 2>/dev/null

  GIT_PS1_SHOWCOLORHINTS=1
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUPSTREAM="auto"
  PROMPT_COMMAND="__git_ps1 '$Red\u$ColorReset \W' ':> '; $PROMPT_COMMAND"
fi

. "$HOME/.cargo/env"

# Path configuration
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/usr/local/opt/llvm/bin"
export PATH=$"$PATH:$HOME/.cabal/bin"
export PATH=$"$HOME/Tools/gcc-arm-none-eabi/bin:$PATH"

