#! /usr/bin/env bash

#-> 
#-> 
#-> 
function jlb::system::hostname::get() {
	jlb::funcStart ; local errcode

	local hostname

	hostname=$(hostname)
	errcode=$?

	echo "${hostname}"

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
