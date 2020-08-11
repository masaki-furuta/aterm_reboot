#!/bin/bash -e


ROUTER_IP=
USERNAME=
PASSWORD=
CURL_OPT="curl -s -m 5 -u ${USERNAME}:${PASSWORD}"

echo "Trying to reboot..."
echo

SESSION_ID=$(${CURL_OPT} "http://${ROUTER_IP}/index.cgi/reboot_main" | sed -e '/SESSION_ID/!d' -e "s/.*value='\(.*\)'.*$/\1/")
STATUS=$(${CURL_OPT} -o /dev/null "http://${ROUTER_IP}/index.cgi/reboot_main_set" -d "UPDATE_BUTTON=Reboot&SESSION_ID=${SESSION_ID}" -o /dev/stderr -w "%{http_code}")

if [[ $STATUS -ne 200 ]]; then
    echo "Error: $STATUS"
    exit "$STATUS"
fi

echo "Reboot done !"
echo 
echo "Please wait 170 sec..."
echo
exit 0
