# CR-10 Refurbishment & Commissioning Checklist

> Commissioning record, kept for the measurements attached to each item.
> Open work lives in [TODO.md](TODO.md), not here.

**Machine config:** Creality CR-10, 12 V system, separate bed PSU switched through a bare logic-level N-channel MOSFET module (heatsinked), inter-PSU ground bond. Recently dropped; dormant >1 year.

**Standing rule:** all inspection, reseating, and motor/driver swaps happen with **both PSUs unplugged from mains**. The drop occurred cold, so the pulled stepper connector poses no flyback risk — but the no-hot-plug rule still governs any test-swaps you do later. Treat exposed AC terminals as live even when unplugged.

**Tools:** multimeter (continuity + DC V), hex keys, crimp/ferrule tool, IPA, PTFE or lithium grease, magnifier.

---

## Phase 0 — Prep (powered off)

- [x] Confirm both PSUs unplugged; nothing energized. ✅ 2026-09-08
- [x] Photograph the bed-PSU mod wiring and every connector you intend to reseat **before** disturbing anything, as a reference. ✅ 2026-09-08

## Phase 1 — Drop-damage inspection (powered off)

- [x] **Pulled stepper connector:** inspect shell, all 4 pins crimped and fully seated, no wire backed out of its crimp. ✅ 2026-09-09
- [x] If any crimp/pin disturbed: verify coil pairing with the meter — two wires of one coil read a few ohms, across coils reads open. Reassemble each pair into its original two positions; rule out a split pair (stalls the motor). ✅ 2026-09-09
- [x] Match connector orientation against the other three axis connectors on the board. ✅ 2026-09-09
- [x] Reseat the stepper connector fully. ✅ 2026-09-09
- [x] **Yanked endstop:** reseat both ends; confirm the 3-pin didn't go back reversed (cross-check vs the other two endstops). ✅ 2026-09-09
- [x] Check the endstop bracket didn't shift its trigger point in the yank. ✅ 2026-09-09
- [x] Continuity through a full actuate/release cycle; clean NO/NC transition. ✅ 2026-09-11
- [x] **Strained harness (drop):** inspect strain reliefs and all connectors for partial back-out. ✅ 2026-09-09
- [x] Continuity **under flex** on suspect runs (bed harness at the Y bend, hotend harness at the gantry) to catch internal breaks. ✅ 2026-09-09
- [x] Inspect mainboard heavy terminals (PSU input, heater terminals, large connectors) under magnification for cracked solder — the drop levers these joints. ✅ 2026-09-09
- [x] Reseat all remaining connectors; confirm none are half-pinned. ✅ 2026-09-09

## Phase 2 — Bed-PSU mod safety (powered off, fire-critical)

