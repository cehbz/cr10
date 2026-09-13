#!/bin/sh
# In-system programming of the Melzi's ATmega1284P through an FT232H on the
# 6-pin ISP header. Needed once, to burn a bootloader onto a board that
# shipped without one; afterwards scripts/flash.sh works over USB.
#
#   scripts/isp.sh probe       read the device signature, write nothing
#   scripts/isp.sh backup      save the current flash and EEPROM to backup/
#   scripts/isp.sh bootloader  chip erase, set fuses, write optiboot, lock boot section
#
# PROG selects the avrdude programmer (default ft232h). Wiring is in README.md.
# On macOS, avrdude may need sudo to take the FT232H from the Apple FTDI driver.
set -eu
cd "$(dirname "$0")/.."
PROG=${PROG:-ft232h}
MCU=m1284p
case "${1:-}" in
  probe)
    avrdude -c "$PROG" -p $MCU -B 10 -n -v ;;
  backup)
    mkdir -p backup
    avrdude -c "$PROG" -p $MCU -B 4 \
      -U flash:r:backup/stock_flash.hex:i -U eeprom:r:backup/stock_eeprom.hex:i ;;
  bootloader)
    # Fuses per Sanguino boards.txt for ATmega1284P @ 16 MHz with optiboot:
    # lfuse 0xFF external crystal, hfuse 0xDE 1 KB boot section + BOOTRST, efuse 0xFD BOD 2.7 V.
    avrdude -c "$PROG" -p $MCU -B 10 -e \
      -U lock:w:0x3F:m -U lfuse:w:0xFF:m -U hfuse:w:0xDE:m -U efuse:w:0xFD:m
    avrdude -c "$PROG" -p $MCU -B 4 \
      -U flash:w:boot/optiboot_atmega1284p.hex:i -U lock:w:0x0F:m ;;
  *)
    echo "usage: $0 probe|backup|bootloader" >&2; exit 2 ;;
esac
