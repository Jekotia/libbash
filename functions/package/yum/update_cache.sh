#! /usr/bin/env bash

#-> 
#-> 
#-> 
function jlb::package::yum::update_cache() {
	jlb::funcStart ; local errcode

	jlb::debug "Skipping package_yum_updateCache because cache updates are implied by relevant commands"
	errcode=0

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
