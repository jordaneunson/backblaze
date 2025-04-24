#!/bin/sh

# === Setup ===
CWD=$(dirname "$0")
CACHEDIR="$CWD/cache/"
OUTPUT_FILE="${CACHEDIR}backblaze.txt"
SEPARATOR=' = '
bzpath="/Library/Backblaze.bzpkg/bzdata/bzreports"

# === Core Data ===
bzversion=$(cat "$bzpath"/bzserv_version.txt 2>/dev/null) || exit 0
bzlogin=$(grep -o 'bzlogin="[^"]*"' "$bzpath"/bzdc_synchostinfo.xml | sed 's/bzlogin="//;s/"//')
bzlicense=$(grep -o 'bzlicense="[^"]*"' "$bzpath"/bzdc_synchostinfo.xml | sed 's/bzlicense="//;s/"//')
bzlicense_status=$(grep -o 'bzlicense_status="[^"]*"' "$bzpath"/bzdc_synchostinfo.xml | sed 's/bzlicense_status="//;s/"//')
safety_frozen=$(grep -o 'safety_frozen="[^"]*"' "$bzpath"/bzdc_synchostinfo.xml | sed 's/safety_frozen="//;s/"//')

# === Backup Timestamps ===
LAST_SUCCESS_FILE="$bzpath/bzstat_lastbackupcompleted.xml"
lastbackupcompleted="unknown"
age_days="unknown"

if [[ -f "$LAST_SUCCESS_FILE" ]]; then
    millis=$(sed -n 's/.*gmt_millis="\([0-9]*\)".*/\1/p' "$LAST_SUCCESS_FILE")
    if [[ "$millis" =~ ^[0-9]+$ ]]; then
        last_epoch=$((millis / 1000))
        now_epoch=$(date +%s)
        age_days=$(( (now_epoch - last_epoch) / 86400 ))
        lastbackupcompleted=$(date -r "$last_epoch" +"%Y%m%d")
    fi
fi

# === Backup Stats ===
remainingnumfilesforbackup=$(grep -o 'remainingnumfilesforbackup="[^"]*"' "$bzpath"/bzstat_remainingbackup.xml | sed 's/remainingnumfilesforbackup="//;s/"//')
remainingnumbytesforbackup=$(grep -o 'remainingnumbytesforbackup="[^"]*"' "$bzpath"/bzstat_remainingbackup.xml | sed 's/remainingnumbytesforbackup="//;s/"//')
totnumfilesforbackup=$(grep -o 'totnumfilesforbackup="[^"]*"' "$bzpath"/bzstat_totalbackup.xml | sed 's/totnumfilesforbackup="//;s/"//')
totnumbytesforbackup_raw=$(grep -o 'totnumbytesforbackup="[^"]*"' "$bzpath"/bzstat_totalbackup.xml | sed 's/totnumbytesforbackup="//;s/"//')
totnumbytesforbackup=$(awk "BEGIN { printf \"%.2f GB\", $totnumbytesforbackup_raw / (1024^3) }")
online_hostname=$(grep -o 'online_hostname="[^"]*"' "/Library/Backblaze.bzpkg/bzdata/bzinfo.xml" | sed 's/online_hostname="//;s/"//')

# === Temporary File Size ===
bztempfile=$(du -hd0 --si /Library/Backblaze.bzpkg 2>/dev/null)
bztempfile_size=$(echo "$bztempfile" | cut -f1)

# === FDA Permissions Check ===
# this is not a good way of doing this. Need to refine this, maybe there's a database locally we can consult.
# here's an idea, we tail -f bzbmenu21.log and see if those lines come up about Warning: blah blah blah, but 21 seems so arbitrary. Whats with that? 
if [[ $(sudo sqlite3 "/Library/Application Support/com.apple.TCC/TCC.db" \
  "SELECT auth_value FROM access WHERE service='kTCCServiceSystemPolicyAllFiles' AND client LIKE '%backblaze%';") == 2 ]]; then
    permissions_issue=0
else
	permissions_issue=1
fi

FDA_PERMISSIONS_ISSUE="$permissions_issue"

# === Boolean Normalization ===
[[ "$safety_frozen" == "not_frozen" ]] && safety_frozen_boolean=0 || safety_frozen_boolean=1
[[ "$encrypted" == "true" ]] && encrypted_boolean=1 || encrypted_boolean=0

# === License Cleanup ===
bzlicense_status="${bzlicense_status#billing_}"
bzlicense="${bzlicense%_billing}"

# === Output ===
echo "fda_permissions_issue${SEPARATOR}${FDA_PERMISSIONS_ISSUE}" >> ${OUTPUT_FILE}
echo "bzversion${SEPARATOR}${bzversion}" > ${OUTPUT_FILE}
echo "bzlogin${SEPARATOR}${bzlogin}">> ${OUTPUT_FILE}
echo "bzlicense${SEPARATOR}${bzlicense}" >> ${OUTPUT_FILE}
echo "bzlicense_status${SEPARATOR}${bzlicense_status}">> ${OUTPUT_FILE}
echo "safety_frozen${SEPARATOR}${safety_frozen_boolean}" >> ${OUTPUT_FILE}
echo "lastbackupcompleted${SEPARATOR}${lastbackupcompleted}">> ${OUTPUT_FILE}
echo "remainingnumfilesforbackup${SEPARATOR}${remainingnumfilesforbackup}" >> ${OUTPUT_FILE}
echo "remainingnumbytesforbackup${SEPARATOR}${remainingnumbytesforbackup}" >> ${OUTPUT_FILE}
echo "totnumfilesforbackup${SEPARATOR}${totnumfilesforbackup}">> ${OUTPUT_FILE}
echo "totnumbytesforbackup${SEPARATOR}${totnumbytesforbackup}">> ${OUTPUT_FILE}
echo "encrypted${SEPARATOR}${encrypted_boolean}">> ${OUTPUT_FILE}
echo "online_hostname${SEPARATOR}${online_hostname}" >> ${OUTPUT_FILE}
echo "bztempfile_size${SEPARATOR}${bztempfile_size}" >> ${OUTPUT_FILE}
