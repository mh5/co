#!/usr/bin/env bats

setup () {
	if ! [ -n "$co_cache" ]; then
		co_cache="$HOME"/.co
	fi
}

### selecting lines in a single step, e.g., `ls | co 1' ###

@test "(single step) selecting one line out of one line" {
	result="$(echo "Hello, world!" | co 1)"
	[ "$result" = "Hello, world!" ]
}

@test "(single step) selecting one line out of multiple lines" {
	result="$(printf "Hello\nworld!\nbye\nworld" | co 2)"
	[ "$result" = "world!" ]
}


@test "(single step) selecting one line out of multiple lines" {
	result="$(printf "Hello\nworld!\nbye\nworld" | co 3)"
	[ "$result" = "bye" ]
}

@test "(single step) selecting last line (single step)" {
	result="$(printf "Hello\nworld!\nbye\nworld" | co 4)"
	[ "$result" = "world" ]
}

@test "(single step) selecting a line with multiple white spaces" {
	result="$(printf "Hello	   world" | co 1)"
	[ "$result" = "Hello	   world" ]
}

### selecting lines in 2 steps, e.g., `ls | co; co 1' ###

@test "(two steps) selecting one line out of one line" {
	printf "hellO worldd" | co 
	echo "$result"
	result=$(co 1)
	[ "$result" = "hellO worldd" ]
}

@test "(two steps) selecting last line out of multiple lines" {
	printf "abc def\nghi  jkl\nmno pqr" | co
	result="$(co 3)"
	[ "$result" = "mno pqr" ]
}

### variables ###

@test "(line variables)" {
	printf "The quick\nbrown fox\njumps over\nthe lazy dog." | co
	source "$co_cache"/populate.sh
	# TODO: variable names should depend on configuration
	[ "$l1" = "The quick" ]
	[ "$l2" = "brown fox" ]
	[ "$l3" = "jumps over" ]
	[ "$l4" = "the lazy dog." ]
}

@test "(answer variable)" {
	printf "The quick\nbrown fox\njumps over\nthe lazy dog."
	co 1
	source "$co_cache"/ans.sh
	[ "$ans" = "The quick" ]
	co 4
	source "$co_cache"/ans.sh
	[ "$ans" = "the lazy dog." ]
}

