#! /usr/bin/env bash

#shellcheck disable=SC1090
source "$(git rev-parse --show-toplevel)/tests/common.sh"


testFiles+=( "functions/system/sshd/disable_root.sh" )
# Test jlb::system::sshd::disable_root
test_system_sshd_disable_root() {
	jlb::system::sshd::disable_root
	assertEquals "Test jlb::system::sshd::disable_root" "0" "$?"

	grep -e "^PermitRootLogin no" "${JLB_TESTS_TMP}/sshd_config" > /dev/null 2>&1
	assertEquals "Verify that the edit produced the expected result." "0" "$?"

	assertTrue "Test for temporary file creation" "[ -r ${JLB_TESTS_TMP}/restart-ssh ]"
}


#shellcheck disable=SC2154
source "$shunit2Path"
