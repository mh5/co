# This file can be sourced from fish shells

# changes assignments from dash shell format to fish shell format.
function reformat_assignments
	# prepend "set -g "
	perl -p -e 's/^/set -g /' "$argv[1]" > "$argv[1]-fish"

	# replace "=" with a space
	perl -pi -e 's/=/ /g' "$argv[1]-fish"
end

function load_co_variables --on-event fish_postexec
	
	# if no path for co cache is specified, default to ~/.co
	if [ ! "$co_cache" ]
		set co_cache "$HOME"/.co
	end
	
	# handle line variables
	if test -e "$co_cache"/dirt
		reformat_assignments "$co_cache"/populate.sh
		source "$co_cache"/populate.sh-fish
		true > "$co_cache"/populate.sh-fish
		rm "$co_cache"/dirt
	end

	# handle answer variables
	if test -e "$co_cache"/ans-dirt
		reformat_assignments "$co_cache"/ans.sh
		source "$co_cache"/ans.sh-fish
		true > "$co_cache"/ans.sh-fish
		rm "$co_cache"/ans-dirt
	end
end

