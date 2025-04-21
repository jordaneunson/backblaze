#!/bin/sh

# Script to collect data
# and put the data into outputfile

CWD=$(dirname $0)
CACHEDIR="$CWD/cache/"
OUTPUT_FILE="${CACHEDIR}backblaze.txt"
SEPARATOR=' = '

# Business logic goes here
# Replace 'echo' in the following lines with the data collection commands for your module.
FDA_PERMISSIONS_ISSUE=$(echo)
BZVERSION=$(echo)
BZLOGIN=$(echo)
BZLICENSE=$(echo)
BZLICENSE_STATUS=$(echo)
SAFETY_FROZEN=$(echo)
LASTBACKUPCOMPLETED=$(echo)
REMAININGNUMFILESFORBACKUP=$(echo)
REMAININGNUMBYTESFORBACKUP=$(echo)
TOTNUMFILESFORBACKUP=$(echo)
TOTNUMBYTESFORBACKUP=$(echo)
ENCRYPTED=$(echo)
ONLINE_HOSTNAME=$(echo)
BZTEMPFILE_SIZE=$(echo)

# Output data here
echo "fda_permissions_issue${SEPARATOR}${FDA_PERMISSIONS_ISSUE}" > ${OUTPUT_FILE}
echo "bzversion${SEPARATOR}${BZVERSION}" >> ${OUTPUT_FILE}
echo "bzlogin${SEPARATOR}${BZLOGIN}" >> ${OUTPUT_FILE}
echo "bzlicense${SEPARATOR}${BZLICENSE}" >> ${OUTPUT_FILE}
echo "bzlicense_status${SEPARATOR}${BZLICENSE_STATUS}" >> ${OUTPUT_FILE}
echo "safety_frozen${SEPARATOR}${SAFETY_FROZEN}" >> ${OUTPUT_FILE}
echo "lastbackupcompleted${SEPARATOR}${LASTBACKUPCOMPLETED}" >> ${OUTPUT_FILE}
echo "remainingnumfilesforbackup${SEPARATOR}${REMAININGNUMFILESFORBACKUP}" >> ${OUTPUT_FILE}
echo "remainingnumbytesforbackup${SEPARATOR}${REMAININGNUMBYTESFORBACKUP}" >> ${OUTPUT_FILE}
echo "totnumfilesforbackup${SEPARATOR}${TOTNUMFILESFORBACKUP}" >> ${OUTPUT_FILE}
echo "totnumbytesforbackup${SEPARATOR}${TOTNUMBYTESFORBACKUP}" >> ${OUTPUT_FILE}
echo "encrypted${SEPARATOR}${ENCRYPTED}" >> ${OUTPUT_FILE}
echo "online_hostname${SEPARATOR}${ONLINE_HOSTNAME}" >> ${OUTPUT_FILE}
echo "bztempfile_size${SEPARATOR}${BZTEMPFILE_SIZE}" >> ${OUTPUT_FILE}
