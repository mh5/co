#!/usr/bin/env bats

setup () {
	if ! [ -n "$co_cache" ]; then
		co_cache="$HOME"/.co
	fi
}

### selecting words in a single step, e.g., `ls | co 1 1' ###

@test "(single step) selecting first word in a line" {
	result="$(echo "Hello, world!" | co 1 1)"
	[ "$result" = "Hello," ]
}

@test "(single step) selecting last word in a line" {
	result="$(echo "Hello, world!" | co 1 -1)"
	[ "$result" = "world!" ]
}

@test "(single step) selecting a middle word in a line" {
	result="$(echo "Hello, world! How are you?" | co 1 3)"
	[ "$result" = "How" ]
}

### selecting words in a multiple steps, e.g., `ls | co; co 1 1' ###

@test "(two steps) selecting a middle word in a line" {
	echo "Hello, world! How are you?" | co
	result="$(co 1 3)"
	[ "$result" = "How" ]
}

### variables ###

@test "(single and multiple steps) word selection - answer variable" {
	echo "Abc def ghi jkl mnop qrs" | co 1 4
	source "$co_cache"/ans.sh
	[ "$ans" = "jkl" ]

	co 1 2
	source "$co_cache"/ans.sh
	[ "$ans" = "def" ]
}
