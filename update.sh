#!/bin/bash
# Author of the script : powen

cd "$(dirname "$0")"
LocalVersion=$(sed -n 1p version)
LatestVersion=$(curl -Lsk 'https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/version')
Arch=$(sed -n 2p version)
DIR=$(pwd)
if [[ $LatestVersion != $LocalVersion ]] ; then
    rm -rf AltStore.ipa
    wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltStore.ipa
    wget https://github.com/powenn/AltServer-Linux-ShellScript/releases/download/$LatestVersion/AltServer-$Arch.zip
    unzip -o AltServer-$Arch.zip
    cp -R ./AltServer-$Arch/* $DIR
    rm -rf AltServer-$Arch.zip AltServer-$Arch
    echo "Done"
elif [[ $LatestVersion = $LocalVersion ]] ; then
    echo "you are using the latest release"
fi

  cat << EOF

What updated in version $LatestVersion ?
  Script:
    - Added update option
    - daemon mode improved
EOF
