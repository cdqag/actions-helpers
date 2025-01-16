load "test_helper/bats-support/load"
load "test_helper/bats-assert/load"
load "test_helper/common"
load "$DIR/src/log_helpers.sh"

setup() {
	common_setup
}

teardown() {
	common_teardown
}

@test "log_error should print error with title" {
	run log_error "Foo" "Bar"

	assert_success
	assert_output "[ERROR] Foo: Bar"
}

@test "log_error should print error without title" {
	run log_error "Foo"

	assert_success
	assert_output "[ERROR] Foo"
}

@test "log_error should print GHA error command with title" {
	GITHUB_ACTIONS="true"

	run log_error "Foo" "Bar"

	assert_success
	assert_output "::error title=Foo::Bar"
}

@test "log_error should print GHA error command without title" {
	GITHUB_ACTIONS="true"

	run log_error "Foo"

	assert_success
	assert_output "::error::Foo"
}

@test "log_warning should print warning with title" {
	run log_warning "Foo" "Bar"

	assert_success
	assert_output "[WARNING] Foo: Bar"
}

@test "log_warning should print warning without title" {
	run log_warning "Foo"

	assert_success
	assert_output "[WARNING] Foo"
}

@test "log_warning should print GHA warning command with title" {
	GITHUB_ACTIONS="true"

	run log_warning "Foo" "Bar"

	assert_success
	assert_output "::warning title=Foo::Bar"
}

@test "log_warning should print GHA warning command without title" {
	GITHUB_ACTIONS="true"

	run log_warning "Foo"

	assert_success
	assert_output "::warning::Foo"
}

@test "log_notice should print notice with title" {
	run log_notice "Foo" "Bar"

	assert_success
	assert_output "[NOTICE] Foo: Bar"
}

@test "log_notice should print notice without title" {
	run log_notice "Foo"

	assert_success
	assert_output "[NOTICE] Foo"
}

@test "log_notice should print GHA notice command with title" {
	GITHUB_ACTIONS="true"
	
	run log_notice "Foo" "Bar"

	assert_success
	assert_output "::notice title=Foo::Bar"
}

@test "log_notice should print GHA notice command without title" {
	GITHUB_ACTIONS="true"
	
	run log_notice "Foo"

	assert_success
	assert_output "::notice::Foo"
}

@test "log_info should print info" {
	run log_info "Foo"

	assert_success
	assert_output "[INFO] Foo"
}

@test "log_info should print GHA log message" {
	GITHUB_ACTIONS="true"
	
	run log_info "Foo"

	assert_success
	assert_output "Foo"
}

@test "log_debug should not print anything if RUNNER_DEBUG is not set" {
	run log_debug "Foobar"

	assert_success
	assert_output ""
}

@test "log_debug should print debug message if RUNNER_DEBUG is set" {
	RUNNER_DEBUG="1"
	
	run log_debug "Foobar"

	assert_success
	assert_output "[DEBUG] Foobar"
}

@test "log_debug should print GHA command debug if RUNNER_DEBUG and GITHUB_ACTIONS is set" {
	RUNNER_DEBUG="1"
	GITHUB_ACTIONS="true"

	run log_debug "Foobar"

	assert_success
	assert_output "::debug::Foobar"
}

@test "group_start should not print anything if GITHUB_ACTIONS is not set" {
	run group_start "Foo"

	assert_success
	assert_output ""
}

@test "group_start should exit with error if group name is not provided" {
	run group_start

	assert_failure
	assert_output "group_start: Group name cannot be empty"
}

@test "group_start should print GHA command group" {
	GITHUB_ACTIONS="true"

	run group_start "Foo"

	assert_success
	assert_output "::group::Foo"
}

@test "group_end should not print anything if GITHUB_ACTIONS is not set" {
	run group_end

	assert_success
	assert_output ""
}

@test "group_end should print GHA command endgroup" {
	GITHUB_ACTIONS="true"

	run group_end

	assert_output "::endgroup::"
}

@test "mask should exit with error if mask is not provided" {
	run mask

	assert_failure
	assert_output "mask: Value to mask cannot be empty"
}

@test "mask should not print anything if GITHUB_ACTIONS is not set" {
	run mask "Foo"

	assert_success
	assert_output ""
}

@test "mask should print GHA command add-mask" {
	GITHUB_ACTIONS="true"

	run mask "Foo"

	assert_success
	assert_output "::add-mask::Foo"
}
