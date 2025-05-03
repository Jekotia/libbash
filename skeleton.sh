#! /usr/bin/env bash

# The version of the function file in format "x.y.z".
export JLB_SKELETON_VERSION=1.0.0

# Public: BRIEF summary of function
#
# May or may not make a skeleton rattle
#
# $1 - Argument 1.
# $2 - Argument 2. etc
#
# Examples
#
#   jlb::skeleton "rattle"
#   jlb::skeleton "silent"
#   jlb::skeleton "random"
#
# Returns 1 if the skeleton remained silent, 0 if it rattled.
function jlb::skeleton() {
	jlb::funcStart ; local errcode=

	### FUNCTION CODE HERE ###

	jlb::funcEnd "${errcode}" ; return $errcode
}
