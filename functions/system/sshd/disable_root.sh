#! /usr/bin/env bash

#-> DISABLES ROOT ACCESS VIA SSH
#-> NO ARGS
#-> 
function jlb::system::sshd::disable_root() {
	jlb::funcStart ; local errcode

	# Make necessary changes for running within test context
	if [[ "${JLB_TESTS}" == "true" ]] ; then
		local target1="${JLB_TESTS_TMP}/sshd_config"
		local target2="${JLB_TESTS_TMP}/restart-ssh"
	else
		local target1="/etc/ssh/sshd_config"
		local target2="/tmp/restart-ssh"
		jlb::is_root "exit"
	fi

	
	# comment out any active PermitRootLogin declarations
	sed -i 's/[^#]PermitRootLogin/\#PermitRootLogin/' ${target1}

	# append 'PermitRootLogin no' to end of sshd_config
	echo "PermitRootLogin no" >> ${target1}

	# Confirm that the declaration is present at the end of the file
	grep -e "^PermitRootLogin no" ${target1} > /dev/null 2>&1
	errcode=$?
	
	if [[ ${errcode} -eq 0 ]] ; then
		touch ${target2}
	fi

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
