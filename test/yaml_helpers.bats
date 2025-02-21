load "test_helper/bats-support/load"
load "test_helper/bats-assert/load"
load "test_helper/common"
load "$DIR/src/log_helpers.sh"
load "$DIR/src/yaml_helpers.sh"

setup() {
	common_setup
}

teardown() {
	common_teardown
}

@test "should fail if yaml file path is not provided" {
	run get_value_from_yaml

	assert_failure 21
	assert_output "[ERROR] Invalid input: Yaml file path cannot be an empty string"
}

@test "should fail if yaml file does not exist" {
	run get_value_from_yaml "/not/existing/path"

	assert_failure 22
	assert_output "[ERROR] File not found: File /not/existing/path does not exist"
}

@test "should fail if key is not provided" {
	run get_value_from_yaml "$workdir/example_dir/example_sub_dir/Chart.yaml"

	assert_failure 23
	assert_output "[ERROR] Invalid input: key cannot be an empty string"
}

@test "should fail if key is an empty string" {
	run get_value_from_yaml "$workdir/example_dir/example_sub_dir/Chart.yaml" ""

	assert_failure 23
	assert_output "[ERROR] Invalid input: key cannot be an empty string"
}

@test "should return flat value from yaml file" {
	run get_value_from_yaml "$workdir/example_dir/example_sub_dir/Chart.yaml" '.name' "ignored"

	assert_success
	assert_output "withoutmodule-api"
}

@test "should return nested value from yaml file" {
	run get_value_from_yaml "$workdir/example_dir/example_sub_dir/Chart.yaml" '.annotations."example.com/argocd.app.name"' ignored

	assert_success
	assert_output "customname-api"
}

@test "should return value default from file if key does not exist" {
	run get_value_from_yaml "$workdir/example_dir/example_sub_dir/Chart.yaml" ".example.com/argocd.app.name" "foobar"

	assert_success
	assert_output "foobar"
}
