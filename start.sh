#!/bin/bash

set -ex

for job in `jobs -p`
do
  wait $job
done

echo “please make sure you had storage ipa files to/chroot/debian-x86_64/home/ipa/*.ipa”
echo “connect your device and press Enter to continue”
read key
mount --bind /dev /chroot/dev
sudo schroot -c debian-x86_64
cd home

UDID = [ lsusb -v 2> /dev/null | grep -e "Apple Inc" -A 2 ]

echo “Please provide your AppleID”
read AppleID

echo “Please provide the password of AppleID”
read password

echo “Please provide the name of ipa
ls ./ipa
read name

PATH = /home/ipa/$(name)

./AltServer -u $(UDID) -a $(AppleID) -p $(password) $(PATH)
exit
