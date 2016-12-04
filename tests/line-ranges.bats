#!/usr/bin/env bats

setup () {
	stdout="Roses are roses\nViolets are violets\nLet's state the facts\nAnd say what's true"
}

@test "(two steps) selecting first 2 lines out of multiple lines" {
	printf "$stdout" | co
	run co 1:2
	[ "${lines[0]}" = "Roses are roses" ]
	[ "${lines[1]}" = "Violets are violets" ]
}

@test "(two steps) selecting first 4 lines out of 4 lines" {
	printf "$stdout" | co
	run co 1:4
	[ "${lines[0]}" = "Roses are roses" ]
	[ "${lines[1]}" = "Violets are violets" ]
	[ "${lines[2]}" = "Let's state the facts" ]
	[ "${lines[3]}" = "And say what's true" ]
}
