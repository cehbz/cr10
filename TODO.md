# CR-10 — next session

Machine prints. Cube within 0.5 % on all axes; Benchy completed 2026-09-20 with the recessed
lettering intact on a 0.3 mm / 120 % width / 105 % flow / 240 °C first layer at bed 75.
Remaining defect is heavy stringing and zits, and the filament is wet: 78 % RH in the
container after a night sealed. Background and all measured values:
`~/.claude/knowledge/projects/cr10.md`; history `~/.claude/knowledge/projects/cr10/observations.md`.

## 1. Dry the filament

The container's silica gel is spent. Fresh sealed packets: outer plastic wrapper off, sachet
closed, into the box. Then the spool: **on the printer bed at 60 °C, hotend off, cardboard box
over it, 4–6 h.** The bed PID holds to a degree; the spool label's ceiling is 70 and the oven
can't be trusted under it. IR on the spool after the first hour. Back into the box with the
fresh gel; the hygrometer should read under ~35 % by the next morning.

Retraction tuning on a wet spool is wasted; nothing in §2's second block until this is done.

## 2. Cura

**Save what worked.** The attempt-4 first-layer settings are unsaved overrides (Cura keeps
them in `user/*.inst.cfg`, so they survive restarts, but not a profile switch). Update the
`Tuned, PETG, Claude` profile with them: initial layer height 0.3, initial layer line width
120 %, initial layer flow 105 %, printing temperature initial layer 240, top/bottom line
directions `[90]`, build plate temperature 75.

**For the cases:** Initial Layer Horizontal Expansion −0.2. The fat first layer leaves a
slight foot; on a case that is what makes a lid bind. First-layer only, adhesion untouched.

**Stringing and zits, after §1:** retraction distance 6.5 (ceiling 7), retraction speed 40,
retraction minimum travel 0.8, printing temperature 230, Enable Coasting on, Retract Before
Outer Wall on. Z hop stays off. Judge on a second Benchy or the first case.

## 3. Bed power — settled

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

## 4. Bed PID tune

Still on Marlin defaults. It holds setpoint, so this is polish. `MAX_BED_POWER` is 255,
so nothing is capping bed duty. Independent of the MOS25 — do not wait for it.

## Waiting on parts

- **MKS MOS25** ordered. An upgrade, not a fix: the clone measures 0.137 V and 50 °C once
  wired correctly. Fit it when it lands. Bed current is 11–17 A (§3); the MOS25 is a 25 A
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

The full-length attended print has happened: the Benchy ran over an hour at bed 75 with
correct polarity and all four module terminations fresh, and nothing in the bed circuit ran
warm. The condition that gated unattended running is discharged. Whether to leave it running
— drying on the bed is hours of bed-only at 60 — is your call, not a rule.

**No bed thermal fuse.** Decided 2026-09-19: not going to fit one, not going to check for
one. The mitigation is attendance, and the one failure of this class that occurred — the
reversed DC input, which heated the bed whenever the machine had power, commanded or not —
was in fact caught that way. Settled; do not re-raise.

The uncommanded heating was a wiring error and is cured, demonstrated rather than assumed:
full supply across the device when commanded off, device at ambient, bed flat. One earlier
observation stays unexplained: 2026-09-11, original module, bed commanded off at 73 and read
77 then 83. That module's input polarity was never observed, so the same reversal would
account for it; the wiring was redone when it was replaced and it cannot now be tested.
