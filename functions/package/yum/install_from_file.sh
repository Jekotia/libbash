#! /usr/bin/env bash

#-> INSTALLS RPM FROM FILE
#-> TAKES FILE PATH AS ARG
#-> RETURNS 0 FOR SUCCESS OR 1 FOR FAILURE
function jlb::package::yum::install_from_file {
	jlb::funcStart ; local errcode

	local file

	jlb::is_root "exit"

	file="${*}"

	rpm -vhi "${file}"
	errcode=$?

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
