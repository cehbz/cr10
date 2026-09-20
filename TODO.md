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

Retraction tuning on a wet spool is wasted; §2 waits on this.

## 2. First case, on the dry spool

The profile `Tuned, PETG, Claude` is complete and saved (every override and its reason:
`~/.claude/knowledge/projects/cr10.md`, Slicing). The retraction and coasting rows in it were
set on a wet spool and have not been judged. The first case print is the judge: stringing
between features, zits at wall ends, and whether the −0.2 first-layer expansion leaves the
base square enough for a lid.

Residual, no test required: read the label on the bed PSU when the case is open, and record
it in the observations log. Its rating was never written down.

## 3. Bed PID tune

Still on Marlin defaults. It holds setpoint, so this is polish. `MAX_BED_POWER` is 255,
so nothing is capping bed duty. Independent of the MOS25 — do not wait for it.

## Waiting on parts

- **MKS MOS25** ordered. An upgrade, not a fix: the clone measures 0.137 V and 50 °C once
  wired correctly. Fit it when it lands. Bed current is 11–17 A; the MOS25 is a 25 A
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
