# This file can be sourced from ash, bash, dash and ksh shells.

load_co_variables () {
	# line variables
	if [ -f ~/.co/dirt ]; then
		. ~/.co/populate.sh
		rm ~/.co/dirt
	fi
	
	# answer variables
	if [ -f ~/.co/ans-dirt ]; then
		. ~/.co/ans.sh
		rm ~/.co/ans-dirt
	fi
}

trap 'load_co_variables' CONT

