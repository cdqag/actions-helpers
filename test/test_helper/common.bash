DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." >/dev/null 2>&1 && pwd)"
PATH="$DIR/../src:$PATH"

workdir=/tmp/not-yet-set

ORIGINAL_RUNNER_DEBUG="$RUNNER_DEBUG"
ORIGINAL_GITHUB_ACTIONS="$GITHUB_ACTIONS"
ORIGINAL_GITHUB_ENV="$GITHUB_ENV"
ORIGINAL_GITHUB_OUTPUT="$GITHUB_OUTPUT"

function common_setup() {
	# Prepare a work directory
	workdir=$(mktemp -d)

	# Copy fixtures
	cp -r test/fixtures/. "$workdir"

	RUNNER_DEBUG=""
	GITHUB_ACTIONS=""
	GITHUB_ENV=$(mktemp)
	GITHUB_OUTPUT=$(mktemp)
}

function common_teardown() {
	rm -rf "$workdir"

	rm -f "$GITHUB_ENV"
	rm -f "$GITHUB_OUTPUT"

	RUNNER_DEBUG="$ORIGINAL_RUNNER_DEBUG"
	GITHUB_ACTIONS="$ORIGINAL_GITHUB_ACTIONS"
	GITHUB_ENV="$ORIGINAL_GITHUB_ENV"
	GITHUB_OUTPUT="$ORIGINAL_GITHUB_OUTPUT"
}
