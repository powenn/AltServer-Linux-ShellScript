#!/bin/bash
# Author of the script : powen

cd "$(dirname "$0")"

LocalVersion=$(sed -n 1p version)
LatestVersion=$(curl -Lsk 'https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/version')
Arch=$(sed -n 2p version)
if [[ $LatestVersion != $LocalVersion ]] ; then
    cd ..
    wget https://github.com/powenn/AltServer-Linux-ShellScript/releases/download/$LatestVersion/AltServer-$Arch.zip
    unzip -o AltServer-$Arch.zip
    rm -rf AltServer-$Arch.zip
    cd "$(dirname "$0")"
    chmod +x run.sh
    find *AltServer* | xargs chmod +x
    echo "Done"
elif [[ $LatestVersion = $LocalVersion ]] ; then
    echo "you are using latest release"
fi

  cat << EOF

What updated in version $LatestVersion ?
  Script:
    - Added update option
    - daemon mode improved
EOF
