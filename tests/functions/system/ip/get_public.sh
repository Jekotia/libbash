#! /usr/bin/env bash

#shellcheck disable=SC1090
source "$(git rev-parse --show-toplevel)/tests/common.sh"


testFiles+=( "functions/system/ip/get_public.sh" )
# Test jlb::system::ip::get_public
test_system_ip_get_public() {
	jlb::system::ip::get_public "$(jlb::system::ip::get_public)" > /dev/null
	assertEquals "Test jlb::system::ip::get_public" "$?" "0"
}


#shellcheck disable=SC2154
source "$shunit2Path"
