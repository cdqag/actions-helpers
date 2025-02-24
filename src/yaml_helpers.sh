#!/usr/bin/env bash

# Get the value of a key from a yaml file.
# 
# requires sourcing log_helpers.sh
#
# Copyright (c) CDQ AG

get_value_from_yaml() {
	local YAML_PATH=$1
	local KEY=$2
	local DEFAULT_VALUE=$3

	if [[ -z "$YAML_PATH" ]]; then
		log_error "Invalid input" "Yaml file path cannot be an empty string"
		exit 21
	fi

	if [[ ! -f "$YAML_PATH" ]]; then
		log_error "File not found" "File $YAML_PATH does not exist"
		exit 22
	fi

	if [[ -z "$KEY" ]]; then
		log_error "Invalid input" "key cannot be an empty string"
		exit 23
	fi

	# Try to fetch the value from the yaml file
	VALUE=$(yq $KEY "$YAML_PATH")

	# If not, use the default value
	if [[ -z "$VALUE" || "$VALUE" == "null" ]]; then
		VALUE=$DEFAULT_VALUE
	fi

	echo $VALUE
}

