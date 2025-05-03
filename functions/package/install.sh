#! /usr/bin/env bash

#-> SKELETON FOR PACKAGE INSTALLATION. CALLS FUNCTION TO DISCOVER PACKAGE MANAGER AND THEN CALLS THE INSTALL FUNCTION FOR THAT MANAGER.
#-> TAKES THE FOLLOWING OPTIONAL ARGS AS INPUT, WHICH WILL BE CONVERTED INTO THE APPROPRIATE ARGS FOR THE LOCAL PACKAGE MANAGER
#->  --unattended
#->  --verbose
#-> TAKES A LIST OF PACKAGES AS THE FINAL ARGUMENT
#-> RETURNS THE EXIT STATUS OF THE package_${JLB_PACKAGE_MANAGER}_install FUNCTION, OR 1 IF IT FAILS TO FIND A SUPPORTED PACKAGE MANAGER.
function jlb::package::install() {
	jlb::funcStart ; local errcode

	if jlb::package::get_manager ; then
		package::"${JLB_PACKAGE_MANAGER}"::install "$@"
		errcode=$?
	else
		errcode=$?
	fi

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
