#!/bin/bash
# Author of the script : powen

# Check source and permission
cd "$(dirname "$0")"
echo "Checking source"
if [[ ! -e "AltStore.ipa" ]]; then
    wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltStore.ipa
fi
if [[ ! -e "main" ]]; then
    wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/main
fi
if [[ ! -e "ipa" ]]; then
    mkdir ipa
fi
if [[ ! -e "saved.txt" ]]; then
    touch saved.txt
fi
if [[ "stat main | grep -- '-rw-r--r--'" != "" ]] ; then
    chmod +x main
fi
if [[ "stat AltServer | grep -- '-rw-r--r--'" != "" ]] ; then
    chmod +x AltServer
fi
if [[ "stat AltServerDaemon | grep -- '-rw-r--r--'" != "" ]] ; then
    chmod +x AltServerDaemon
fi

# Version
LocalVersion=$(sed -n 1p version)
LatestVersion=$(curl -Lsk 'https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/version')


# Help message
HELP() {
cat << EOF
    
#####################################
#  Welcome to the AltServer script  #
#####################################

ScriptUsage: [OPTION]

OPTIONS

  i, --Install AltStore or ipa files
    Install AltStore or ipa files to your device
  d, --Restart Daemon mode
    Restart Daemon mode to refresh apps or AltStore
  e, --Exit
    Exit script
  h, --Help
    Show this message
  u, --Update
    Update this script or AltServer

For more information: https://github.com/powenn/AltServer-Linux-ShellScript

EOF
}

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
HELP
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
    
  i|--Install-AltStore-or-ipa-files )
    ./main
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
    HELP
    UpdateNotification
    ;;
  u|--Update )
    curl -Lsk 'https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/update.sh' | bash
    ;;
    esac

done

