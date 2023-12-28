# Remote Stream Deck

## Manual Setup

### USB Server (Raspbian)

Connect the StreamDeck to the Raspberry Pi using a standard USB Cable.

Verify that the Stream Deck is connected:

```shell
lsusb
> Bus 003 Device 002: ID 0fd9:0080 Elgato Systems GmbH Stream Deck MK.2
```

Install the usbip package:
```shell
apt-get install usbip
```

Verify that the package is installed:

```shell
apt-cache policy usbip
> usbip:
>   Installed: 1:2.0+6.1.63-1+rpt1
>   Candidate: 1:2.0+6.1.63-1+rpt1
>   Version table:
>  *** 1:2.0+6.1.63-1+rpt1 500
>         500 http://archive.raspberrypi.com/debian bookworm/main arm64 > Packages
>         100 /var/lib/dpkg/status
```

Load the usbip_host module and make sure it survives reboots:

```shell
modprobe usbip_host
echo usbip_host >> /etc/modules-load.d/modules.conf
```

Check that the peripheral you want to share is supported:

```shell
usbip list -l
> - busid 3-1 (0fd9:0080)
>    Elgato Systems GmbH : unknown product (0fd9:0080)
```

Start a daemon to start a remote accesible session:

```shell
usbipd
```

Bind the device:

```shell
usbip bind -b <BUS_ID>
```

Test that the device is remotely accessible:

```shell
usbip list --remote 127.0.0.1
> Exportable USB devices
> ======================
>  - 127.0.0.1
>         3-1: Elgato Systems GmbH : unknown product (0fd9:0080)
>            : /sys/devices/platform/axi/1000120000.pcie/1f00300000.usb/xhci-hcd.1/usb3/3-1
>            : (Defined at Interface level) (00/00/00)
```

### USB Client (Windows)

