#!/bin/bash
# Author of the script : powen

LocalVersion=$(sed -n 1p version)
LatestVersion=$(curl -Lsk 'https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/version')
Arch=$(sed -n 2p version)
DIR=$(pwd)
if [[ $LatestVersion > $LocalVersion ]] ; then
    rm -rf AltStore.ipa main netmuxd
    wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltStore.ipa
    wget https://github.com/powenn/AltServer-Linux-ShellScript/releases/download/$LatestVersion/AltServer-$Arch.zip
    unzip -o AltServer-$Arch.zip
    cp -R ./AltServer-$Arch/* $DIR
    rm -rf AltServer-$Arch.zip AltServer-$Arch
    chmod +x *.sh
    if [[ -e "AltServer" ]]; then
        chmod +x AltServer
    fi
    echo "Done"
  cat << EOF

What updated in version $LatestVersion ?
  Script:
    - support wifi refresh (only x64 currently)
    - x64 version have several modification , deleted 'd' option and added 'w' and 't'
  AltStore:
    - Updated to 1.4.9
  AltSerevr:
    - Fix Support for iOS 15
    - Updated to v0.0.5
    - with netmuxd ,you can do wifi refresh (only x64 currently)
  Others:
    - GUI edition is now available
      if interested,please check https://github.com/powenn/AltServer-LinuxGUI
    - please make sure you have install libavahi-compat-libdnssd-dev
    
For more information: https://github.com/powenn/AltServer-Linux-ShellScript
<< PLease rerun the script to apply the new version >>
EOF
fi
if [[ $LatestVersion = $LocalVersion ]] ; then
    echo "you are using the latest release"
fi
