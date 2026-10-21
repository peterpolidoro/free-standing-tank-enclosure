# Accepted part snapshot and native authoring proof — 2026-10-21

The frozen enclosure is now available as **37 distinct STEP parts**, with **155
occurrences in 17 assembly groups including the root**, under
`references/enclosure/`. The reference lock retains source identities and
validation for every part. The earlier panel reference is preserved, so the lock
contains 38 entries. No production Vault file was changed.

## Geometry and size

All 37 parts import as valid shapes in FreeCAD 1.1.3, with solid counts matching
the visible native bodies. Reconstructed placements produce the same 479 solids,
481 shells, 24,126 faces, total volume and bounds as the acquisition-bound full
assembly STEP (`f5efa34104afca0338828edb9891a77550a2f28c609d87dfe05b0d3487070b46`).
A one-to-one comparison of solid centroids, bounds and volumes matches all 479:
maximum centroid/bounds deviations are about 1e-11 mm and volume deviation is
6.9e-8 mm³. This is strong geometric consistency evidence, not a surface-distance
or manufacturing-clearance certification. Coincident solids required comparing
bounds/volume as well as centroids to avoid arbitrary matching ties.

All 40 files listed by the export receipt match their hashes/sizes. The 37 STEP
files total **20,792,064 bytes (19.83 MiB)**; the largest is **3,914,098 bytes**.
The full 21.6 MB assembly STEP is retained in external evidence rather than added
to Git alongside the parts. Future refreshes should reuse unchanged geometry and
avoid committing timestamp-only reexports. No LFS is required for this baseline.

The source/root and all 37 part identities/hashes match acquisition. This run
records no fresh hashes for the six distinct intermediate native assembly files;
geometry reconstruction agrees with the earlier export which verified all 44
opened documents. The prototype exporter needs equivalent strict checks before
general unattended reuse; snapshot acceptance does not qualify arbitrary exports.

Flexible subassemblies matter: 44 leaf poses differ from definition poses.
The accepted scene uses actual instance positions. Parent-relative transforms
compose to supplied world transforms within 1.7e-11 mm. All are proper rigid
transforms; no suppressed/mirrored occurrences appear in this snapshot. Each
assembly occurrence remains a separate group; shared geometry is not duplicated
for every installed instance. Occurrence IDs are scoped to this snapshot.

## Native/STEP measurements and monitor

The earlier large Inventor volume deltas shrink at `k_VeryHigh` accuracy:

| Part | Native cm³ | STEP cm³ | Relative difference |
| --- | ---: | ---: | ---: |
| MCMASTER 5537T293 | 17.984225752 | 17.983827913 | 0.002212% |
| MCMASTER 5537T429 | 25.791453389 | 25.790900114 | 0.002145% |

Default integration accuracy explains the earlier 8.46%/12.30% comparison.
Per-body count/face/visibility records also agree. Some body volume calls and
transient overlap measurements were unavailable. FreeCAD reports 29.038 cm³ for
the second compound versus Inventor's high-accuracy 25.791 cm³; therefore these
purchased multibody models are not certified mass-property data. This does not
prevent accepting their geometry/poses for reference and documentation.

Windows created an editable native AW2725Q fixture from six named parameters,
sketch dimensions and an extrusion; reopened it, edited depth 72.63→80→72.63 mm,
saved and exported it. All 29 checks passed. FreeCAD validates that export as one
solid with bounds 609.51 × 355.97 × 72.63 mm, front plane Z=0 and body toward −Z,
volume 15,758,333.161 mm³. The existing Linux STEP also passed Inventor checks.
This demonstrates scripted native feature authoring; it is still a nominal monitor
envelope, with no mount, thread, cable, ventilation or fit detail.

## Use and documentation interface

`assembly/build_reference.py` generates a hierarchical FreeCAD reference at
`.cache/enclosure-reference.FCStd` from the tracked parts/scene. Save/reopen,
counts and reference bounds/volume were checked. The generated FCStd is ignored
by Git and contains imported geometry/placements, not Inventor constraints/history.
Preserve it as a reference; author changes under designs/.

Raw exporter manifests are preserved byte-for-byte. Despite their draft-1 label,
they do not pass the documentation loader unchanged: identifiers contain spaces,
slashes and pipes; metadata has additional fields; the model is +Y up. An adapter
must map IDs with a reversible sidecar, retain source/BOM fields, and apply the
provided proper rotation `(x,y,z) → (x,-z,y)` once at the root for a +Z-up scene.
Keep instance-specific flexible-group poses. CAD instance counts are not purchased
quantities or physically counted stock; no assembly steps are invented here.

Actual units are 21 inch assets, 15 mm assets and one cm asset (the Windows prose
said 16 mm, a counting typo). FreeCAD Part.read normalizes each to **mm**. The
current documentation mesh code scales those coordinates using the header unit,
which would oversize an inch part by 25.4 and a cm part by 10. The documentation
agent has the concrete panel counterexample and should correct/qualify this before
using production assets. Preserve original files; no uniform-mm reexport is needed.

## Tests and next work

- 34 portable tests pass in Guix and on Windows; all 37 reference imports repeat
  without changes and preserve provenance; all 38 current reference entries are clean.
- Windows: 11 offline receipt checks, four real negative receipt cases, 19 unchanged
  pilot rerun checks, changed-input refusal before filesystem/Inventor activity.
- Documentation agent reports two synthetic pipelines (59 tests, 16 output checks)
  and newer Cycles/Pixi rendering; production CAD ingestion remains a separate task.
- Next: documentation unit fix/adapter and a limited production inspection view;
  exporter input/state/collision hardening; then an explicit Vault publication
  destination and qualified STEP add/native dependency-aware check-in.

Raw evidence: `vault-cad-exchange/evidence/2026-10-21-windows-native-pilot-02/` and
`2026-10-21-linux-native-review-02/`. See [machine-readable review](2026-10-21-pilot-02-review.json).
