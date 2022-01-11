#!/bin/sh


set -x

echo "Checking source"
if [ ! -e "AltStore.ipa" ]; then
    wget https://github.com/powenn/AltServer-Linux-ShellScript/blob/main/AltStore.ipa
elif [ ! -e "ipa" ]; then
    mkdir ipa
elif [ ! -e "saved.txt" ]; then
    touch saved.txt
fi

case "$1" in
  -i|--Install-AltStore )
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
PATH=./AltStore.ipa

echo "Finished"
ExistAccount=$(grep "AppleID:'$AppleID',PASSWORD:'$password'" saved.txt)
if [ ${ExistID}="" ]; then
    echo "Do you want to save this AppleID ? [y/n]"
elif [ ${ExistID}=${ExistID} ]; then
    break
fi
read ans
case "$ans" in
    [yY][eE][sS]|[yY] )
    cat "AppleID:$AppleID,PASSWORD:$password" >> ./saved.txt
    break
    ;;
    [nN][oO]|[nN] )
    break
    ;;
    * )
    ;;
esac
    ;;
  * )
    cat << EOF
#####################################
#                                   #
#  Welcome to the AltServer script  #
#                                   #
#####################################

Usage: ./runsh [OPTION]

OPTIONS

  -i, --Install AltStore
    Install AltStore to your device
  -a, --Install ipa
    Install ipa in Folder 'ipa',make sure you have put ipa files in the Folder before run this
  -d, --Daemon mode
    Switch to Daemon mode to refresh apps or AltStore
  -h, --help
    Show this message ;)
    
EOF
    ;;
esac
