#! /usr/bin/env bash

#shellcheck disable=SC1090
source "$(git rev-parse --show-toplevel)/tests/common.sh"


testFiles+=( "functions/is_root.sh" )
# 
test_is_root() {
	assertEquals "Verify is_root check" "${JLB_ERROR_PREFIX} This script requires root/sudo!" "$(jlb::is_root)"
}


#shellcheck disable=SC2154
source "$shunit2Path"
