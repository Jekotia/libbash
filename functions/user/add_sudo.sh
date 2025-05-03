#! /usr/bin/env bash

#-> Installs sudo if needed and creates a user in the sudo group.
#-> $1 - Required - username
#-> $2 - Required - password
function jlb::user::add_sudo {
	jlb::funcStart ; local errcode

	local 	username \
			userpass

	jlb::is_root "exit"

	username="$1" ; shift
	userpass="$1" ; shift

	if [ ! -n "$username" ] || [ ! -n "$userpass" ]; then
		errcode=1

		jlb::printerr "No new username and/or password entered"
	elif jlb::package::install --unattended "sudo" ; then
		if adduser "$username" --disabled-password --gecos "" ; then
			if echo "${username}:{$userpass}" | chpasswd ; then
				if usermod -aG sudo "${username}" ; then
					errcode=0
				else
					errcode=1
					jlb::printerr "FAILED AT USERMOD"
				fi
			else
				errcode=1
				jlb::printerr "FAILED AT CHPASSWD"
			fi
		else
			errcode=1
			jlb::printerr "FAILED AT USERADD"
		fi
	else
		errcode=1
		jlb::printerr "FAILED AT INSTALLING SUDO"
	fi

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
