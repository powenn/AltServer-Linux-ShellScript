#!/bin/bash

set -e

rm -rf AltServer start.sh update.sh
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltServer
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/start.sh
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/update.sh

chmod +x AltServer
chmod +x update.sh
chmod +x start.sh

echo "Update Finished"
exit
