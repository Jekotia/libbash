#! /usr/bin/env bash

# The version of the function file in format "x.y.z".
export JLB_ISROOT_VERSION=1.0.0

# Public: Checks if the current user has su
#
# Checks if the user in the current running environment has superuser rights
#
# $1 - OPTIONAL: what should be done if the user does not have su. Can be "exit" or blank.
#
# Examples
#
#   jlb::isRoot
#   jlb::isRoot "exit"
#
# Returns 0 if user has su, 1 otherwise.
function jlb::is_root() {
	jlb::funcStart ; local errcode

	if [[ $(id -u) == "0" ]] ; then
		errcode=$?
	else
		jlb::printerr "This script requires root/sudo!"
		if [[ "$1" == "exit" ]] ; then
			exit 1
		else
			errcode=1
		fi
	fi

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
