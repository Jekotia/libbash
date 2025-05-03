#! /usr/bin/env bash

#-> 
#-> 
#-> 
function jlb::package::yum::update() {
	jlb::funcStart ; local errcode

	local	args \
			packages

	#-> CHECK IF ARGUMENTS FOR THE PACKAGE MANAGER HAVE
	#-> BEEN PASSED, AND SET THEIR YUM EQUIVALENTS IF SO.
	while :; do
		case $1 in
			--unattended)
				args="${args} -y"
				jlb::debug "Package manager is now unattended"
			;;
			--verbose)
				args="${args} --verbose"
				jlb::debug "Package manager is now verbose"
			;;
			--*)
				jlb::printerr "Invalid argument ($1) provided."
				errcode=1
				jlb::funcEnd "${errcode}" ; return ${errcode}
			;;
			*)
				break
			;;
		esac
		shift
	done

	packages="${*}"
	jlb::debug "packages=${packages}"

	${JLB_PACKAGE_MANAGER_CMD} install "${args}" "${packages}"
	errcode=$?

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
