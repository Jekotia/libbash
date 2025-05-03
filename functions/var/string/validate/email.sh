#! /usr/bin/env bash

# As of writing, there are no single-character TLD's. However, they would be
# technically valid. So as to avoid the effectiveness of this script relying on
# being updated as new TLD's are approved, no steps are taken to verify that a
# TLD exists; only that the one supplied is valid in regards to the RFC5322 specification.


#-> CHECKS IF THE PROVIDED STRING IS VALID FOR AN EMAIL ADDRESS
#-> TAKES STRING AS ARG
#-> RETURNS 0 FOR VALID OR 1 FOR INVALID
function jlb::var::string::validate::email() {
	jlb::funcStart ; local errcode

	local	emailRegex\
			mail_user \
			rfc5322parts \
			verification_type

	mail_user="$1" ; shift
	verification_type="$1" ; shift

	case $verification_type in
		"RFC5322"|"rfc5322")
			jlb::debug "Using 'RFC5322' for email validation"
			# We define the rfc5322 regex in this manner for readability
			rfc5322parts=(
				# BEGIN LOCAL
				"^[^\.]"
				"(?:"
					"[a-z0-9!#$%&'*+/=?^_\`{|}~-]"
					 "+"
					"(?:"
						"\."
						"[a-z0-9!#$%&'*+/=?^_\`{|}~-]"
						 "+"
					")"
					 "*"
					"|"
					"\""
					"(?:"
						"[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]"
						"|"
						"\\"
						"[\x01-\x09\x0b\x0c\x0e-\x7f]"
					")"
					 "*"
					"\""
				")"
				# END LOCAL
				"@"
				# BEGIN DOMAIN
				"(?:"
					"(?:"
						"[a-z0-9]"
						"(?:"
							"[a-z0-9-]"
							 "*"
							"[a-z0-9]"
						")"
						 "?"
						"\."
					")"
					 "+"
					"[a-z0-9]"
					"(?:"
						"[a-z0-9-]"
						 "*"
						"[a-z0-9]"
					")"
					 "?"
					"|"
					"\["
					"(?:"
						"(?:"
							"25[0-5]"
							"|"
							"2[0-4][0-9]"
							"|"
							"[01]"
							 "?"
							"[0-9][0-9]"
							 "?"
						")"
						"\."
					")"
					 "{3}"
					"(?:"
						"25[0-5]"
						"|"
						"2[0-4][0-9]"
						"|"
						"[01]"
						 "?"
						"[0-9][0-9]"
						 "?"
						"|"
						"[a-z0-9-]"
						 "*"
						"[a-z0-9]"
						":"
						"(?:"
							"[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]"
							"|"
							"\\"
							"[\x01-\x09\x0b\x0c\x0e-\x7f]"
						")+"
					")"
					"\]"
				")"
				# END DOMAIN
			)

			# join the parts
			emailRegex=$( IFS='' ; echo "${rfc5322parts[*]}" )
		;;
		"simple")
			local emailRegex='^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$'
		;;
		*)
			jlb::printerr "No verification_type provided."
			return 1
		;;
	esac

	if echo "${mail_user}" | grep -P "${emailRegex}" ; then
		errcode=0

		jlb::debug "Email address ${mail_user} is valid."
	else
		errcode=1

		jlb::printerr "Email address $mail_user is invalid."
	fi

	jlb::funcEnd "${errcode}" ; return ${errcode}

}
