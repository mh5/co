#!/usr/bin/env bats

setup () {
	stdout="Roses are roses\nViolets are violets\nLet's state the facts\nAnd say what's true"

	if ! [ -n "$co_cache" ]; then
		co_cache="$HOME"/.co
	fi
}

@test "line variables" {
	printf "$stdout" | co
	run printf "$stdout"
	source "$co_cache"/populate.sh
	[ "$l1" = "${lines[0]}" ]
	[ "$l2" = "${lines[1]}" ]
	[ "$l3" = "${lines[2]}" ]
	[ "$l4" = "${lines[3]}" ]
}

@test "shifting answer variables (1 shift)" {
	# TODO: should read answer prefix and max answer variables from configuration
	printf "$stdout" | co 1
	source "$co_cache"/ans.sh
	[ "$ans" = "Roses are roses" ]
}

@test "shifting answer variables (multiple shifts)" {
	printf "$stdout" | co

	co 1
	source "$co_cache"/ans.sh
	[ "$ans" = "Roses are roses" ]

	co 4
	source "$co_cache"/ans.sh
	[ "$ans1" = "Roses are roses" ]

	co 4
	source "$co_cache"/ans.sh
	[ "$ans2" = "Roses are roses" ]

	co 4
	source "$co_cache"/ans.sh
	[ "$ans3" = "Roses are roses" ]
}
