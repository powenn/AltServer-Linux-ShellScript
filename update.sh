#!/bin/bash

set -ex

rm -rf AltServer
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltServer
chmod +x AltServer
echo "Update Finished"
exit