- [x] **Dropped PSU AC side:** L / N / earth screws tight, earth bonded to chassis, no pulled strands. ✅ 2026-09-09
- [x] **Inter-PSU bond:** confirm it is negative-to-negative by tracing terminals, not just continuity. Rule out a positive-to-positive bond (backfeed / supplies fighting). ✅ 2026-09-09
- [x] Confirm the mainboard bed-output ground shares that same ground domain. ✅ 2026-09-09
- [x] If any inter-PSU connection is on the AC-input side (shared mains), note it's separate and fine — don't conflate with the DC ground bond. ✅ 2026-09-09
- [x] **MOSFET module:** heatsink attached with thermal contact (paste/pad, not dry), terminals tight, no cracked PCB or lifted pads. ✅ 2026-09-09
- [x] Read the MOSFET part number; check Vds / continuous Id (derated, not marketing peak) / Rds(on) against the bed load. Cheap boards over-spec. ✅ 2026-09-09
- [x] Confirm high-current traces are solder-reinforced; reflow extra solder if bare. ✅ 2026-09-09
- [x] Confirm a gate pulldown resistor is present (missing pulldown → floating gate at boot → possible momentary bed-on). ✅ 2026-09-09
- [x] **High-current load wiring** (PSU → MOSFET → bed): ≥14 AWG, 12 AWG preferred (the bed is the bulk of the 12 V load); ferruled crimps, no nicked strands at the dropped connector. ✅ 2026-09-09
- [x] Bed power connector not discoloured or melted. ✅ 2026-09-09
- [x] **Thermistor wiring to mainboard intact** — keeps firmware PID and protection in authority over the bed. ✅ 2026-09-09
- [x] **Bed thermal fuse present?** A MOSFET fails *shorted*; firmware zeroing the gate command cannot stop a shorted switch. A ~120 °C thermal fuse in series with the heater (or gating PSU#2 / a contactor off PS_ON) is the only protection. Add one if absent. ✅ 2026-09-09
- [x] Firmware: confirm `THERMAL_PROTECTION_HOTEND` and `THERMAL_PROTECTION_BED` are compiled in (early CR-10 shipped with them disabled). Reflash current Marlin if unsure. ✅ 2026-09-15 — stock 1.0.0 had neither, nor any `M112` handler; now Marlin 2.1.2.8, `M115` reports both.

## Phase 3 — Mechanical inspection & maintenance (powered off)

- [x] Frame and gantry bolts tight; frame square. ✅ 2026-09-09
- [x] **Belts** (X, Y; GT2 6 mm): taut, teeth not stripped. Tension is set by motor/idler position (no stock tensioner). ✅ 2026-09-09
- [x] **V-wheels / eccentric nuts** (X carriage, Y bed, Z gantry): slight rolling resistance, zero play; bed doesn't rock. Inspect POM wheels for flats / embedded debris. ✅ 2026-09-09
- [x] **Z lead screw** (single): spin and watch the top for wobble (bent → Z banding); check coupler alignment. ✅ 2026-09-09
- [x] Clean old grease off the lead screw, re-lube lightly (PTFE/lithium); check brass / anti-backlash nut. ✅ 2026-09-09
- [x] **Extruder:** inspect the plastic arm for cracks (replace with aluminum if cracked); clean hobbed-gear teeth; grub screw tight on shaft; idler spring intact. ✅ 2026-09-09
- [x] **Hotend / Bowden:** pull the PTFE tube, inspect ends for deformation/burning (the press-fit coupler gap is the classic clog point); trim square or replace. ✅ 2026-09-09
- [x] Inspect heater block for a leaking nozzle / blob; confirm nozzle, heater cartridge, and thermistor set screws seated. ✅ 2026-09-09
- [x] Bed surface: glass chips; stock springs are soft (stiffer springs / solid standoffs reduce level drift — optional). ✅ 2026-09-09
- [x] Fans (PSU, hotend, part-cooling): spin freely, no debris. ✅ 2026-09-09

## Phase 4 — Cleaning (powered off)

- [x] Dust electronics and all fan intakes. ✅ 2026-09-09
- [x] Wipe extrusions and V-wheel contact surfaces. ✅ 2026-09-09
- [x] Clean glass with IPA to restore adhesion. ✅ 2026-09-09

## Phase 5 — Staged power-on (hand on kill switch)

- [x] Confirm AC-input voltage selector on both PSUs = 230 V (Thailand). ✅ 2026-09-09
- [x] **Bed disconnected:** power each PSU, measure output ≈ 12.0 V, stable. ✅ 2026-09-09
- [x] Mainboard: display comes up, no smell/smoke. ✅ 2026-09-09
- [x] Endstops: `M119`, hand-actuate each (especially the yanked one and any previously sticky); confirm clean transition. ✅ 2026-09-11
- [x] **Per-axis manual jog a few mm BEFORE homing** — confirm direction. A reversed coil pair drives the axis into the far end on `G28`. ✅ 2026-09-11
- [x] Home each axis individually, then `G28`; confirm it stops at the switch with no crash. ✅ 2026-09-11
- [x] Motion accuracy: jog a known distance, measure actual travel. ✅ 2026-09-11
- [x] Hotend thermal: heat to ~200 °C, watch the graph for stable control (no oscillation/runaway). *(Optional: cold/atomic pull now to clear a partial clog.)* ✅ 2026-09-11
- [x] Bed thermal: reconnect bed, heat to a **low setpoint (~50 °C) first**; confirm the MOSFET switches ON, the board holds, then commands OFF (verify it de-energizes). ✅ 2026-09-17 — the de-energize half was wrongly marked done on 09-11. It failed: the bed heated whenever powered, commanded or not. The clearest instance, with the replacement module, was a reversed DC input putting current through the body diode; corrected, it now passes. An earlier instance on 09-11, with the original module and before that reversal existed, is unexplained.
- [x] Measure MOSFET case temp under sustained bed load; >60–70 °C = undersized, derate or replace. ✅ 2026-09-17 — 50 °C, dropping 0.137 V at ~6 A. Earlier readings of 100–139 °C were all taken through the reversed supply.
- [x] Confirm `M112` drops both heaters. ✅ 2026-09-15 — halts the board; needs `EMERGENCY_PARSER`, which stock firmware lacked entirely.

## Phase 6 — Calibration

- [x] PID tune hotend (`M303 E0`), bed if PID-controlled; `M500` to save. ✅ 2026-09-15 — hotend `M301 P20.06 I1.67 D60.40` at 240 °C with the part fan at 100%. Bed still on Marlin defaults and holds setpoint; retune once the MKS MOS25 is fitted.
- [x] E-steps: extrude 100 mm, measure, set `M92`, `M500`. ✅ 2026-09-16 — `M92 E97.42`, from Marlin's default 95.
- [x] Bed level: manual 4-corner + center; set Z offset / first-layer height. ✅ 2026-09-16 — Z endstop bracket reset with the glass in place; LCD bed tramming for the corners. First layer confirms the one-sheet paper gap is right for PETG.

## Phase 7 — Test prints

- [x] First-layer / bed-level pattern. ✅ 2026-09-17 — five-pad test, `~/projects/cr10/models/`. All five adhered, skirt even the whole way round. Only defects are black PLA shedding from the hotend.
