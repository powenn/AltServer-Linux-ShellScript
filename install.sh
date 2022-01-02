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
plistutil -i ./Payload/AltStore.app/Info.plist -o ./Payload/AltStore.app/temp.txt
sed -i 's/'00008030-001948590202802E'/'${UDID}'/' ./Payload/AltStore.app/temp.txt
plistutil -i ./Payload/AltStore.app/temp.txt -o ./Payload/AltStore.app/Info.plist
rm -rf ./Payload/AltStore.app/temp.txt
zip -qr TempAltStore.ipa Payload
PATH=./TempAltStore.ipa

./AltServer -u "${UDID}" -a "$AppleID" -p "$password" "$PATH"
rm -rf TempAltStore.ipa Payload
echo "Finished"
echo "To use AltServer as daemon,run ./daemon.sh"
exit
