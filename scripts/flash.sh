#!/bin/sh
# Flash build/firmware.hex over the printer's USB port through the optiboot
# bootloader. PORT overrides the serial device; default is the first
# usbserial device found.
set -eu
cd "$(dirname "$0")/.."
PORT=${PORT:-$(ls /dev/tty.usbserial-* /dev/ttyUSB* 2>/dev/null | head -1)}
[ -n "$PORT" ] || { echo "no serial port found; set PORT" >&2; exit 1; }
avrdude -c arduino -p m1284p -P "$PORT" -b 115200 -D -U flash:w:build/firmware.hex:i
