#!/bin/bash

set -e

for job in `jobs -p`
do
  wait $job
done

echo "It will install AltStore to your device"
echo "Please connect to your device and press Enter to continue"
read key
idevicepair pair
UDID=$(lsusb -v 2> /dev/null | grep -e "Apple Inc" -A 2 | grep iSerial | awk '{print $3}')
echo "This is the UDID of your device"
echo "${UDID}"

echo "Please provide your AppleID"
read AppleID

echo "Please provide the password of AppleID"
read password

unzip AltStore.ipa
rm -rf AltStore.ipa
plutil -replace ALTDeviceID -string "${UDID}" ./Payload/AltStore.app/Info.plist
zip -qr AltStore.ipa Payload
rm -rf Payload
PATH=./AltStore.ipa

./AltServer -u "${UDID}" -a "$AppleID" -p "$password" "$PATH"
echo "Finished"
echo "To use AltServer as daemon,run ./daemon.sh"
exit
