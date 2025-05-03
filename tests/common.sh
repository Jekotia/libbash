#! /usr/bin/env bash

#shellcheck disable=SC2034
JLB_TEST="true"

gitRoot="$(git rev-parse --show-toplevel)"
#shellcheck disable=SC2034
shunit2Path="${gitRoot}/shunit2/shunit2"
testsRoot="${gitRoot}/tests"

#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
declare -a testFiles

# Initialise the test environment
oneTimeSetUp() {
	export JLB_TESTS=true
	export JLB_TESTS_DIR="${testsRoot}"
	export JLB_TESTS_TMP="${JLB_TESTS_DIR}/tmp"
	export JLB_TESTS_FILES="${JLB_TESTS_DIR}/files"
	# shellcheck disable=SC2046
	#JLB_ROOT="$(dirname $( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd ))/functions"
	JLB_ROOT="$(git rev-parse --show-toplevel 2> /dev/null)/functions"

	# shellcheck disable=SC1090
	source "$JLB_ROOT/init" "$@" || exit 1

	mkdir -p "${JLB_TESTS_TMP}"
	cp -ar "${JLB_TESTS_FILES}/"* "${JLB_TESTS_TMP}"

	echo
	echo "Testing files:"
	for file in "${testFiles[@]}" ; do
		echo "$file"
	done
	echo

	jlb::init "${JLB_ROOT}"
}

oneTimeTearDown() {
	echo #rm -rf "${JLB_TESTS_TMP}"
}

# Unset variables between tests
#tearDown() {
#	unset JLB_DEBUG
#	unset JLB_DEBUG_DEPTH
#	unset JLB_TEST
#}
