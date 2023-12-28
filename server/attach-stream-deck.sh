#!/bin/bash

DEVICE_ID="0fd9:0080"

# Wait a moment to ensure usbipd is fully up
sleep 1

BUSID=$(usbip list -l | grep -B 2 ${DEVICE_ID} | awk '/busid/ {print $3}')

if [ -z "$BUSID" ]; then
    echo "Device not found."
    exit 1
fi

usbip attach -b $BUSID
echo "Device attached with busid $BUSID."