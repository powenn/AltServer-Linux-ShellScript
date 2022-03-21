#!/bin/bash
# Author of the script : powen

LocalVersion=$(sed -n 1p version)
LatestVersion=$(curl -Lsk 'https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/version')
Arch=$(sed -n 2p version)
DIR=$(pwd)
if [[ $LatestVersion > $LocalVersion ]] ; then
    rm -rf AltStore.ipa main
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
    - AltSerevrDaemon is no longer needed,you can delete it
  AltStore:
    - Updated to 1.4.9
  AltSerevr:
    - Fix Support fot iOS 15(currently only x64)
  Others:
    - GUI edition is now available
      if interested,please check https://github.com/powenn/AltServer-LinuxGUI
    
For more information: https://github.com/powenn/AltServer-Linux-ShellScript
<< PLease rerun the script to apply the new version >>
EOF
fi
if [[ $LatestVersion = $LocalVersion ]] ; then
    echo "you are using the latest release"
fi
