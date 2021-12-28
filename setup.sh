#!/bin/bash

set -ex

for job in `jobs -p`
do
  wait $job
done

sudo apt-get install qemu-user-static schroot debootstrap curl wget

echo “Now setting chroot at /chroot”
sudo mkdir -p /chroot/debian-x86_64

sudo debootstrap --arch amd64 --foreign stretch /chroot/debian-x86_64 http://debian.xtdv.net/debian

cp /usr/bin/qemu-i386-static /chroot/debian-x86_64/usr/bin

echo “It would take some times”
chroot "/chroot/debian-x86_64" /debootstrap/debootstrap --second-stage

wget https://raw.githubusercontent.com/powenn/AltServer-Linux-arm64/main/debianx86_64.conf
cp -R ./debianx86_64.conf /etc/schroot/chroot.d/debianx86_64.conf
wget https://raw.githubusercontent.com/powenn/AltServer-Linux-arm64/main/update.sh


sudo schroot -c debian-x86_64
apt update && apt upgrade && apt install curl wget
cd home
mkdir ipa
curl -0 https://github.com/powenn/AltServer-Linux-arm64/raw/main/AltServer
chmod +x AltServer
echo “Finished”
exit
