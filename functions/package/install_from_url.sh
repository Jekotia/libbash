#! /usr/bin/env bash

#-> 
#-> 
#-> 
function jlb::package::install_from_url() {
	jlb::funcStart ; local errcode

	if jlb::package::get_manager ; then
		package::"${JLB_PACKAGE_MANAGER}"::install_from_url "$@"
		errcode=$?
	else
		errcode=$?
	fi

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
