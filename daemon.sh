#!/bin/bash

for job in `jobs -p`
do
  wait $job
done

echo "Please connect to your device and press Enter to continue"
read key
idevicepair pair
./AltServerDaemon
