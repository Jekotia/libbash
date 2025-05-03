#! /usr/bin/env bash

##################################################
### REPLACE ALL INSTANCES OF THE WORD SKELETON ###
##################################################

#shellcheck disable=SC1090
source "$(git rev-parse --show-toplevel)/tests/common.sh"


testFiles+=( "functions/skeleton" )
# Test initialisation system
test_skeleton() {
	jlb::skeleton "${JLB_ROOT}"
	assertEquals $? 0
}


#shellcheck disable=SC1090
#shellcheck disable=SC2154
source "$shunit2Path"
