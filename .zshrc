# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/ajbond/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	# zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Use emacs keybindings
bindkey -e

POWERLEVEL9K_MODE="nerdfont-complete"

# Default text editor
export VISUAL=code
export EDITOR=vim

# Vterm/Emacs integration
if [ -n "$INSIDE_EMACS" ]; then
	function vterm_printf(){
		if [ -n "$TMUX" ]; then
			# Tell tmux to pass the escape sequences through
			# (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
			printf "\ePtmux;\e\e]%s\007\e\\" "$1"
		elif [ "${TERM%%-*}" = "screen" ]; then
			# GNU screen (screen, screen-256color, screen-256color-bce)
			printf "\eP\e]%s\007\e\\" "$1"
		else
			printf "\e]%s\e\\" "$1"
		fi
	}

	function vterm_cmd() {
		if [ -n "$TMUX" ]; then
			# tell tmux to pass the escape sequences through
			# (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
			printf "\ePtmux;\e\e]51;E"
		elif [ "${TERM%%-*}" = "screen" ]; then
			# GNU screen (screen, screen-256color, screen-256color-bce)
			printf "\eP\e]51;E"
		else
			printf "\e]51;E"
		fi

		printf "\e]51;E"
		local r
		while [[ $# -gt 0 ]]; do
			r="${1//\\/\\\\}"
			r="${r//\"/\\\"}"
			printf '"%s" ' "$r"
			shift
		done
		if [ -n "$TMUX" ]; then
			# tell tmux to pass the escape sequences through
			# (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
			printf "\007\e\\"
		elif [ "${TERM%%-*}" = "screen" ]; then
			# GNU screen (screen, screen-256color, screen-256color-bce)
			printf "\007\e\\"
		else
			printf "\e\\"
		fi
	}

	function emacs_find_file() {
		vterm_cmd find-file-from-vterm "$(realpath "$@")"
	}
fi

# Open an in-terminal instance of emacs,
# or a new emacs window if emacs if already open.
function e() {
	if [ -n "$INSIDE_EMACS" ]; then
		emacs_find_file "$@"
	else
		emacsclient -nq -e '(server-running-p)'
		if [ "$?" = 1 ]; then
			emacsclient -nqc -a '' "$@"
			clear
		else
			isopen="$(emacsclient -nq -e '(> (length (frame-list)) 1)')"
			if [ "$isopen" = "nil" ]; then
				emacsclient -nqc "$@"
			else
				emacsclient -nq "$@"
			fi
		fi
	fi
}

# Kill a running emacs server.
function kill_emacs() {
	emacsclient -e '(kill-emacs)'
}

# Temporary alternative to Valgrind
function leakcheck() {
	if [ "$(uname)" = "Darwin" ]; then
		# See advice about symlink given here: https://www.reddit.com/r/macprogramming/comments/7iao6d/using_the_leaks_command_on_a_cc_executable/
		sudo ln -s /Applications/Xcode.app/Contents/Developer/usr/lib/libLeaksAtExit.dylib /usr/local/lib/libLeaksAtExit.dylib
		leaks --atExit -- "$1"
		rm /usr/local/lib/libLeaksAtExit.dylib
	fi
}

# Configure Go path
export GOPATH=$HOME/Dev/go

# Configure other path variables
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/usr/local/opt/llvm/bin"

export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export PATH="$PATH:$HOME/Dev/flutter/bin"
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

# Add .NET Core SDK tools
export PATH="$PATH:/Users/ajbond/.dotnet/tools"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(rbenv init -)"

