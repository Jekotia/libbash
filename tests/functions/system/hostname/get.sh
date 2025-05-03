#! /usr/bin/env bash

#shellcheck disable=SC1090
source "$(git rev-parse --show-toplevel)/tests/common.sh"


testFiles+=( "functions/system/hostname/get.sh" )
# Test jlb::system::hostname::get
test_system_hostname_get() {
	assertEquals "Test jlb::system::hostname::get." "$(hostname -s)" "$(jlb::system::hostname::get)"
}


#shellcheck disable=SC2154
source "$shunit2Path"
