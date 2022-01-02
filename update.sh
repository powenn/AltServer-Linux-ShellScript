#!/bin/bash

set -e

rm -rf AltServer start.sh update.sh AltStore.ipa
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltServer
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/start.sh
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/update.sh
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltStore.ipa

chmod +x AltServer
chmod +x update.sh
chmod +x start.sh

echo "Update Finished"
exit
