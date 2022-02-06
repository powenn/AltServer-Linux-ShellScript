#!/bin/bash
# Author of the script : powen

LocalVersion=$(sed -n 1p version)
LatestVersion=$(curl -Lsk 'https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/version')
Arch=$(sed -n 2p version)
DIR=$(pwd)
if [[ $LatestVersion > $LocalVersion ]] ; then
    rm -rf AltStore.ipa
    wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltStore.ipa
    wget https://github.com/powenn/AltServer-Linux-ShellScript/releases/download/$LatestVersion/AltServer-$Arch.zip
    unzip -o AltServer-$Arch.zip
    cp -R ./AltServer-$Arch/* $DIR
    rm -rf AltServer-$Arch.zip AltServer-$Arch
    chmod +x *.sh
    if [[ -e "AltServer" ]]; then
        chmod +x AltServer
    fi
    if [[ -e "AltServerDaemon" ]]; then
        chmod +x AltServerDaemon
    fi
    echo "Done"
  cat << EOF

What updated in version $LatestVersion ?
  Script:
    - Fix loop issue, now you can stay at the script after install AltStore or ipa
    - Daemon mode will keep running in background,so you can sign in after install Altstore
    - Merged 1 and 2 option into "i" option,in i option, you can select install AltStore or ipa or back to AltServer Script
<< PLease rerun the script to apply the new version >>
EOF
fi
if [[ $LatestVersion = $LocalVersion ]] ; then
    echo "you are using the latest release"
fi
