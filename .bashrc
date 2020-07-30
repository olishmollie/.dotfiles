source "$HOME/.bash_profile"

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
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
