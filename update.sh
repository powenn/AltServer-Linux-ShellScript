#!/bin/bash

set -e

rm -rf AltServer start.sh update.sh AltStore.ipa daemon.sh install.sh
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltServer
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltServerDaemon
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/start.sh
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/update.sh
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/install.sh
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/daemon.sh
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltStore.ipa

chmod +x AltServer
chmod +x AltServerDaemon
chmod +x update.sh
chmod +x start.sh
chmod +x install.sh
chmod +x daemon.sh

echo "Update Finished"
exit
