#!/bin/bash

set -ex

sudo schroot -c debian-x86_64
cd home
rm -rf AltServer
curl -0 https://github.com/powenn/AltServer-Linux-arm64/raw/main/AltServer
chmod +x AltServer
echo “Update Finished”
exit
