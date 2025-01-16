#!/usr/bin/env bash

# Copyright (c) CDQ AG

function is_json() {
	echo "$1" | jq . >/dev/null 2>&1
}
