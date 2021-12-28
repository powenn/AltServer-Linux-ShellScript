#!/bin/bash

set -e

for job in `jobs -p`
do
  wait $job
done

mkdir AltServer
cd AltServer
wget https://raw.githubusercontent.com/powenn/AltServer-Linux-ShellScript/main/update.sh
wget https://raw.githubusercontent.com/powenn/AltServer-Linux-ShellScript/main/start.sh
wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltServer
chmod +x AltServer
chmod +x start.sh
chmod +x update.sh
mkdir ipa
echo "Finished"
echo "run 'cd AltServer' and ./start.sh to start "
echo "Please storage your ipa files into the 'ipa' folder"
ls
exit
