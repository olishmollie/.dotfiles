# Default Editor
export VISUAL=emacs
export EDITOR=emacs

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
			isopen="$(emacsclient -nq -e '(> (length (frame-list)))' 1)"
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

# Source bash completions
[ -r "/usr/local/etc/profile.d/bash_completion.sh" ] && source "/usr/local/etc/profile.d/bash_completion.sh"
[ -r "/etc/profile.d/bash_completion.sh" ] && source "/etc/profile.d/bash_completion.sh"

# Prompt
Red='\[\e[0;31m\]'
ColorReset='\[\e[0m\]'

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
else
  export PS1="$Red\u$ColorReset \W:> "
fi

export CLICOLOR=1

# Deprecated on ubuntu
# export GREP_OPTIONS='--color=always'
alias grep=grep --color=auto

# Set main go directory
export GOPATH=$HOME/Dev/go

# Source bash completions
[ -r "/usr/local/etc/profile.d/bash_completion.sh" ] && . "/usr/local/etc/profile.d/bash_completion.sh"
[ -r "/etc/bash_completion.d/bash_completion" ] && . "/etc/bash_completion.d/bash_completion"

# Path configuration
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/usr/local/opt/llvm/bin"
export PATH=$"$PATH:$HOME/.cabal/bin"
export PATH=$"$PATH:/usr/local/sbin"
