#!/bin/bash

DEVICE_NAME="Elgato Systems GmbH Stream Deck"

# Wait a moment to ensure usbipd is fully up
sleep 5

BUSID=$(usbip list -l | grep -B 2 "$DEVICE_NAME" | grep -oP 'busid\s+\K(\S+)')

if [ -z "$BUSID" ]; then
    echo "Device not found."
    exit 1
fi

usbip detach -b $BUSID
echo "Device attached with busid $BUSID."