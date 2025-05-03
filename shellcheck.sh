#! /usr/bin/env bash

path="$(git rev-parse --show-toplevel)"
# VARIABLE CONTAINING STARTING PATH
#looppath="${path}/functions" #-> VARIABLE CONTAINING STARTING PATH

#-> DECLARE THE ARRAY WHICH WILL CONTAIN THE LIST OF FILES TO PASS TO SHELLCHECK
declare -a files
#-> ADD NON *.sh CORE FILES
files+=(${path}/functions/debug)
files+=(${path}/functions/formatting)
files+=(${path}/functions/funcEnd)
files+=(${path}/functions/funcStart)
files+=(${path}/functions/init)
files+=(${path}/functions/loader)
files+=(${path}/functions/printerr)
files+=(${path}/shellcheck.sh)
files+=(${path}/skeleton.sh)
files+=(${path}/tests/common.sh)

function shellcheck_static() {
	local errors=0
	local -a files
	files=( "$@" ) ; shift

	for file in "${files[@]}" ; do
		if shellcheck --color=always --shell=bash --external-sources "${file}" ; then
			printf "\xE2\x9C\x94 %s\n" "${file}"
		else
			((errors++))
		fi
	done

	if [[ ${errors} -gt 0 ]] ; then
		return 1
	else
		return 0
	fi
}

function shellcheck_loop() {
	local	looppath \
			filter_str \
			errors \
			max_depth \
			depth \
			depth_str \
			target \
			loopfiles \
			status

	looppath="${1}" ; shift
	filter_str="${1}" ; shift
	# Setup for the looping side

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
	#	echo "Working at depth ${depth} in directory ${looppath}/${depth_str}"

		#-> LOOP FOR EACH FILE AT THE PATH EXPRESSED BY $SOURCE_PATH
		for f in ${target} ; do
			#-> VERIFY THAT THERE ARE ${filter_str} FILES AT THIS LEVEL TO AVOID ERRORS
			#-> IF THERE ARE, CONTINUE SOURCING. IF NOT, CONTINUE BUT DO NOTHING
			loopfiles=$(shopt -s nullglob dotglob; echo "${target}")
			if (( ${#loopfiles} )) ; then
				# shellcheck disable=1090
				shellcheck --color=always --shell=bash --external-sources "$f"
				status=$?
				if [ ${status} -eq 0 ] ; then
					printf "\xE2\x9C\x94 %s\n" "$f"
				else
					((errors++))
				fi
			else
				echo "empty (or does not exist, or is not a ${filter_str} file)"
			fi
		done

		#-> INCREASE THE DEPTH EXPRESSED
		depth_str="${depth_str}*/"
	done

	if [[ ${errors} -gt 0 ]] ; then
		return 1
	else
		return 0
	fi
}

shellcheck_static "${files[@]}" || ((errors++))
shellcheck_loop "functions" "*.sh" || ((errors++))
shellcheck_loop "tests" "*.sh" || ((errors++))

if [[ ${errors} -gt 0 ]] ; then
	exit 1
else
	exit 0
fi
