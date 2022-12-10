check_wifi="$(nmcli device status | grep -w connected | awk '{ print $2 }')"
check_ethernet_wifi="$(nmcli device status | grep -w "connected" | awk '{ print $2 }' | sed 'N;s/\n/ /')"
check_ethernet="$(nmcli device status | grep -w connected | awk '{ print $2 }')"

if [[ $check_wifi = wifi ]]; then
	echo ""
elif [[ $check_ethernet_wifi = "ethernet wifi" ]]; then
	echo "  "
elif [[ $check_ethernet = ethernet ]]; then
	echo ""
else
	echo ""
fi