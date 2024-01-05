#!/bin/bash

DEVICE_ID="0fd9:0080"

echo "Searching for device with id ${DEVICE_ID}..."

BUS_ID=$(usbip list -l | grep -B 2 ${DEVICE_ID} | awk '/busid/ {print $3}')

if [ -z "${BUS_ID}" ]; then
    echo "Device not found"
    exit 1
fi

echo "Unbding device with busid ${BUS_ID}..."

usbip unbind -b ${BUS_ID}
echo "Device attached with busid ${BUS_ID}."