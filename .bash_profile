# Default Editor
export VISUAL=vi
export EDITOR=vi

alias grep='grep --color=auto'
alias ls='ls --color=auto'

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

red='\[\e[0;31m\]'
yellow='\[\e[0;93m\]'
blue='\[\e[0;94m\]'
color_reset='\[\e[0m\]'

if [ "$(hostname)" = "abond-vm" ]; then
    prompt_color=$blue
elif [ "$(hostname)" = "abond-rpi" ]; then
    prompt_color=$yellow
else
    prompt_color=$red
fi

export PS1="$prompt_color\u@\h$color_reset \W:> "

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
    PROMPT_COMMAND="__git_ps1 '$prompt_color\u@\h$color_reset \W' ':> '; $PROMPT_COMMAND"
fi

# Path configuration
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/usr/local/opt/llvm/bin"
export PATH=$"$PATH:$HOME/.cabal/bin"
export PATH=$"$HOME/Tools/gcc-arm-none-eabi/bin:$PATH"

. "$HOME/.cargo/env"
