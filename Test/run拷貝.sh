#!/bin/bash

set -x
echo "Checking source"
if [[ ! -e "./ipa/AltStore.ipa" ]]; then
    mkdir ipa
    cd ipa && wget https://github.com/powenn/AltServer-Linux-ShellScript/blob/main/AltStore.ipa
    cd ..
fi
if [[ ! -e "ipa" ]]; then
    mkdir ipa
fi
if [[ ! -e "saved.txt" ]]; then
    touch saved.txt
fi
if [[ "stat AltServer | grep -rw-r--r--" != "" ]] ; then
    chmod +x AltServer
fi

    cat << EOF >help.txt
    
#####################################
#  Welcome to the AltServer script  #
#####################################

Usage: [OPTION]

OPTIONS

  i, --Install ipa
    Install ipa in Folder 'ipa',make sure you have put ipa files in the Folder before run this
  d, --Daemon mode
    Switch to Daemon mode to refresh apps or AltStore
  e, --exit
    Exit script
  h, --help
    Show this message
    
EOF

printf "\e[49m       \e[38;5;73;49m▄▄\e[38;5;66;49m▄\e[38;5;66;48;5;73m▄▄▄▄▄▄▄▄\e[38;5;66;49m▄\e[38;5;73;49m▄▄\e[49m       \e[m
\e[49m     \e[38;5;73;49m▄\e[38;5;66;48;5;73m▄\e[38;5;66;48;5;66m▄▄▄▄▄▄\e[38;5;67;48;5;66m▄▄\e[38;5;66;48;5;66m▄▄▄▄▄▄\e[38;5;66;48;5;73m▄\e[38;5;73;49m▄\e[49m     \e[m
\e[49m   \e[38;5;73;49m▄\e[38;5;30;48;5;73m▄\e[38;5;30;48;5;30m▄▄▄▄▄▄\e[38;5;109;48;5;73m▄\e[38;5;109;48;5;109m▄▄▄▄\e[38;5;109;48;5;73m▄\e[38;5;30;48;5;30m▄▄▄▄▄▄\e[38;5;30;48;5;73m▄\e[38;5;73;49m▄\e[49m   \e[m
\e[49m \e[38;5;73;49m▄\e[38;5;30;48;5;73m▄\e[38;5;30;48;5;30m▄▄▄▄▄▄\e[38;5;73;48;5;30m▄\e[38;5;73;48;5;73m▄▄▄▄▄▄▄▄\e[38;5;73;48;5;30m▄\e[38;5;30;48;5;30m▄▄▄▄▄▄\e[38;5;30;48;5;73m▄\e[38;5;73;49m▄\e[49m \e[m
\e[49m \e[38;5;30;48;5;73m▄\e[38;5;30;48;5;30m▄▄▄▄▄\e[38;5;73;48;5;30m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;15;48;5;73m▄\e[38;5;15;48;5;15m▄▄\e[38;5;15;48;5;73m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;73;48;5;30m▄\e[38;5;30;48;5;30m▄▄▄▄▄\e[38;5;30;48;5;73m▄\e[49m \e[m
\e[38;5;73;48;5;73m▄\e[38;5;30;48;5;30m▄▄▄\e[38;5;73;48;5;30m▄▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;15;48;5;73m▄\e[38;5;15;48;5;15m▄\e[48;5;15m    \e[38;5;15;48;5;15m▄\e[38;5;15;48;5;73m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;73;48;5;30m▄▄\e[38;5;30;48;5;30m▄▄▄\e[38;5;73;48;5;73m▄\e[m
\e[38;5;73;48;5;73m▄\e[38;5;30;48;5;30m▄▄\e[38;5;66;48;5;30m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;15;48;5;73m▄\e[48;5;15m          \e[38;5;15;48;5;73m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;66;48;5;30m▄\e[38;5;30;48;5;30m▄▄\e[38;5;73;48;5;73m▄\e[m
\e[38;5;73;48;5;73m▄\e[38;5;30;48;5;30m▄▄\e[38;5;30;48;5;66m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;73;48;5;15m▄\e[48;5;15m          \e[38;5;73;48;5;15m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;30;48;5;66m▄\e[38;5;30;48;5;30m▄▄\e[38;5;73;48;5;73m▄\e[m
\e[38;5;73;48;5;73m▄\e[38;5;6;48;5;6m▄▄▄\e[38;5;6;48;5;66m▄\e[38;5;6;48;5;73m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;73;48;5;15m▄\e[38;5;15;48;5;15m▄\e[48;5;15m    \e[38;5;15;48;5;15m▄\e[38;5;73;48;5;15m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;6;48;5;73m▄\e[38;5;6;48;5;72m▄\e[38;5;6;48;5;6m▄▄▄\e[38;5;73;48;5;73m▄\e[m
\e[49m \e[38;5;73;48;5;6m▄\e[38;5;6;48;5;6m▄▄▄▄▄\e[38;5;6;48;5;73m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;73;48;5;15m▄\e[38;5;15;48;5;15m▄▄\e[38;5;73;48;5;15m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;6;48;5;73m▄\e[38;5;6;48;5;6m▄▄▄▄▄\e[38;5;73;48;5;6m▄\e[49m \e[m
\e[49m \e[49;38;5;66m▀\e[38;5;67;48;5;6m▄\e[38;5;6;48;5;6m▄▄▄▄▄▄\e[38;5;6;48;5;73m▄\e[38;5;73;48;5;73m▄▄▄▄▄▄▄▄\e[38;5;6;48;5;73m▄\e[38;5;6;48;5;6m▄▄▄▄▄▄\e[38;5;67;48;5;6m▄\e[49;38;5;66m▀\e[49m \e[m
\e[49m   \e[49;38;5;67m▀\e[38;5;66;48;5;6m▄\e[38;5;6;48;5;6m▄▄▄▄▄▄\e[38;5;66;48;5;73m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;66;48;5;73m▄\e[38;5;6;48;5;6m▄▄▄▄▄▄\e[38;5;66;48;5;6m▄\e[49;38;5;67m▀\e[49m   \e[m
\e[49m     \e[49;38;5;66m▀\e[38;5;66;48;5;6m▄\e[38;5;6;48;5;6m▄▄▄▄▄▄\e[38;5;6;48;5;30m▄▄\e[38;5;6;48;5;6m▄▄▄▄▄▄\e[38;5;66;48;5;6m▄\e[49;38;5;66m▀\e[49m     \e[m
\e[49m       \e[49;38;5;66m▀▀\e[49;38;5;6m▀\e[38;5;66;48;5;6m▄▄▄▄▄▄▄▄\e[49;38;5;6m▀\e[49;38;5;66m▀▀\e[49m       \e[m
";
cat help.txt
echo "Please connect to your device and press Enter to continue"
read key
idevicepair pair

RunScript=0
while [ $RunScript = 0 ] ; do
    echo "Enter OPTION to continue"
    read option
    case "$option" in
    
  i|--Install-ipa )
  
    HasExistAccount=$(cat saved.txt)
    UDID=$(lsusb -v 2> /dev/null | grep -e "Apple Inc" -A 2 | grep iSerial | awk '{print $3}')
    HasExistipa=$(ls ipa)
    
    for job in `jobs -p`
    do
    wait $job
    done

    idevicepair pair
    
    if [[ "$HasExistipa" != "" ]]; then
        echo "Please provide the number of ipa "
        echo "$HasExistipa" > ipaList.txt
        nl ipaList.txt
        read ipanumber
        Existipa=$(sed -n "$ipanumber"p ipaList.txt )
    else
        echo "There is no ipa filess in ipa folder "
        exit
    fi
    
    if [[ "$HasExistAccount" != "" ]]; then
        echo "Do you want to use saved Account ? [y/n]"
        read reply
        case "$reply" in
        [yY][eE][sS]|[yY] )
        echo "Which account you want to use ? "
        UseExistAccount=1
        nl saved.txt
        echo "please enter the number "
        read number
        ExistID=$(sed -n "$number"p saved.txt | cut -d , -f 1)
        ExistPasswd=$(sed -n "$number"p saved.txt | cut -d , -f 2)
        ;;
        [nN][oO]|[nN] )
        UseExistAccount=0
        ;;
        esac
    fi
    if [[ "$HasExistAccount" == "" ]]; then
        UseExistAccount=0
    fi
    if [[ $UseExistAccount = 0 ]]; then
        echo "Please provide your AppleID"
        read AppleID
        echo "Please provide the password of AppleID"
        read password
    fi
    
    Account=$AppleID,$password
    CheckAccount=$(grep $Account saved.txt)
    if [[ "$CheckAccount" == "" ]] ; then
        echo "Do you want to save this Account ? [y/n]"
        read ans
        case "$ans" in
        [yY][eE][sS]|[yY] )
        echo "$Account" >> saved.txt
        echo "saved"
        ;;
        [nN][oO]|[nN] )
        ;;
        esac
    fi
    PATH=./ipa/$Existipa
    
    if [[ $UseExistAccount = 1 ]]; then
        ./AltServer -u ${UDID} -a $ExistID -p $ExistPasswd $PATH
    fi
    if [[ $UseExistAccount = 0 ]]; then
        ./AltServer -u ${UDID} -a $AppleID -p $password $PATH
    fi
    exit
    ;;
    
    
  d|--Daemon-mode )
    for job in `jobs -p`
    do
    wait $job
    done

    idevicepair pair
    ./AltServer
    ;;
  e|--exit )
    RunScript=1
    ;;
  h|--help )
    cat help.txt
    ;;
    esac

done
