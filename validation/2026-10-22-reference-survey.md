# Enclosure dimensional and inventory review, 2026-10-22

FreeCAD 1.1.3 read the 37 accepted STEP assets, normalized their dimensions to mm,
composed all 155 placements and checked the supplied world transforms. The result
contains 479 solids and 17 group envelopes. Every original payload hash passed.
The native Y-up basis was applied once as `(x,y,z) -> (x,-z,y)`; the model origin
is unchanged. Z values below are model coordinates, not heights above the floor.
Source scene SHA-256: `ac203e5656abdeeadbadf5f047e31f244e01f8938001c5747a44808ffc4ed070`.

## A tank is represented twice at the same placement

The root `SHULZE 2W.353 TANK:1` and
`TANK SUPPORT FRAME:1/SHULZE 2W.353 TANK:1` use the same part/asset and practically
identical transforms. Maximum translation difference is `6.82e-13 mm`; maximum
rotation-matrix difference is `6.13e-17`. Both are visible and classified Normal.
There is also a tank in the lower support frame, at another height. Thus the raw
count is three, while two occurrences coincide. Preserve the source and ask for
native BOM/configuration review before deciding intended or purchased quantities.
The survey found one same-part pair within `1e-6 mm` translation and `1e-8`
rotation-element tolerances. It is not a general collision analysis.

## Useful nominal envelopes

| Item | X × Y footprint (mm) | Z range (mm) |
| --- | --- | --- |
| Entire modeled enclosure, including handles | 1301.75 × 1301.75 | -91.15 to 2517.78 |
| Lower tank support platform | 1079.50 × 1079.50 | 488.91 to 501.61 |
| Upper tank support platform | 1079.50 × 1079.50 | 808.85 to 821.55 |
| Upper tank, including coincident instance | 990.60 × 990.60 | 821.55 to 904.10 |
| Enclosure top panel | 1193.80 × 1193.80 | 2514.60 to 2517.78 |

Bounds use exact-shape optimal axis-aligned boxes, not an accumulated tessellation
box. They can differ from earlier conservative FreeCAD bounds. The top panel is
at the top of the tall enclosure; it is not automatically the monitor-cover sheet.

Two horizontal AW2725Q nominal body envelopes give:

| Arrangement, with zero gap | Footprint (mm) | Comparison with a 1079.5 mm square platform |
| --- | --- | --- |
| Side-by-side landscape | 1219.02 × 355.97 | Exceeds one side by 139.52 mm |
| Front-to-back landscape | 609.51 × 711.94 | Inside the nominal rectangle; total unused spans 469.99 × 367.56 mm |

The bodies are 72.63 mm deep. These are layout screens, not mounting designs or
clearance approvals: they omit gaps, rear contours, brackets, cables, ventilation,
removal paths, support loads and tolerances. Side-by-side also exceeds the top
panel's width by 25.22 mm, but the relevant support/acrylic design remains undecided.

Six nominal 160 mm bowls in a 3 × 2 pattern require 480 × 320 mm before gaps.
The active screen is 589.97 × 332.93 mm, leaving only 12.93 mm total along the short
axis for all gaps and margins. Confirm whether 160 mm includes the rim and what
must lie over the active display before ordering or tooling the bowls.

## Completeness and next decisions

The [stock/completeness audit](../assembly/procurement/README.md) records all 37
modeled part types and 20 candidate reviews. Caster, handle and clamp groups have
no separate mounting-fastener entries, but compound purchased components and kit
contents require inspection before calling hardware missing. The snapshot does
include two shoulder screws and eight oversized washers. Counts are CAD evidence,
not a statement of physical stock or purchasing requirements.

Compact machine-readable results: [survey JSON](2026-10-22-reference-survey.json).
Reproduction: `assembly/survey_reference.py`. Full per-occurrence evidence is in
`vault-cad-exchange/evidence/2026-10-22-linux-project-preparation-01/survey.json`.
No native design, Vault contents or frozen reference geometry was modified.
