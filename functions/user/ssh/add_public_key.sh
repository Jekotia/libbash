#! /usr/bin/env bash

#-> Adds the users public key to authorized_keys for the specified user. Make sure you wrap your input variables in double quotes, or the key may not load properly.
#-> $1 - Required - USER
#-> $2 - Required - public key
function jlb::user::ssh::add_public_key() {
	jlb::funcStart ; local errcode

	local	user \
			key_path \
			home_path

	user="$1" ; shift
	key_path="$1" ; shift

	if [ -z "${user}" ] || [ -z "${key_path}" ]; then
		errcode=1

		jlb::printerr "Must provide a username and the location of a pubkey"

		jlb::funcEnd "${errcode}"	; return ${errcode}
	elif [ ! -f "${key_path}" ] ; then
		errcode=1

		jlb::printerr "Provided public key file path does not exist."

		jlb::funcEnd "${errcode}"	; return ${errcode}
	fi

	if [[ "${JLB_TESTS}" == "true" ]] ; then
		home_path="${JLB_TESTS_TMP}/home"
		user=${USER}
	elif [ "$user" == "root" ]; then
		home_path=/root
	else
		home_path=/home/${user}
	fi

	if mkdir -p "${home_path}"/.ssh ; then
		if touch "${home_path}"/.ssh/authorized_keys ; then
			if cat "${key_path}" >> "${home_path}"/.ssh/authorized_keys ; then
				if chown -R "$user":"$user" "${home_path}"/.ssh ; then
					if grep "$(cat "${key_path}")" "${home_path}/.ssh/authorized_keys" > /dev/null ; then
						errcode=$?
					else
						errcode=$?
					fi
				else
					errcode=$?
				fi
			else
				errcode=$?
			fi
		else
			errcode=$?
		fi
	else
		errcode=$?
	fi

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
