#! /usr/bin/env bash

#shellcheck disable=SC1090
source "$(git rev-parse --show-toplevel)/tests/common.sh"

## Disabled until a safe way to test this is determined
testFiles+=( "functions/user/add_sudo.sh" )
# Test jlb::user::add_sudo
#test_user_add_sudo() {
#	jlb::user::add_sudo
#	assertEquals "Test jlb::user::add_sudo." "-1" "$?"
#}

#shellcheck disable=SC2154
source "$shunit2Path"
