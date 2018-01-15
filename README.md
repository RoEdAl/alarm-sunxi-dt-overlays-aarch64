# Arch Linux ARM - Device Tree overlays for sunxi devices (64-bit)

My try to bring idea of additional [DT overlays](http://github.com/armbian/sunxi-DT-overlays) from Armbian to Arch Linux.
Requires bootloader ready to apply DT overlays - see [this](http://github.com/RoEdAl/alarm-sun50i-h5) repository.

Currently only `sun50i-h5-...` DT overlays are supported/packaged.
User provided DT overlays are not supported.

The idea is very simple.
To enable, say additional USB port just install `sun50i-h5-dto-usbport2` package (for OrangePi Zero Plus) and reboot.
If you want audio codec just install `sun50i-h5-dto-analog-codec` package and reboot etc.
The `/boot/overlays.txt` config file is updated by simple post-install hook (shell script).

See [boot.txt](http://github.com/RoEdAl/alarm-sun50i-h5/blob/master/uboot/boot.txt) U-Boot script.

All `sun50i-h5-dto-...` packages requires `sunxi-dt-overlays-toolkit` and `sun50i-h5-dt-overlays` ones.

