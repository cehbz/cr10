# CR-10 refurbishment

Notes and firmware for a used 2017 Creality CR-10: 12 V, the original
Creality Melzi board (ATmega1284P, FT232R USB serial, no bootloader as
shipped), stock 12864 display, and an owner-added second power supply
feeding the bed through an external MOSFET module.

## Firmware

The board shipped with Creality's Marlin 1.0.0 build from October 2017. That
build has no thermal runaway protection and no `M112` handler; its published
source is at https://github.com/Creality3DPrinting/CR10-Melzi-1.1.2.

This repo builds Marlin 2.1.2.8 for it.

- `Marlin/` is the upstream Marlin repository as a submodule, pinned to the
  2.1.2.8 tag.
- `config/` is Marlin's own CR-10 example configuration
  (`config/examples/Creality/CR-10/CrealityV1` from the Configurations repo
  at `release-2.1.2.8`) with one change: `EMERGENCY_PARSER` enabled in
  `Configuration_adv.h`, so `M112` is acted on immediately rather than queued.
  Thermal protection for hotend and bed is on in the example config.
- `boot/` is the optiboot bootloader the build assumes; see `boot/README.md`.

Build (needs PlatformIO):

```
git clone --recurse-submodules --shallow-submodules <this repo>
scripts/build.sh
```

The result is `build/firmware.hex`. It uses about 97% of flash and 93% of
RAM, which is normal for Marlin 2 on this processor.

### One-time: bootloader over ISP

Because the board has no bootloader, the first flash goes through the 6-pin
ISP header next to the processor, using an FT232H breakout as the
programmer (avrdude's `ft232h` definition; the FT232H's inputs are 5 V
tolerant, so no level shifting). Pin 1 of the header has a square pad.

```
ISP header            FT232H
1 MISO  2 VCC         AD2 -> pin 1
3 SCK   4 MOSI        AD0 -> pin 3
5 RESET 6 GND         AD1 -> pin 4
                      AD3 -> pin 5
                      GND -> pin 6
```

Pin 2 stays unconnected: the printer's own supply powers the board during
programming. With the printer on and the FT232H plugged in:

```
scripts/isp.sh probe        # expect Device signature = 0x1e9705
scripts/isp.sh backup       # stock flash + EEPROM to backup/ (kept out of git)
scripts/isp.sh bootloader   # erase, fuses, optiboot
```

On macOS, avrdude may need `sudo` to claim the FT232H from Apple's FTDI
driver. After this step the display is blank until firmware is flashed.

### Flashing over USB

With the bootloader in place, every flash is over the printer's USB port:

```
scripts/flash.sh            # PORT=/dev/tty.usbserial-XXXX to override
```

Stock firmware talked at 115200 baud; so does this build. After a reflash
the EEPROM is reset, so PID and E-steps need redoing and saving with `M500`.

## Hardware findings from the checkout

Recorded here because they are the kind of thing the next owner of a
machine like this needs to know.

- Both power supplies had been trimmed off nominal: the mainboard supply to
  14.4 V and the bed supply to 10.8 V. Both reset to 12.0 V with the pot
  next to the terminal strip.
- The external bed MOSFET module was the common clone design: PC817
  optocoupler, HA210N06-marked MOSFET, and a resistor divider on the gate
  that leaves the gate at half the module's supply. On a 24 V machine that
  is 12 V and the part is fully on; on a 12 V machine it is about 6 V and
  the part runs hot. The heatsink reached 100 °C at under 7 A of bed
  current. Replaced with a module that has a transistor stage after the
  optocoupler.
- The bed wires were terminated with fork lugs pushed into the module's
  cage-clamp terminals. The lugs, not the terminals, discoloured and
  reached 140 °C. Cage clamps take ferrules.
- Stock endstops read `open` at rest and `TRIGGERED` pressed, with pullups
  and no inversion, so an unplugged switch is indistinguishable from an
  untriggered one; homing must be verified by pressing each switch by hand
  under `M119` before the first `G28`.
- The stock 1.0.0 firmware drives the bed in bang-bang mode as a 50% duty
  software PWM at about 7.6 Hz, not fully on, so any external module must
  tolerate PWM. Marlin 2 does the same.
