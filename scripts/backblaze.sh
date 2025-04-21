#!/bin/sh

# Script to collect data
# and put the data into outputfile

CWD=$(dirname $0)
CACHEDIR="$CWD/cache/"
OUTPUT_FILE="${CACHEDIR}backblaze.txt"
SEPARATOR=' = '

# Business logic goes here
bzpath="/Library/Backblaze.bzpkg/bzdata/bzreports"
bzversion=`cat "$bzpath"/bzserv_version.txt 2>/dev/null` || exit 0
bzlogin=$(grep -o 'bzlogin="[^"]*"' "$bzpath"/bzdc_synchostinfo.xml | sed 's/bzlogin="//;s/"//')
bzlicense=$(grep -o 'bzlicense="[^"]*"' "$bzpath"/bzdc_synchostinfo.xml | sed 's/bzlicense="//;s/"//')
bzlicense_status=$(grep -o 'bzlicense_status="[^"]*"' "$bzpath"/bzdc_synchostinfo.xml | sed 's/bzlicense_status="//;s/"//')
safety_frozen=$(grep -o 'safety_frozen="[^"]*"' "$bzpath"/bzdc_synchostinfo.xml | sed 's/safety_frozen="//;s/"//')
lastbackupcompleted=$(grep -o 'gmt_millis="[^"]*"' "$bzpath"/bzstat_lastbackupcompleted.xml | sed 's/gmt_millis="//;s/"//')
remainingnumfilesforbackup=$(grep -o 'remainingnumfilesforbackup="[^"]*"' "$bzpath"/bzstat_remainingbackup.xml | sed 's/remainingnumfilesforbackup="//;s/"//')
remainingnumbytesforbackup=$(grep -o 'remainingnumbytesforbackup="[^"]*"' "$bzpath"/bzstat_remainingbackup.xml | sed 's/remainingnumbytesforbackup="//;s/"//')
totnumfilesforbackup=$(grep -o 'totnumfilesforbackup="[^"]*"' "$bzpath"/bzstat_totalbackup.xml | sed 's/totnumfilesforbackup="//;s/"//')
totnumbytesforbackup=$(grep -o 'totnumbytesforbackup="[^"]*"' "$bzpath"/bzstat_totalbackup.xml | sed 's/totnumbytesforbackup="//;s/"//')
encrypted=`cat "$bzpath"/bzflag_user_has_priv_encr_key.txt`
online_hostname=$(grep -o 'online_hostname="[^"]*"' "/Library/Backblaze.bzpkg/bzdata/bzinfo.xml" | sed 's/online_hostname="//;s/"//')
bztempfile=`du -hd0 --si /Library/Backblaze.bzpkg`
bztempfile_size=$(echo "$bztempfile" | cut -d$'\t' -f1)
bzmenu_log="/Library/Backblaze.bzpkg/bzdata/bzlogs/bzbmenu/bzbmenu20.log"

permissions_issue="1"

# Parse for permissions issue
if [[ -f "$bzmenu_log" ]]; then
	if grep -q "WARNING: Permissions Issue" "$BZMENU_LOG"; then
		permissions_issue="0"
	fi
fi

if [[ "${safety_frozen}" == "not_frozen" ]]; then
    safety_frozen_boolean=0
else
    safety_frozen_boolean=1
fi

if [[ "${encrypted}" == "true" ]]; then
    encrypted_boolean=1
else
    encrypted_boolean=0
fi

lastbackupcompleted=`expr $lastbackupcompleted / 1000`

bzlicense_status="${bzlicense_status#billing_}"
bzlicense="${bzlicense%_billing}"
FDA_PERMISSIONS_ISSUE="$permissions_issue"

# Output data here
echo "bzversion${SEPARATOR}${bzversion}" > ${OUTPUT_FILE}
echo "bzlogin${SEPARATOR}${bzlogin}" >> ${OUTPUT_FILE}
echo "bzlicense${SEPARATOR}${bzlicense}" >> ${OUTPUT_FILE}
echo "bzlicense_status${SEPARATOR}${bzlicense_status}" >> ${OUTPUT_FILE}
echo "safety_frozen${SEPARATOR}${safety_frozen_boolean}" >> ${OUTPUT_FILE}
echo "lastbackupcompleted${SEPARATOR}${lastbackupcompleted}" >> ${OUTPUT_FILE}
echo "remainingnumfilesforbackup${SEPARATOR}${remainingnumfilesforbackup}" >> ${OUTPUT_FILE}
echo "remainingnumbytesforbackup${SEPARATOR}${remainingnumbytesforbackup}" >> ${OUTPUT_FILE}
echo "totnumbytesforbackup${SEPARATOR}${totnumbytesforbackup}" >> ${OUTPUT_FILE}
echo "totnumfilesforbackup${SEPARATOR}${totnumfilesforbackup}" >> ${OUTPUT_FILE}
echo "encrypted${SEPARATOR}${encrypted_boolean}" >> ${OUTPUT_FILE}
echo "online_hostname${SEPARATOR}${online_hostname}" >> ${OUTPUT_FILE}
echo "bztempfile_size${SEPARATOR}${bztempfile_size}" >> ${OUTPUT_FILE}
echo "fda_permissions_issue${SEPARATOR}${FDA_PERMISSIONS_ISSUE}" > ${OUTPUT_FILE}

