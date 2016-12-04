#!/usr/bin/env bats

setup () {
	if ! [ -n "$co_cache" ]; then
		co_cache="$HOME"/.co
	fi
}

@test "(two steps) selecting a whole line as a word range" {
	echo "I like turtles" | co
	result="$(co 1 1:-1)"
	[ "$result" = "I like turtles" ]
}

@test "(two steps) selecting one word as a word range" {
	echo "I like turtles" | co
	result="$(co 1 2:2)"
	[ "$result" = "like" ]
}

@test "(two steps) selecting a range with inverted indices" {
	echo "I like turtles" | co
	result="$(co 1 -1:1)"
	[ "$result" = "I like turtles" ]
}

@test "(two steps) selecting word range - answer variable" {
	echo "I like turtles" | co
	result="$(co 1 2:-1)"
	source "$co_cache"/ans.sh
	[ "$ans" = "like turtles" ]
}
