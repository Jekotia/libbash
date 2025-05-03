#! /usr/bin/env bash

#-> SKELETON TO CHECK IF A PACKAGE IS INSTALLED
#-> TAKES PACKAGE NAME AS ARG
#-> RETURNS 0 FOR AN INSTALLED PACKAGE OR 1 FOR A NON-INSTALLED PACKAGE
function jlb::package::is_installed() {
	jlb::funcStart ; local errcode

	if jlb::package::get_manager ; then
		package::"${JLB_PACKAGE_MANAGER}"::is_installed "$@"
		errcode=$?
	else
		errcode=$?
	fi

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
