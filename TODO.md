# CR-10 — next session

Machine prints. Bed regulates, calibration done bar the bed PID, first-layer test clean.
Background and all measured values: `~/.claude/knowledge/projects/cr10.md`. Refurbishment
checklist with per-item history: `~/projects/pkm/vault/tasks/7 cr10_refurb_checklist.md`.

## 1. Re-terminate the DC IN lugs

The only original terminations left. They run 70–95 °C under the same current at which the
re-crimped bed pair runs 40 °C. Retightening the screws changed nothing.

Cut back past any discoloured copper, crimp fresh fork or ring lugs, refit under the square
washers. Blue lugs in the blue die, red in the red; whichever, tug-test each one. Not
ferrules — this is a barrier block, screws with washers, so lugs are the correct part.

Cold work, machine off. Wire is 1.5 mm², tin-plated strands, which is normal and crimps fine.

## 2. Cold pull the hotend

Black PLA from the previous owner is still shedding into the extrusion, causing specks,
blobs and brief flow stops after 430 mm of purging. Not a purge-clears-it problem.

Heat 240, draw the filament back at the extruder, free the Bowden at the hotend coupler,
inspect the tube end (the PTFE-to-nozzle joint is this hotend's known trap), feed filament by
hand until clean, cool to ~90, pull straight up with pliers. Repeat until the tip is clean.
Order PTFE if the end is belled or charred.

## 3. Verify both, one run

Bed to 70. Infrared on all four module terminals: they should now read alike. Watch the FET,
which should sit near 50. Then a short purge and check the extrudate is uniformly PETG.

Abort if any terminal runs well above the others, or anything passes 120.

## 4. Test prints

Calibration cube first — it also supplies the motion-accuracy figure, which is still
unmeasured. Then a Benchy.

Glue stick on cool glass, covering the whole footprint including the left-edge strip where
the prime line runs. Keep clips off the corners and off the left and right edges. Centre of
the plate has a chip; avoid it or use `models/first_layer_test_offcentre.stl` as the pattern.

## 5. Work out the bed power story

The bed measures 1.8 Ω and draws about 70 W, which the mainboard's own bed output could have
driven. Nothing explains why this machine has a second PSU and an external switch at all.
Either the modification was unnecessary, or one of those measurements is wrong — and the
second possibility also undermines the conclusion that 1.5 mm² wire is adequate here.

Cheap checks: re-measure the bed cold with the meter's leads shorted first and the reading
noted, and clamp the supply current during a heat-up if a clamp meter turns up. The
commissioning record is in [refurb-checklist.md](refurb-checklist.md).

## Waiting on parts

- **MKS MOS25** ordered. An upgrade, not a fix: the clone measures 0.137 V and 50 °C once
  wired correctly. Fit it when it lands. The bed PID tune does not wait on it.
- **Ferrule crimper** ordered. Nothing needs it; the module takes lugs, not ferrules.
- Considered, not ordered: textured PEI spring steel with magnetic base, ~฿900, which is the
  right surface for PETG and would end the glass chipping.

## Standing

Do not leave it running unattended yet. The hotend and both thermistors are validated. The
bed circuit is not, on two counts: one known hot joint at the DC IN lugs, and nothing has run
longer than a few minutes since the polarity was corrected. Re-terminate those lugs and watch
one full-length print, and that condition is discharged.

The uncommanded heating was a wiring error and is cured, demonstrated rather than assumed:
full supply across the device when commanded off, device at ambient, bed flat.
