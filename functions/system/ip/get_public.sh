#! /usr/bin/env bash

#-> 
#-> 
#-> 
function jlb::system::ip::get_public() {
	jlb::funcStart ; local errcode

	# returns the primary IP assigned to eth0
	#echo $(ifconfig eth0 | awk -F: '/inet addr:/ {print $2}' | awk '{ print $1 }')
	#curl ipv4.icanhazip.com
	dig @resolver1.opendns.com ANY myip.opendns.com +short -4
	errcode=$?

	jlb::funcEnd "${errcode}" ; return ${errcode}
}
