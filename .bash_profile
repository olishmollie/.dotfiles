# Default Editor
export VISUAL=emacs
export EDITOR=emacs

function ec() {
	emacsclient -n -a '' "$1"
}

# Temporary alternative to Valgrind
function leakcheck() {
	# See advice about symlink given here: https://www.reddit.com/r/macprogramming/comments/7iao6d/using_the_leaks_command_on_a_cc_executable/
	sudo ln -s /Applications/Xcode.app/Contents/Developer/usr/lib/libLeaksAtExit.dylib /usr/local/lib/libLeaksAtExit.dylib
	leaks --atExit -- "$1"
	rm /usr/local/lib/libLeaksAtExit.dylib
}

# Prompt
Red='\[\e[0;31m\]'
ColorReset='\[\e[0m\]'

# Configure git awareness
if [ -f "/usr/local/etc/bash_completion.d/git-prompt.sh" ]; then
  source /usr/local/etc/bash_completion.d/git-prompt.sh

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
export GREP_OPTIONS='--color=always'

# Set main go directory
export GOPATH=$HOME/Dev/go

# Source bash completions
[ -r "/usr/local/etc/profile.d/bash_completion.sh" ] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Path configuration
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/usr/local/opt/llvm/bin"
