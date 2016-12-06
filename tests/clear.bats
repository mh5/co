#!/usr/bin/env bats

setup () {
	stdout="Roses are roses\nViolets are violets\nLet's state the facts\nAnd say what's true"

	if ! [ -n "$co_cache" ]; then
		co_cache="$HOME"/.co
	fi
}

@test "clearing variables" {
	printf "$stdout" | co
	co 1

	co clear

	source "$co_cache"/populate.sh
	source "$co_cache"/ans.sh
	
	[ "$ans" = "" ]
	[ "$l1" = "" ]
	[ "$l2" = "" ]
	[ "$l3" = "" ]
	[ "$l4" = "" ]
	[ "$l5" = "" ]
	
	
	# TODO: this should be done by the trap
	> "$co_cache"/ans.sh
	> "$co_cache"/populate.sh
	> "$co_cache"/hooks-conf.sh
}

@test "clearing cache files" {

	# TODO: implement this
	skip "Tests are not implemented yet."
}
