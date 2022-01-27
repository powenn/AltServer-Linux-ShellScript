#!/bin/bash
# Author of the script : powen

# Check source and permission
cd "$(dirname "$0")"
echo "Checking source"
if [[ ! -e "AltStore.ipa" ]]; then
    wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltStore.ipa
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
if [[ "stat AltServerDaemon | grep -rw-r--r--" != "" ]] ; then
    chmod +x AltServerDaemon
fi

#####
HasExistAccount=$(cat saved.txt)
UDID=$(lsusb -v 2> /dev/null | grep -e "Apple Inc" -A 2 | grep iSerial | awk '{print $3}')
HasExistipa=$(ls ipa)
LocalVersion=$(sed -n 1p version)
LatestVersion=$(curl -Lsk 'https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/version')


# Instruction
cat << EOF >help.txt
    
#####################################
#  Welcome to the AltServer script  #
#####################################

Usage: [OPTION]

OPTIONS

  1, --Install AltStore
    Install AltStore to your device
  2, --Install ipa
    Install ipa in Folder 'ipa',make sure you have put ipa files in the Folder before run this
  d, --Restart Daemon mode
    Restart Daemon mode to refresh apps or AltStore
  e, --Exit
    Exit script
  h, --Help
    Show this message
  u, --Update
    Update this script or AltServer
    
EOF

# Print AltServer icon
AltServerIcon() {
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
}

# Check if there exists saved account
# Ask if want to use saved account
AskAccount() {
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
}

# Execute AltServer
# Check if this account existed before
AltServer() {
    if [[ $UseExistAccount = 1 ]]; then
        ./AltServer -u ${UDID} -a $ExistID -p $ExistPasswd $PATH
    fi
    if [[ $UseExistAccount = 0 ]]; then
        ./AltServer -u ${UDID} -a $AppleID -p $password $PATH
    fi
    if [[ "$CheckAccount" == "" ]] ; then
        RunScript=1
    fi
    if [[ "$CheckAccount" != "" ]] ; then
        exit
    fi
}

# Check if there exists ipa files in ipa folder
# Ask which ipa want to install
ipaCheck() {
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
}

# Ask to save the new account
SaveAcccount() {
    echo "Do you want to save this Account ? [y/n]"
    read ans
    case "$ans" in
    [yY][eE][sS]|[yY] )
    echo "$Account" >> saved.txt
    echo "saved"
    exit
    ;;
    [nN][oO]|[nN] )
    exit
    ;;
    esac
}

# Show update avaliable message
UpdateNotification() {
if [[ $LatestVersion > $LocalVersion ]] ; then
cat << EOF

-------<< UPDATE AVALIABLE >>-------

EOF
fi
}

# Start script
AltServerIcon
cat help.txt
UpdateNotification
echo "Please connect to your device and press Enter to continue"
read key
idevicepair pair > /dev/null
./AltServerDaemon &> /dev/null &

RunScript=0
while [ $RunScript = 0 ] ; do
    echo "Enter OPTION to continue"
    read option
    case "$option" in
    
  1|--Install-AltStore )
    killall AltServerDaemon
    for job in `jobs -p`
    do
    wait $job
    done

    idevicepair pair
    AskAccount
    
    Account=$AppleID,$password
    CheckAccount=$(grep $Account saved.txt)
    PATH=./AltStore.ipa
    
    AltServer
    ;;
    
  2|--Install-ipa )
    killall AltServerDaemon
    for job in `jobs -p`
    do
    wait $job
    done

    idevicepair pair
    ipaCheck
    AskAccount

    Account=$AppleID,$password
    CheckAccount=$(grep $Account saved.txt)
    PATH=./ipa/$Existipa
    
    AltServer
    ;;
        
  d|--Restart-Daemon-mode )
    killall AltServerDaemon
    for job in `jobs -p`
    do
    wait $job
    done

    idevicepair pair
    ./AltServerDaemon &> /dev/null &
    ;;
  e|--Exit )
    killall AltServerDaemon
    exit
    ;;
  h|--Help )
    AltServerIcon
    cat help.txt
    UpdateNotification
    ;;
  u|--Update )
    curl -Lsk 'https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/update.sh' | bash
    ;;
    esac

done

while [ $RunScript = 1 ] ; do
    SaveAcccount
done
