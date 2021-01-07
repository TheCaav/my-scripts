#!/bin/sh
# Wrappers for find without error output
function f {
	find / -name "$@" 2> /dev/null
}
function fd {
	find "$1" -name "$2" 2> /dev/null
}
