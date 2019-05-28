#! /bin/bash

#-> 
#-> 
#-> 
function package_yum_update() {
	funcStart

	#-> CHECK IF ARGUMENTS FOR THE PACKAGE MANAGER HAVE
	#-> BEEN PASSED, AND SET THEIR YUM EQUIVALENTS IF SO.
	while :; do
		case $1 in
			--unattended)
				args="${args} -y"
				debug "Package manager is now unattended"
			;;
			--verbose)
				args="${args} --verbose"
				debug "Package manager is now verbose"
			;;
			--*)
				errcho "Invalid argument ($1) provided."
				return 1
			;;
			*)
				break
			;;
		esac
		shift
	done

	packages="${@}"
	debug "packages=${packages}"

	${YUM_CMD} install "${args}" "${packages}"
	errcode=$?

	funcEnd "$errcode"
	return $errcode
}