#!/bin/bash
# Author of the script : powen

cd "$(dirname "$0")"
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
    - Improved update notification
    - Improved update option
<< PLease rerun the script to apply the new version >>
EOF
fi
if [[ $LatestVersion = $LocalVersion ]] ; then
    echo "you are using the latest release"
fi
