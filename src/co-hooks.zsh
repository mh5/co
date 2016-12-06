# This file can be sourced from zsh shells.

function load_co_variables() {
	# if no path for co cache is specified, default to ~/.co
	if ! [[ -n "$co_cache" ]]; then
		co_cache="$HOME"/.co
	fi

	# load hooks configuration written by the main script
	if [[ -e "$co_cache"/hooks-conf.sh ]]; then
		source "$co_cache"/hooks-conf.sh
	fi
	
	# line variables
	if [[ -f "$co_cache"/dirt ]]; then
		. "$co_cache"/populate.sh
		rm "$co_cache"/dirt
	fi
	
	# answer variables
	if [[ -f "$co_cache"/ans-dirt ]]; then
		. "$co_cache"/ans.sh
		rm "$co_cache"/ans-dirt
		eval "$co_on_ans"
	fi

	# if the clear flag is on
	if [[ "$co_clear" = "1" ]]; then
		> "$co_cache"/ans.sh
		> "$co_cache"/populate.sh
		> "$co_cache"/hooks-conf.sh
		co_clear=""
	fi
}

add-zsh-hook preexec load_co_variables

