#!/bin/bash

set -e

cd ..
rm -rf AltServer
rm -rf setup.sh
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/setup.sh
chmod +x setup.sh
./setup.sh
echo "Update Finished"
exit
