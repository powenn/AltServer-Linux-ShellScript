#!/bin/bash
# Author of the script : powen

# Get Arch
ARCH=$(uname -m)
NETMUXD_AVAILABLE_ARCHS=("x86_64" "aarch64" "armv7" "armv7l")
NETMUXD_IS_AVAILABLE=0
NETMUXD_IS_ON=0

# Check source and permission
cd "$(dirname "$0")" || exit
echo "Checking source"
if [[ ! -e "AltServer" ]]; then
    curl -L https://github.com/NyaMisty/AltServer-Linux/releases/download/v0.0.5/AltServer-"$ARCH" > AltServer
fi
if [[ ! -e "AltStore.ipa" ]]; then
    curl -L https://cdn.altstore.io/file/altstore/apps/altstore/1_5_1.ipa > AltStore.ipa
fi
if [[ ! -e "main" ]]; then
    wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/main
fi
if [[ ! -e "netmuxd" && ${NETMUXD_AVAILABLE_ARCHS[*]} =~ ${ARCH} ]]; then
    curl -L https://github.com/jkcoxson/netmuxd/releases/download/v0.1.4/"$ARCH"-linux-netmuxd > netmuxd
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
if [[ "stat netmuxd | grep -- '-rw-r--r--'" != "" ]] ; then
    chmod +x netmuxd
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
  w, --Switch to wifi Daemode mode (Default using it after launch)
    Switch and restart to wifi Daemode mode to refresh apps or AltStore
  t, --Switch to usb tethered Daemode mode
    Switch and restart to usb tethered Daemode mode to refresh apps or AltStore
  e, --Exit
    Exit script
  h, --Help
    Show this message
  p, --Pair
    Pair device
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

# AltServerIcon
HELP
UpdateNotification
if [[ ${NETMUXD_AVAILABLE_ARCHS[*]} =~ ${ARCH} ]]; then
    NETMUXD_IS_AVAILABLE=1
    sudo -b -S ./netmuxd
fi

./AltServer &> /dev/null &

RunScript=0
while [ $RunScript = 0 ] ; do
    echo "Enter OPTION to continue"
    read option
    case "$option" in
    
  i|--Install-AltStore-or-ipa-files )
    export "NETMUXD_IS_ON"=$NETMUXD_IS_ON
    ./main
    ;;
  w|--Switch-to-wifi-Daemon-mode )
    if [[ $NETMUXD_IS_AVAILABLE == 1 ]]; then
        killall AltServer
        sudo killall netmuxd
        NETMUXD_IS_ON=1
        for job in `jobs -p`
        do
        wait $job
        done
        sudo -b -S ./netmuxd
        ./AltServer &> /dev/null &
    else 
        echo "wifi-Daemon-mode is not available for your architecture"
    fi
    ;;
  t|--Switch-to-usb-tethered-Daemode-mode )
    killall AltServer
    if [[ $NETMUXD_IS_AVAILABLE == 1 ]]; then
        sudo killall netmuxd
        NETMUXD_IS_ON=0
    fi
    for job in `jobs -p`
    do
    wait $job
    done
    ./AltServer &> /dev/null &
    ;;
  e|--Exit )
    killall AltServer
    if [[ $NETMUXD_IS_AVAILABLE == 1 ]]; then
        sudo killall netmuxd
    fi
    exit
    ;;
  h|--Help )
    # AltServerIcon
    HELP
    UpdateNotification
    ;;
  p|--Pair )
    idevicepair pair
    ;;
  u|--Update )
    curl -Lsk 'https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/update.sh' | bash
    ;;
    esac

done

