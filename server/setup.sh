install -m 755 ./attach-stream-deck.sh /usr/local/bin/attach-stream-deck.sh
install -m 755 ./detach-stream-deck.sh /usr/local/bin/detach-stream-deck.sh

install -m 600 ./attach-stream-deck.service /etc/systemd/system/attach-stream-deck.service
install -m 600 ./attach-stream-deck.service /etc/systemd/system/usbipd.service
