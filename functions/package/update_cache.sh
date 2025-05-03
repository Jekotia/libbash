#! /usr/bin/env bash

#-> 
#-> 
#-> 
function jlb::package::update_cache() {
	jlb::funcStart ; local errcode

	if jlb::package::get_manager ; then
		package::"${JLB_PACKAGE_MANAGER}"::update_cache "$@"
		errcode=$?
	else
		errcode=$?
	fi

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
