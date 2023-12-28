#!/bin/bash

if [ $(/usr/bin/id -u) -ne 0 ]; then
    echo "Not running as root"
    exit
fi

install -m 755 ./bind-stream-deck.sh /usr/local/bin/bind-stream-deck.sh
install -m 755 ./unbind-stream-deck.sh /usr/local/bin/unbind-stream-deck.sh

install -m 600 ./bind-stream-deck.service /etc/systemd/system/bind-stream-deck.service
install -m 600 ./usbipd.service /etc/systemd/system/usbipd.service
