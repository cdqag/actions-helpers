load "test_helper/bats-support/load"
load "test_helper/bats-assert/load"
load "test_helper/common"
load "$DIR/src/job_helpers.sh"

setup() {
	common_setup
}

teardown() {
	common_teardown
}

@test "set_env should exit with error if variable name is missing" {
	run set_env

	assert_failure
	assert_output "set_env: Variable name is required"
}

@test "set_env should not write to GITHUB_ENV if GITHUB_ACTIONS is not set" {
	run set_env "FOO" "bar"
	assert_success
	assert_output ""

	run cat "$GITHUB_ENV"
	assert_success
	assert_output ""
}

@test "set_env should write to GITHUB_ENV if GITHUB_ACTIONS is set" {
	GITHUB_ACTIONS="true"

	run set_env "FOO" "bar"
	assert_success
	assert_output ""
	
	run cat "$GITHUB_ENV"
	assert_success
	assert_output "FOO=bar"
}

@test "set_output should exit with error if output name is missing" {
	run set_output

	assert_failure
	assert_output "set_output: Output name is required"
}

@test "set_output should not write to GITHUB_OUTPUT if GITHUB_ACTIONS is not set" {
	run set_output "FOO" "bar"
	assert_success
	assert_output ""

	run cat "$GITHUB_OUTPUT"
	assert_success
	assert_output ""
}

@test "set_output should write to GITHUB_OUTPUT if GITHUB_ACTIONS is set" {
	GITHUB_ACTIONS="true"

	run set_output "FOO" "bar"
	assert_success
	assert_output ""
	
	run cat "$GITHUB_OUTPUT"
	assert_success
	assert_output "FOO=bar"
}
