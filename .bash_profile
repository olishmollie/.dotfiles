# .bash_profile

_terminal() {
	export VISUAL=nvim
	export EDITOR=nvim
    alias vim="nvim"
	alias grep='grep --color=auto'
	alias ls='ls --color=always'
    alias open='xdg-open'
}

_venv() {
	if [ -n "$VIRTUAL_ENV" ]; then
		PS1="($(basename "$VIRTUAL_ENV")) $PS1"
		export PS1
	fi
}

_prompt() {
	PROMPT_COMMAND=_venv

	red='\[\e[0;31m\]'
	yellow='\[\e[0;93m\]'
	blue='\[\e[0;94m\]'
	green='\[\e[0;32m\]'
	color_reset='\[\e[0m\]'

	if [ -n "$SSH_CLIENT" ]; then
		prompt_color=$yellow
	else
		prompt_color=$green
	fi

	export PS1="$prompt_color\u@\h$color_reset \w:> "

	gitaware=false
	if [ -f "/usr/local/etc/bash_completion.d/git-prompt.sh" ]; then
		source /usr/local/etc/bash_completion.d/git-prompt.sh
		gitaware=true
	elif [ -f "/etc/bash_completion.d/git-prompt" ]; then
		source /etc/bash_completion.d/git-prompt
		gitaware=true
	elif [ -f "/usr/share/git/completion/git-prompt.sh" ]; then
		source /usr/share/git/completion/git-prompt.sh
		gitaware=true
	fi
	if [ "$gitaware" = true ]; then
    GIT_PS1_SHOWCOLORHINTS=1
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUPSTREAM="auto"
    PROMPT_COMMAND="__git_ps1 '$prompt_color\u@\h$color_reset \w' ':> '; $PROMPT_COMMAND"
	fi
}

_env() {
    export PATH="/home/abond/.local/bin:$PATH"
    export PATH="/home/abond/.local/texlive/2024/bin/x86_64-linux:$PATH"
    export MANPATH="/home/abond/.local/texlive/2024/texmf-dist/doc/man:$MANPATH"
    export INFOPATH="/home/abond/.local/texlive/2024/texmf-dist/doc/info:$INFOPATH"
    export NVM_DIR="$HOME/.nvm"

    # Load Node Version Manager (nvm)
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    # Load nvm bash_completion
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

	if [ -f "$HOME/.cargo/env" ]; then
	    . "$HOME/.cargo/env"
	fi
}

_completions() {
	[ -r "/usr/local/etc/profile.d/bash_completion.sh" ] && source "/usr/local/etc/profile.d/bash_completion.sh"
	[ -r "/etc/profile.d/bash_completion.sh" ] && source "/etc/profile.d/bash_completion.sh"
	[ -r "/usr/share/git/completion/git-completion.bash" ] && source "/usr/share/git/completion/git-completion.bash"
}

_terminal
_prompt
_env
_completions

