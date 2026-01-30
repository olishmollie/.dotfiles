profile() {
    export VISUAL=nvim
    export EDITOR=nvim

    alias vim="nvim"
    alias grep='grep --color=auto'
    alias ls='ls --color=always'
    alias open="xdg-open"

    _venv() {
        if [ -n "$VIRTUAL_ENV" ]; then
            PS1="($(basename "$VIRTUAL_ENV")) $PS1"
            export PS1
        fi
    }

    PROMPT_COMMAND=_venv

    local red='\[\e[0;31m\]'
    local yellow='\[\e[0;93m\]'
    local blue='\[\e[0;94m\]'
    local green='\[\e[0;32m\]'
    local color_reset='\[\e[0m\]'
    local delim="$ "

    local prompt_color
    if [ -n "$SSH_CLIENT" ]; then
        prompt_color=$yellow
    elif [ -f "/.dockerenv" ]; then
        prompt_color=$blue
    else
        prompt_color=$green
    fi

    local prompt="$prompt_color\u@\h$color_reset$blue:$color_reset\w"
    export PS1="$prompt$delim"

    local gitaware=false
    if [ -f "/usr/local/etc/bash_completion.d/git-prompt.sh" ]; then
        source /usr/local/etc/bash_completion.d/git-prompt.sh
        gitaware=true
    elif [ -f "/etc/bash_completion.d/git-prompt" ]; then
        source /etc/bash_completion.d/git-prompt
        gitaware=true
    elif [ -f "/usr/share/git/completion/git-prompt.sh" ]; then
        source /usr/share/git/completion/git-prompt.sh
        gitaware=true
    elif [ -f "/opt/local/share/git/git-prompt.sh" ]; then
        source /opt/local/share/git/git-prompt.sh
        gitaware=true
    fi
    if [ "$gitaware" = true ]; then
        GIT_PS1_SHOWCOLORHINTS=1
        GIT_PS1_SHOWDIRTYSTATE=1
        GIT_PS1_SHOWUNTRACKEDFILES=1
        GIT_PS1_SHOWSTASHSTATE=1
        GIT_PS1_SHOWUPSTREAM="auto"
        PROMPT_COMMAND="__git_ps1 '$prompt' '$delim'; $PROMPT_COMMAND"
    fi

    export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
    export PATH="$HOME/.local/bin:$PATH"
    export PATH="$HOME/tools/nvim-linux-x86_64/bin:$PATH"
    export PATH="$HOME/qp/qm/bin:$PATH"
    export PATH="$HOME/qp/qtools/bin:$PATH"

    export CPM_SOURCE_CACHE=$HOME/.cache/CPM

    # Cargo
    if [ -f "$HOME/.cargo/env" ]; then
      . "$HOME/.cargo/env"
    fi

    # Nvm
    if [ -d "$HOME/.nvm" ]; then
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    fi

    # Neovim
    if [ -d "/opt/nvim-linux-x86_64" ]; then
        export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
    fi

    [ -r "/usr/local/etc/profile.d/bash_completion.sh" ] && source "/usr/local/etc/profile.d/bash_completion.sh"
    [ -r "/etc/profile.d/bash_completion.sh" ] && source "/etc/profile.d/bash_completion.sh"
    [ -r "/usr/share/git/completion/git-completion.bash" ] && source "/usr/share/git/completion/git-completion.bash"
    [ -r "/opt/local/etc/bash_completion" ] && source "/opt/local/etc/bash_completion"

    # Added by Toolbox App
    export PATH="$PATH:/home/abond/.local/share/JetBrains/Toolbox/scripts"
}

profile
unset profile
