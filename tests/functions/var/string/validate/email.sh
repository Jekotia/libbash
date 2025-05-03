#! /usr/bin/env bash

#shellcheck disable=SC1090
source "$(git rev-parse --show-toplevel)/tests/common.sh"

testFiles+=( "functions/var/string/validate/email.sh" )
# Test jlb::var::string::validate::email
test_jlb_var_string_validate_email-validEmails() {
	while read -r email; do
		if [[ "${email}" =~ ^[^#].+ ]] ; then
			jlb::var::string::validate::email "$email" "RFC5322" > /dev/null
			assertEquals "Test jlb::var::string::validate::email with address $email." "0" "$?"
		fi
	done <"${JLB_TESTS_TMP}/valid_emails.txt"
}
test_jlb_var_string_validate_email-invalidEmails() {
	while read -r email; do
		if [[ "${email}" =~ ^[^#].+ ]] ; then
			jlb::var::string::validate::email "$email" "RFC5322" 2> /dev/null
			assertEquals "Test jlb::var::string::validate::email with address $email." "1" "$?"
		fi
	done <"${JLB_TESTS_TMP}/invalid_emails.txt"
}

#shellcheck disable=SC2154
source "$shunit2Path"
