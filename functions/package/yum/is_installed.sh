#! /usr/bin/env bash

#-> CHECKS IF THE NAMED PACKAGE IS INSTALLED
#-> TAKES PACKAGE NAME (STRING) AS INPUT
#-> RETURNS EXIT CODE OF YUM
function jlb::package::yum::is_installed() {
	jlb::funcStart ; local errcode

	${JLB_PACKAGE_MANAGER_CMD} list installed "$@" >/dev/null 2>&1
	errcode=$?

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
