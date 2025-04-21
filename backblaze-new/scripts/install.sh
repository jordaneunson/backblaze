#!/bin/bash

# backblaze controller
CTL="${BASEURL}index.php?/module/backblaze/"

# Get the scripts in the proper directories
"${CURL[@]}" "${CTL}get_script/backblaze.sh" -o "${MUNKIPATH}preflight.d/backblaze.sh"

# Check exit status of curl
if [ $? = 0 ]; then
	# Make executable
	chmod a+x "${MUNKIPATH}preflight.d/backblaze.sh"

	# Set preference to include this file in the preflight check
	setreportpref "backblaze" "${CACHEPATH}backblaze.txt"

else
	echo "Failed to download all required components!"
	rm -f "${MUNKIPATH}preflight.d/backblaze.sh"

	# Signal that we had an error
	ERR=1
fi
