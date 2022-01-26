#!/bin/bash
# Author of the script : powen

cd "$(dirname "$0")"
rm -rf AltStore.ipa
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltStore.ipa

LocalVersion=$(sed -n 1p version)
LatestVersion=$(curl -Lsk 'https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/version')
Arch=$(sed -n 2p version)
if [[ $LatestVersion != $LocalVersion ]] ; then
    cd ..
    wget https://github.com/powenn/AltServer-Linux-ShellScript/releases/download/$LatestVersion/AltServer-$Arch.zip
    unzip -o AltServer-$Arch.zip
    rm -rf AltServer-$Arch.zip
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
