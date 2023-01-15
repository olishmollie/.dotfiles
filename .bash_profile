# Default Editor
export VISUAL=vi
export EDITOR=vi

alias grep='grep --color=auto'
alias ls='ls --color=always'
alias nx='sudo nx'

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

red='\[\e[0;31m\]'
yellow='\[\e[0;93m\]'
blue='\[\e[0;94m\]'
color_reset='\[\e[0m\]'

if [ -n "$SSH_CLIENT" ]; then
	prompt_color=$yellow
else
	prompt_color=$red
fi

export PS1="$prompt_color\u@\h$color_reset \W:> "

# Configure git awareness
gitaware=false
if [ -f "/usr/local/etc/bash_completion.d/git-prompt.sh" ]; then
	source /usr/local/etc/bash_completion.d/git-prompt.sh
	gitaware=true
fi
if [ -f "/etc/bash_completion.d/git-prompt" ]; then
	source /etc/bash_completion.d/git-prompt
	gitaware=true
fi
if [ "$gitaware" = true ]; then
    GIT_PS1_SHOWCOLORHINTS=1
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUPSTREAM="auto"
    PROMPT_COMMAND="__git_ps1 '$prompt_color\u@\h$color_reset \W' ':> '; $PROMPT_COMMAND"
fi

# Path configuration
export PATH="$PATH:/usr/local/opt/llvm/bin"

# Source Rust environment
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
