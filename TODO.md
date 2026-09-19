# CR-10 — next session

Machine prints. Bed regulates, calibration done bar the bed PID, first-layer test clean.
DC IN lugs re-terminated and verified 2026-09-19: bed to 70, all four lugs peaked ~49 within
5 °C of each other, FET heatsink 55, bed-plug solder joints 58 — the warmest point in the
circuit now — all falling once regulating, and nothing above 50 through the hour-plus the bed
then held 70 during the cold pull.
Hotend 2026-09-19: black plug removed from the PTFE tube; tube end judged fine and not cut;
tube refitted hot and bottomed on the nozzle; three `G1 E30 F150` gray and glossy, a few small
bubbles remaining.
Background and all measured values: `~/.claude/knowledge/projects/cr10.md`.

## 1. Test prints

Calibration cube first, then a Benchy. The cube is also the test of the hotend hypothesis:
no black specks in it, and the tube plug was the source.

Bubbles: a few small ones persisted through ~90 mm of extrusion after the tube was refitted,
so the open-hotend-air explanation is weaker. Before the cube, read the filament container's
hygrometer — under ~35% RH means the silica gel is working; ambient means it is spent. If
the cube strings or its surface is rough, dry the spool (65 °C, 4–6 h) before the Benchy.

Glue stick on cool glass, covering the whole footprint including the left-edge strip where
the prime line runs. Keep clips off the corners and off the left and right edges. Centre of
the plate has a chip; avoid it or use `models/first_layer_test_offcentre.stl` as the pattern.

## 2. Bed power — settled

**~150 ± 50 W, 11–17 A at 11.25 V, 0.65–1.0 Ω.** The 1.8 Ω in the record is wrong.

From the one clean run, 2026-09-17 11:03–11:07: replacement module, polarity corrected,
FET saturated, 0.13 V across it, 11.25 V at the bed; **46 → 63 °C in ~3:40** by message
timestamps, ~0.077 K/s at ΔT ≈ 24 K. Plate and glass 1.2–1.5 kJ/K, still-air losses
45–70 W at that ΔT, so gross 140–185 W. A 70 W bed would net 1–24 W against those losses
and take a quarter of an hour over that span. Vendor spec for this bed is 220 W / 18 A /
≈0.65 Ω; the measurement sits on it.

The earlier evidence, in sequence, and why none of it overrode this:
- 2026-09-10, **1.8 Ω**: raw DMM reading, lead zeroing and probe location never stated.
- 2026-09-16, original module with its open terminal block, lug at 140–150: 59 → 64 in
  1:48, overshoot to 73. Bed voltage never measured; a joint at 150 °C is dropping real
  voltage, so this run under-reads the bed. It came out ~115–160 W gross, lower than the
  clean run, as it should.
- 2026-09-17 morning, replacement module reversed: body diode in the loop, no power
  information in it.

**Why the second PSU is there:** this is an 18 A-class bed. On the stock 30 A supply with
hotend and steppers that is 75–85% loaded, and the Melzi's own bed terminal is the
documented burn point at this current. Own supply plus external switch is the ordinary fix
for both. It applies to this machine; keep it.

**What it does not give you:** 24 V on the bed, which is the version of this mod with a
real payoff (heat-up in minutes rather than ~10). That needs 10 AWG and a 40 A-class
switch — a separate project, and nothing about the present wiring survives it.

Residual, no test required: read the label on the bed PSU when the case is open, and
record it. Its rating was never written down.

## 3. Bed PID tune

Still on Marlin defaults. It holds setpoint, so this is polish. `MAX_BED_POWER` is 255,
so nothing is capping bed duty. Independent of the MOS25 — do not wait for it.

## Waiting on parts

- **MKS MOS25** ordered. An upgrade, not a fix: the clone measures 0.137 V and 50 °C once
  wired correctly. Fit it when it lands. Bed current is 11–17 A (§2); the MOS25 is a 25 A
  part by name — confirm the rating on the board before fitting.
- **Ferrule crimper** ordered. Nothing needs it; the module takes lugs, not ferrules.
- Considered, not ordered: textured PEI spring steel with magnetic base, ~฿900, which is the
  right surface for PETG and would end the glass chipping.
- Considered, not started: **24 V on the bed.** The version of the second-PSU mod with a
  real payoff — heat-up in a few minutes rather than ~10, and 80 °C within reach. Two 12 V
  supplies in series into the bed only, external switch stays in the negative leg (the
  clone's PC817 input is isolated, so the stack can float). Not a drop-in: ~37 A full-on on
  this bed, so 10 AWG on the run, a 40 A-class switch (not the MOS25), `MAX_BED_POWER`
  back to ~128 or accept the inrush, and the negative-to-negative bond between the supplies
  has to go. Decide after a few prints whether the heat-up actually bothers you.
- Considered, not ordered: bed insulation mat (cork or foil-faced) under the plate. Cheap,
  no electrical risk, cuts heat-up time and holding duty. Check whether one is already
  fitted before buying.

## Standing

Do not leave it running unattended yet. The hotend and both thermistors are validated. The
bed circuit has now had, with correct polarity: a ~20-minute soak at 70 during the 09-17
first-layer test (old DC IN lugs, 70–90 °C), and the 09-19 verification run with all four
terminations fresh and cool. Watch one full-length print — the cube — and that condition is
discharged.

**No bed thermal fuse.** Decided 2026-09-19: not going to fit one, not going to check for
one. The mitigation is attendance, and the one failure of this class that occurred — the
reversed DC input, which heated the bed whenever the machine had power, commanded or not —
was in fact caught that way. Settled; do not re-raise.

The uncommanded heating was a wiring error and is cured, demonstrated rather than assumed:
full supply across the device when commanded off, device at ambient, bed flat. One earlier
observation stays unexplained: 2026-09-11, original module, bed commanded off at 73 and read
77 then 83. That module's input polarity was never observed, so the same reversal would
account for it; the wiring was redone when it was replaced and it cannot now be tested. The
full-length attended print is what stands in for it.
