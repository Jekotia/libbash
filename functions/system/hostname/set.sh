#! /usr/bin/env bash

#-> 
#-> 
#-> 
function jlb::system::hostname::set() {
	jlb::funcStart ; local errcode

	local hostname

	jlb::is_root "exit"

	hostname="$1"

	if [ ! -n "$hostname" ]; then
		echo "Hostname undefined"
		errcode=1
		jlb::funcEnd "${errcode}" ; return ${errcode}
	fi

	if echo "$hostname" > /etc/hostname ; then
		if ! hostname -F /etc/hostname ; then
			errcode=$?
		fi
	else
		errcode=$?
	fi

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
