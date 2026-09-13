# optiboot for the Melzi ATmega1284P

`optiboot_atmega1284p.hex` is the unmodified 16 MHz, 115200 baud optiboot
build from the Sanguino core:

- https://github.com/Lauszus/Sanguino/blob/master/bootloaders/optiboot/optiboot_atmega1284p.hex
- last changed in commit `60fbbcf5eaa8ee9167051877b00fb02546c1ba97`
- sha256 `83e8bcac3e177aa47b4fdbff8a5da66cb107e762a721093bb444ebcca130ea00`

It occupies the top 1 KB of flash (0x1FC00). The matching fuses, from the same
repository's `boards.txt`, are lfuse 0xFF, hfuse 0xDE, efuse 0xFD; they are
applied by `scripts/isp.sh bootloader`.
