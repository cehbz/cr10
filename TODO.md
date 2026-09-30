# CR-10 — next session

Machine prints. Filament dried; the storage box sits at ~10 % RH with ~120 g of gel in a
printed tray. Background and measured values: `~/.claude/knowledge/projects/cr10.md`;
history `~/.claude/knowledge/projects/cr10/observations.md`.

## 1. Silent mid-print reboot

Desiccant-box attempt 2: the printer rebooted partway through the first layers with no LCD
message and no USB connected. Marlin shows a message and halts on a thermal fault, and
reports SD errors, so neither fits a silent reboot. Surviving: brownout (the bed's 11–17 A returns
through the negative-to-negative bond between the supplies), watchdog reset (RAM 15296 /
16384 B, a print of thousands of short moves), mains glitch. Not seen since.

If it recurs: start `picocom -b 115200 --imap lfcrlf --logfile <file>
/dev/tty.usbserial-A906UGE8` before the print (opening the port resets the board once,
harmless before a print), start the print from the LCD, leave it logging. The boot banner
after a reboot names the cause: Brown out / Watchdog / Power-Up.

## 2. Bed PSU label

Read the rating on the bed PSU when the case is open, and record it in the observations
log. It was never written down.

## 3. Bed PID tune

Still on Marlin defaults. It holds setpoint, so this is polish. `MAX_BED_POWER` is 255,
so nothing is capping bed duty.

## 4. Corner lift on a long floor

On the next PETG part with a floor of about 200 mm or more, observe whether a corner lifts
at bed 75 with the window closed and the fans off.

## Considered

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
