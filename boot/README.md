# optiboot for the Melzi ATmega1284P

`optiboot_atmega1284p.hex` is the unmodified 16 MHz, 115200 baud optiboot
build from the Sanguino core:

- https://github.com/Lauszus/Sanguino/blob/master/bootloaders/optiboot/optiboot_atmega1284p.hex
- last changed in commit `60fbbcf5eaa8ee9167051877b00fb02546c1ba97`
- sha256 `83e8bcac3e177aa47b4fdbff8a5da66cb107e762a721093bb444ebcca130ea00`

The hex is linked at byte 0x1FC00, the top 1 KB of flash, so BOOTSZ has to
select a 512-word boot section based there. That makes the fuses lfuse 0xFF
(external crystal), hfuse 0xDC (BOOTSZ=10 plus BOOTRST), efuse 0xFD (brown-out
at 2.7 V), applied by `scripts/isp.sh bootloader`.

Note that Sanguino's `boards.txt` pairs this same hex with hfuse 0xDE, which
selects a 256-word section based at 0x1FE00. That matches neither where the hex
is linked nor that file's own `upload.maximum_size` of 130048, which reserves
1 KB. Burning 0xDE leaves the reset vector pointing at blank flash, so the
bootloader never runs. The Melzi bootloader guides use 0xDC, and Marlin's
`melzi_optiboot` environment reserves the same 1 KB.
