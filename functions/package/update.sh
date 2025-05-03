#! /usr/bin/env bash

#-> 
#-> 
#-> 
function jlb::package::update() {
	jlb::funcStart ; local errcode

	if jlb::package::get_manager ; then
		package::"${JLB_PACKAGE_MANAGER}"::update "$@"
		errcode=$?
	else
		errcode=$?
	fi

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
