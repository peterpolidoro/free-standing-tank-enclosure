# Native pilot review — 2026-10-21

The command-line STEP → IPT → IAM pilot passed on Windows and its exported
placements pass FreeCAD 1.1.3 checks. The full enclosure remains outside the Git
baseline pending focused checks of two components.

## What passed

- Windows: 23 pilot checks; 19 on rerun. Imported panel saved/reopened as a
  converted IPT without STEP references; two named occurrences saved/reopened;
  unconstrained and compatible constrained moves persisted; an incompatible move
  was reported as not achieved without removing the flush constraint. IPT bytes
  remained unchanged. Hidden Inventor ran in a logged-in desktop, not a service.
- Linux: pilot STEP SHA-256 matches the placement report; two valid solids with
  panel dimensions 1193.8 × 3.175 × 1193.8 mm and volume 4291598.524273579 mm³ each.
  A is at identity; B is translated (101.6, 25.4, 0) mm; both match the report
  within 0.000001 mm. No final overlap. This checks geometry, not native constraints.
- Windows: same-size wrong-cache file rejected with no acquisition entry or file change.
- Linux: all 44 exporter input records match acquisition and inventory IDs, paths
  and hashes, and all 43 dependency hashes match. Verified export SHA-256 is
  `f5efa34104afca0338828edb9891a77550a2f28c609d87dfe05b0d3487070b46`.
  Its STEP DATA section is byte-identical to the earlier export; only the header
  timestamp differs. Earlier FreeCAD geometry results therefore apply to it.
- The 34 portable tests pass in the managed Guix environment. A disposable import
  retains all 44 native-input and 43 dependency records; reimport changes nothing.

## Enclosure decision

The 503-to-479 body-count difference is accounted for: eight occurrences of
`MCMASTER 47065T245.ipt` each contain three hidden solid bodies. Both native and
STEP contain 155 leaf occurrences and 479 body-visible solids. Native/STEP
Inventor bounds agree closely. The comparison groups by basename; no basename
collisions or invisible leaves were found in these records, but inherited
assembly visibility is not separately proven.

The global volume delta does not consist solely of those hidden bodies. Other
component differences partly offset it:

| Part | Native cm³ per occurrence | STEP cm³ per occurrence | Change |
| --- | ---: | ---: | ---: |
| MCMASTER 5537T429_T-Slotted Framing | 25.864430 | 29.045500 | +12.30% |
| MCMASTER 5537T293_T-Slotted Framing | 16.581075 | 17.984526 | +8.46% |

Default mass-property accuracy, overrides, intersecting bodies and actual surface
changes need to be distinguished. Matching counts and outer dimensions do not
settle that question. Request native/STEP per-body measurements at explicit high
accuracy and local-frame STEP exports of these two parts before deciding whether
anything needs repair. Do not infer a missing component or corruption solely from
these volume differences.

FreeCAD's optimal enclosure bounds remain 1301.750 × 2608.925 × 1301.750 mm;
Inventor's face-box union remains about 1.445 mm larger along Y. Conservative
curved-face bounds are a possible explanation, not a proven clearance tolerance.
No model has been qualified for manufacturing clearances, physical stock or a
feasible assembly sequence.

The 21,617,953-byte full assembly stays in shared evidence while per-part STEP
plus an occurrence manifest is developed. Do not commit both timestamp-only
exports. Distinct part/configuration variants, not solid count or all 44 native
files, should drive reusable geometry assets. The native snapshot contains 37
leaf part documents; configuration variants may increase the asset count.

## Code and next work

Reviewed Windows scripts were integrated into the Linux tools checkout. Linux
strengthened receipt joins and the pilot's changed-input guard and added an
offline PowerShell regression script. Those additional PowerShell changes need
Windows execution; the portable Python suite does not exercise Autodesk/PowerShell.
The comparison remains diagnostic and the native pilot is a panel-specific
fixture, not a production assembly editor.

Per-part exports, the occurrence/BOM contract and a native parameter-driven
AW2725Q reference can proceed without a Vault publication destination. Imported
STEP geometry alone does not establish compliance with the manager's requirement
to design in Inventor. Vault upload and dependency-aware native check-in remain
unimplemented and no Vault writes occurred.

Raw Windows evidence: `vault-cad-exchange/evidence/2026-10-21-windows-native-pilot-01/`.
Linux evidence and handoffs: `vault-cad-exchange/evidence/2026-10-21-linux-native-review-01/`.
Machine-readable values: [review JSON](2026-10-21-native-pilot-review.json).
