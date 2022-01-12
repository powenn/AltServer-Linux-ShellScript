#!/bin/sh

echo "Checking source"
if [ ! -e "AltStore.ipa" ]; then
    wget https://github.com/powenn/AltServer-Linux-ShellScript/blob/main/AltStore.ipa
elif [ ! -e "ipa" ]; then
    mkdir ipa
elif [ ! -e "saved.txt" ]; then
    touch saved.txt
elif [ "stat AltServer | grep -rw-r--r--" != "" ] ; then
    chmod +x AltServer
elif [ "stat AltServerDaemon | grep -rw-r--r--" != "" ] ; then
    chmod +x AltServerDaemon
fi

    cat << EOF >help.txt
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
    Show this message
    
EOF

cat help.txt

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

ExistAccount=$(cat saved.txt)

if [ "$ExistAccount" != "" ]; then
    echo "Do you want to use saved Account ? [y/n]"
    read reply
    case "$reply" in
        [yY][eE][sS]|[yY] )
        echo "Which account you want to use ? "
        nl saved.txt
        echo "please enter the number "
        read number
        ExistID=$(sed -n "$number"p saved.txt | cut -d , -f 1)
        ExistPasswd=$(sed -n "$number"p saved.txt | cut -d , -f 2)
        ;;
        [nN][oO]|[nN] )
        echo "Please provide your AppleID"
        read AppleID
        echo "Please provide the password of AppleID"
        read password
        ;;
        * )
        ;;
    esac
fi

UDID=$(lsusb -v 2> /dev/null | grep -e "Apple Inc" -A 2 | grep iSerial | awk '{print $3}')
Account=$AppleID,$password
CheckAccount=$(grep $Account saved.txt)

PATH=./AltStore.ipa
if [ "$ExistID" == "" ]; then
    ./AltServer -u "${UDID}" -a "$AppleID" -p "$password" "$PATH"
elif [ "$ExistAccount" != "" ]; then
    ./AltServer -u "${UDID}" -a "$ExistID" -p "$ExistPasswd" "$PATH"
fi
echo "Finished"
if [ "$CheckAccount" == "" ] ; then
    echo "Do you want to save this Account ? [y/n]"
else
    exit
fi
read ans
case "$ans" in
    [yY][eE][sS]|[yY] )
    echo "$Account" >> saved.txt
    echo "saved"
    ;;
    [nN][oO]|[nN] )
    ;;
    * )
    ;;
esac
    ;;
  2|--Install-ipa )
for job in `jobs -p`
do
  wait $job
done

echo "Please connect to your device and press Enter to continue"
read key
idevicepair pair

ExistAccount=$(cat saved.txt)

if [ "$ExistAccount" != "" ]; then
    echo "Do you want to use saved Account ? [y/n]"
    read reply
    case "$reply" in
        [yY][eE][sS]|[yY] )
        echo "Which account you want to use ? "
        nl saved.txt
        echo "please enter the number "
        read number
        ExistID=$(sed -n "$number"p saved.txt | cut -d , -f 1)
        ExistPasswd=$(sed -n "$number"p saved.txt | cut -d , -f 2)
        ;;
        [nN][oO]|[nN] )
        echo "Please provide your AppleID"
        read AppleID
        echo "Please provide the password of AppleID"
        read password
        ;;
        * )
        ;;
    esac
fi

UDID=$(lsusb -v 2> /dev/null | grep -e "Apple Inc" -A 2 | grep iSerial | awk '{print $3}')
Account=$AppleID,$password
CheckAccount=$(grep $Account saved.txt)

echo "Please provide the name of ipa (example: powen.ipa)"
ls ./ipa
PATH=./ipa/$name
if [ "$ExistID" == "" ]; then
    ./AltServer -u "${UDID}" -a "$AppleID" -p "$password" "$PATH"
elif [ "$ExistAccount" != "" ]; then
    ./AltServer -u "${UDID}" -a "$ExistID" -p "$ExistPasswd" "$PATH"
fi
echo "Finished"
if [ "$CheckAccount" == "" ] ; then
    echo "Do you want to save this Account ? [y/n]"
else
    exit
fi
read ans
case "$ans" in
    [yY][eE][sS]|[yY] )
    echo "$Account" >> saved.txt
    echo "saved"
    ;;
    [nN][oO]|[nN] )
    ;;
    * )
    ;;
esac
    ;;
  3|--Daemon-mode )
for job in `jobs -p`
do
  wait $job
done

echo "Please connect to your device and press Enter to continue"
read key
idevicepair pair
./AltServerDaemon
    ;;
  h|--help )
cat help.txt
    ;;
esac
