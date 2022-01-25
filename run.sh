#!/bin/bash
# Author of the script : powen, olivertzeng

# Check source and permission
cd "$(dirname "$0")"
echo "Checking source"
if [[ ! -e "AltStore.ipa" ]]; then
    wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltStore.ipa
fi
if [[ ! -e "unc0ver_Release_8.0.2.ipa" ]]; then
    wget https://unc0ver.dev/downloads/8.0.2/9e44edfbfd1905cadf23c3b9ad1d5bed683ce061/unc0ver_Release_8.0.2.ipa
fi
if [[ ! -e "1.6.4-12.2-12.5.ipa" ]]; then
    wget https://github.com/coolstar/electra-ipas/raw/master/chimera/1.6.4-12.2-12.5.ipa
fi
if [[ ! -e "Taurine-1.1.1.ipa" ]]; then
    wget https://github.com/Odyssey-Team/Taurine/releases/download/1.1.1/Taurine-1.1.1.ipa
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


# Instruction
cat << EOF >help.txt
    
#####################################
#  Welcome to the AltServer script  #
#####################################

Usage: [OPTION]

OPTIONS

  a, --Install-AltStore
    Install AltStore to your device
  u, --Install-unc0ver
    Install unc0ver to your device iOS11.0~14.8
  c, --Install-Chimera
    Install Chimera to your device iOS12.2~12.5.5
  t, --Install-Taurine
    Install Taurine to your device iOS14.0~14.3 
  2, --Install ipa
    Install ipa in Folder 'ipa',make sure you have put ipa files in the Folder before run this
  d, --Restart Daemon mode
    Restart Daemon mode to refresh apps or AltStore
  e, --exit
    Exit script
  h, --help
    Show this message
    
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

# Start script
AltServerIcon
cat help.txt
echo "Please connect to your device and press Enter to continue"
read key
idevicepair pair > /dev/null
./AltServer &> /dev/null &

RunScript=0
while [ $RunScript = 0 ] ; do
    echo "Enter OPTION to continue"
    read option
    case "$option" in
    
  a|--Install-AltStore )
  
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
    
  u|--Install-unc0ver )
  
    for job in `jobs -p`
    do
    wait $job
    done

    idevicepair pair
    AskAccount
    
    Account=$AppleID,$password
    CheckAccount=$(grep $Account saved.txt)
    PATH=./unc0ver_Release_8.0.2.ipa
    
    AltServer
    ;;
   
  c|--Install-Chimera )
  
    for job in `jobs -p`
    do
    wait $job
    done

    idevicepair pair
    AskAccount
    
    Account=$AppleID,$password
    CheckAccount=$(grep $Account saved.txt)
    PATH=./1.6.4-12.2-12.5.ipa
    
    AltServer
    ;;
     
  t|--Install-Taurine )
  
    for job in `jobs -p`
    do
    wait $job
    done

    idevicepair pair
    AskAccount
    
    Account=$AppleID,$password
    CheckAccount=$(grep $Account saved.txt)
    PATH=./Taurine-1.1.1.ipa
    
    AltServer
    ;;
  
  i|--Install-ipa )
  
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
        
  d|--Daemon-mode )
    for job in `jobs -p`
    do
    wait $job
    done

    idevicepair pair
    ./AltServerDaemon
    ;;
  e|--exit )
    exit
    ;;
  h|--help )
    AltServerIcon
    cat help.txt
    ;;
    esac

done

while [ $RunScript = 1 ] ; do
    SaveAcccount
done
