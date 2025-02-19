#!/usr/bin/env bash

# Copyright (c) CDQ AG

function printrr() {
	echo "$1" >&2
}

function print_error() {
	if [ "$GITHUB_ACTIONS" == "true" ]; then
		printrr "::error title=$1::$2"
	else
		printrr "Error: $2"
	fi
}

function print_info() {
	if [ "$GITHUB_ACTIONS" == "true" ]; then
		printrr "::info title=$1::$2"
	else
		printrr "Info: $2"
	fi
}

function print_debug() {
	if [ "$GITHUB_ACTIONS" == "true" ]; then
		printrr "::debug::$1"
	fi
}
