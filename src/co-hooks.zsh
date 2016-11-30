# This file can be sourced from zsh shells.

function load_co_variables() {
	# handle line variables
	if [[ -f ~/.co/dirt ]]; then
		source ~/.co/populate.sh;
		rm ~/.co/dirt
	fi

	# handle answer variables
	if [[ -f ~/.co/ans-dirt ]]; then
		source ~/.co/ans.sh;
		rm ~/.co/ans-dirt
	fi
}

add-zsh-hook preexec load_co_variables

