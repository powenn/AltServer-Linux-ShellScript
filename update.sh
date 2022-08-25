#!/bin/bash
# Author of the script : powen

LocalVersion=$(sed -n 1p version)
LatestVersion=$(curl -Lsk 'https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/version')
ARCH=$(uname -m)
DIR=$(pwd)
if [[ $LatestVersion > $LocalVersion ]] ; then
    rm -rf AltStore.ipa main netmuxd AltServer
    wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltStore.ipa
    wget https://github.com/powenn/AltServer-Linux-ShellScript/releases/download/$LatestVersion/AltServer-$ARCH.zip
    unzip -o AltServer-$ARCH.zip
    cp -R ./AltServer-$ARCH/* $DIR
    rm -rf AltServer-$ARCH.zip AltServer-$ARCH
    chmod +x *.sh
    if [[ -e "AltServer" ]]; then
        chmod +x AltServer
    fi
    echo "Done"
  cat << EOF

What updated in version $LatestVersion ?
  Script:
    - Support wifi refresh (only x64 currently)
    - Codes improved
  AltStore:
    - Updated to 1.5.1
  AltSerevr:
    - Fix Support for iOS 15
    - Updated to v0.0.5
    - with netmuxd ,you can do wifi refresh (only x64 currently)
  Others:
    - please make sure you have install libavahi-compat-libdnssd-dev
    
For more information: https://github.com/powenn/AltServer-Linux-ShellScript
<< PLease relaunch the script to apply the new version >>
EOF
fi
if [[ $LatestVersion = $LocalVersion ]] ; then
    echo "you are using the latest release"
fi
