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

    cat << EOF
#####################################
#                                   #
#  Welcome to the AltServer script  #
#                                   #
#####################################

Usage: [OPTION]

OPTIONS

  1, --Install AltStore
    Install AltStore to your device
  2, --Install ipa
    Install ipa in Folder 'ipa',make sure you have put ipa files in the Folder before run this
  3, --Daemon mode
    Switch to Daemon mode to refresh apps or AltStore
  h, --help
    Show this message ;)
    
EOF
echo "Enter OPTION to continue"
read option
case "$option" in
  1|--Install-AltStore )
for job in `jobs -p`
do
  wait $job
done

echo "It will install AltStore to your device"
echo "Please connect to your device and press Enter to continue"
read key
idevicepair pair

echo "Please provide your AppleID"
read AppleID
echo "Please provide the password of AppleID"
read password

UDID=$(lsusb -v 2> /dev/null | grep -e "Apple Inc" -A 2 | grep iSerial | awk '{print $3}')
Account="AppleID:$AppleID,PASSWORD:$password"
Exist=$(grep $Account saved.txt)

PATH=./AltStore.ipa

echo "Finished"
if  [ $Exist="" ] ; then
    echo "Do you want to save this Account ? [y/n]"
else
    exit
fi
read ans
case "$ans" in
    [yY][eE][sS]|[yY] )
    echo "AppleID:$AppleID,PASSWORD:$password" >> saved.txt
    ;;
    [nN][oO]|[nN] )
    ;;
    * )
    ;;
esac
    ;;
esac

