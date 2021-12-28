#!/bin/bash

set -e

UDID=$(lsusb -v > /dev/null | grep -e "Apple Inc" | grep iSerial)
echo "This is the UDID of your device"
echo "${UDID}"

exit
