#!/bin/sh
# Build Marlin for the CR-10 Melzi board with the optiboot memory layout.
# Copies this repo's configuration into the Marlin submodule, runs PlatformIO,
# and leaves the result at build/firmware.hex.
set -eu
cd "$(dirname "$0")/.."
cp config/Configuration.h config/Configuration_adv.h config/_Bootscreen.h config/_Statusscreen.h Marlin/Marlin/
(cd Marlin && pio run -e melzi_optiboot)
mkdir -p build
cp Marlin/.pio/build/melzi_optiboot/firmware.hex build/firmware.hex
echo "built build/firmware.hex"
