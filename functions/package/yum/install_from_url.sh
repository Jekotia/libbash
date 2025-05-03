#! /usr/bin/env bash

#-> INSTALLS RPM FROM URL
#-> TAKES URL AS ARG
#-> RETURNS 0 FOR SUCCESS OR 1 FOR FAILURE
function jlb::package::yum:install_from_url() {
	jlb::funcStart ; local errcode

	local url

	jlb::is_root "exit"

	url="${*}"

	rpm -Uvh "${url}"
	errcode=$?

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
