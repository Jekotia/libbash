#! /usr/bin/env bash

#-> CHECK WHICH PACKAGE MANAGER IS PRESENT
#-> TAKES NO ARGS
#-> RETURNS 0 IF IT FINDS A SUPPORTED MANAGER, 1 IF IT DOES NOT

# The version of the function file in format "x.y.z".
export JLB_PACKAGE_GET_MANAGER_VERSION=1.0.0

# Public: Determines which package manager to use
#
# Determines which package manager is present on the system.
# Used to inform other package functions which manager-specific functions to use.
#
# No arguments.
#
# Examples
#
#   jlb::package::get_manager
#
# Returns 0 if it finds a supported package manager, 1 if it does not.
function jlb::package::get_manager() {
	jlb::funcStart ; local errcode

	#-> CHECK IF ${JLB_PACKAGE_MANAGER} HAS BEEN PREVIOUSLY SET, TO AVOID UNNECESSARY PROCESSING
	if [[ -z "${JLB_PACKAGE_MANAGER}" ]] ; then
		local	pkgmgr \
				pkgmgr_cmd

		for dir in ${JLB_ROOT}/package/*/ ; do
			pkgmgr=$(basename "${dir}")
			pkgmgr_cmd=$(which "${pkgmgr}" 2>/dev/null)

			if [[ ! -z $pkgmgr_cmd ]] ; then
				errcode=$?

				# Variable containing the name of the package manager detected
				export JLB_PACKAGE_MANAGER=${pkgmgr}
				# Variable containing the path to the package manager detected
				export JLB_PACKAGE_MANAGER_CMD=${pkgmgr_cmd}

				break
			fi
		done

		if [[ -z ${JLB_PACKAGE_MANAGER} ]] || [[ -z ${JLB_PACKAGE_MANAGER_CMD} ]] ; then
			errcode=1

			jlb::printerr "Unable to detect a supported package manager."
		fi

		jlb::debug "JLB_PACKAGE_MANAGER=${JLB_PACKAGE_MANAGER}"
		jlb::debug "JLB_PACKAGE_MANAGER_CMD=${JLB_PACKAGE_MANAGER_CMD}"
	else
		errcode=0
		jlb::debug "\$JLB_PACKAGE_MANAGER ALREADY SET."
	fi

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
