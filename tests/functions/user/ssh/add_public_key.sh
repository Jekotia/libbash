#! /usr/bin/env bash

#shellcheck disable=SC1090
source "$(git rev-parse --show-toplevel)/tests/common.sh"

testFiles+=( "functions/user/ssh/add_public_key.sh" )
test_user_ssh_add_public_key() {
	jlb::user::ssh::add_public_key "test" "${JLB_TESTS_TMP}/id_testkey.pub"
	assertEquals "Test jlb::user::ssh::add_public_key." "0" "$?"

	grep "$(cat "${JLB_TESTS_TMP}/id_testkey.pub")" "${JLB_TESTS_TMP}/home/.ssh/authorized_keys" > /dev/null
	assertEquals "Test jlb::user::ssh::add_public_key." "0" "$?"
}

#shellcheck disable=SC2154
source "$shunit2Path"
