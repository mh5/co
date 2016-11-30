# This file can be sourced from fish shells

# changes assignments from dash shell format to fish shell format.
function reformat_assignments
	# prepend "set -g "
	perl -p -e 's/^/set -g /' "$argv[1]" > "$argv[1]-fish"

	# replace "=" with a space
	perl -pi -e 's/=/ /g' "$argv[1]-fish"
end

function load_co_variables --on-event fish_postexec
	# handle line variables
	if test -e ~/.co/dirt
		reformat_assignments ~/.co/populate.sh
		source ~/.co/populate.sh-fish
		true > ~/.co/populate.sh-fish
		rm ~/.co/dirt
	end

	# handle answer variables
	if test -e ~/.co/ans-dirt
		reformat_assignments ~/.co/ans.sh
		source ~/.co/ans.sh-fish
		true > ~/.co/ans.sh-fish
		rm ~/.co/ans-dirt
	end
end

