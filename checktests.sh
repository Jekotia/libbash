#! /usr/bin/env bash

### printf "%s| %-60s\n" "SC" "File"
#failures=0
while read -r file; do
	if [[ "${file}" =~ ^functions ]] ; then
		### printf " %s\n" "${file}"

		if [[ -f "tests/${file}" ]] ; then
			printf "\u2714 |" #check
		else
			printf "\u274c|" #cross
			### echo mkdir -p "tests/$(dirname "${file}")"
			### echo touch "tests/${file}"
		fi
		printf " %s\n" "${file}"
	fi
done < <(git ls-tree -r master --name-only)

#printf "\n\u2714 : Success   \u274c: Failure\n"
#printf "SK: Skipped   MI: Missing\n"
