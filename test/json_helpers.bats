load "test_helper/bats-support/load"
load "test_helper/bats-assert/load"
load "test_helper/common"
load "$DIR/src/json_helpers.sh"

setup() {
	common_setup
}

teardown() {
	common_teardown
}

@test "is_json should return true for valid JSON" {
	run is_json "{}"

	assert_success
}

@test "is_json should return false for invalid JSON" {
	run is_json "foobar"

	assert_failure
}
