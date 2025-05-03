#! /usr/bin/env bash

# Public: Silently run all tests.
#
# Executes all files found under tests/functions/, suppressing output and instead
# indicating success or failure.
#
# Examples
#
#   tests/all.sh
#
# Returns a 0 if all tests pass, and a 1 if a test fails.

function tests_all() {
	# VARIABLE CONTAINING STARTING PATH
	#gitRoot="$(git rev-parse --show-toplevel)"

	#-> DECLARE THE ARRAY WHICH WILL CONTAIN THE LIST OF FILES TO IGNORE
	declare -a ignore

	#-> ADD NON *.sh CORE FILES
	ignore+=(tests/functions/template.sh)
	#filter_str="*.sh"
	filter_str="*"

	declare	looppath \
			errors \
			max_depth \
			depth \
			depth_str \
			target \
			loopfiles

	# Setup for the looping side
	looppath="tests/functions"

	# Track the number of failures
	errors=0
	# VARIABLE CONTAINING MAXIMUM DEPTH
	max_depth=

	# VARIABLE FOR TRACKING CURRENT DEPTH
	depth=0

	# VARIABLE FOR BUILDING DEPTH-BASED PATH TO SOURCE FROM
	depth_str=""

	# DETERMINE MAXIMUM DEPTH OF $path DIRECTORY TREE
	max_depth=$(find "${looppath}" \( ! -regex '.*/\..*' \) -type d -printf '%d\n' | sort -rn | head -1)
	# INCREMENT MAX DEPTH BY ONE, SINCE IT COMES UP SHORT FOR OUR PURPOSES
	((max_depth++))

	#-> EXECUTION
	#-> WHILE CURRENT DEPTH IS BELOW MAX DEPTH, DO STUFF
	while [[ ${depth} -lt "${max_depth}" ]] ; do
		((depth++))
		#####target="${looppath}/${depth_str}*.sh"
		target="${looppath}/${depth_str}${filter_str}"
		#echo "Working at depth ${depth} in directory ${looppath}/${depth_str}"

		#-> LOOP FOR EACH FILE AT THE PATH EXPRESSED BY $SOURCE_PATH
		for f in ${target} ; do
			#-> VERIFY THAT THERE ARE ${filter_str} FILES AT THIS LEVEL TO AVOID ERRORS
			#-> IF THERE ARE, CONTINUE SOURCING. IF NOT, CONTINUE BUT DO NOTHING
			loopfiles=$(shopt -s nullglob dotglob; echo "${target}")
			if (( ${#loopfiles} )) ; then
				#echo $loopfiles
				if [[ -f "${f}" ]] && [[ ! "${ignore[@]}" =~ ${f} ]] ; then
					# shellcheck disable=1090
					if $f > /dev/null 2>&1 ; then
					#status=$?
					#if [ ${status} -eq 0 ] ; then
						printf "\u2714 %s\n" "${f}"
						#printf "\xE2\x9C\x94 %s\n" "$f"
					else
						printf "\u274c %s\n" "${f}"
						#printf "\xE2\x9C\x94 %s\n" "$f"
						((errors++))
					fi
				fi
			else
				echo "empty (or does not exist, or is not a ${filter_str} file)"
			fi
		done

		#-> INCREASE THE DEPTH EXPRESSED
		depth_str="${depth_str}*/"
	done

	if [[ ${errors} -gt 0 ]] ; then
		exit 1
	else
		exit 0
	fi
}
tests_all "${@}"
