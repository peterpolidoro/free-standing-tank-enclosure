# Tank-enclosure pilot plan

## Objective

Deliver the modified enclosure with native Inventor/Vault design records,
STEP-based access through Git and open-source tools, and a primarily visual
inventory and assembly manual. The acceptable production authoring workflow
still needs to be reconciled with the manager's Inventor requirement.

## Progress (2026-10-21)

- [x] Repository layout, STEP Git attributes, and project locator established.
- [x] Source/generated/authored ownership documented; initial empty lock established.
- [x] Resolve exact root assembly and dependency versions using authenticated Vault access
  (Windows, 2026-10-21: root file-version 991056 / master 988153 v5; 43 dependency
  versions; real path `$/DATA/PROJECTS/...`, `vault-project.toml` corrected).
- [x] Qualify Windows exports and record source/output associations (part 991092 and
  assembly 991056 exported to AP214 STEP with receipts; re-opened in Inventor; see
  `vault-cad-exchange/evidence/2026-10-21-windows-qualification-01/exports/`).
- [x] Validate both exported checksums and inspect them in Guix FreeCAD 1.1.3.
  Panel: one valid solid, matching dimensions, imported with original provenance.
  Assembly: 479 solids, all features valid, 14 top-level members; held for review.
- [x] Account for the 24-body count difference: hidden solids in eight occurrences
  of MCMASTER 47065T245. Verify all 44 native input hashes and identical STEP DATA
  between the original and stronger-provenance export.
- [ ] Resolve 8.46%/12.30% native/STEP volume differences in MCMASTER 5537T293/5537T429,
  then decide full baseline acceptance. Count/bounds agreement is not surface
  equivalence. See validation/2026-10-21-native-pilot-review.md.
- [ ] Agree on a destination for a new authored STEP, publish it, and validate in Inventor.
- [ ] Verify refresh and concurrent-change behavior before importing the whole project.

## Current evidence and dependencies

The Windows report is in the shared vault-cad-tools checkout. It identifies
Vault Professional, vault ID 28, REST v2, and installed STEP job handlers. These
are capability observations, not end-to-end workflow evidence.

The Linux development session could not resolve `svault5`, including an
unsandboxed read-only probe; Linux may require a resolvable FQDN or network
configuration. Windows (2026-10-21) captured the served OpenAPI description,
authenticated with the Windows identity, resolved the root and its 43 dependency
versions (all Work in Progress, none checked out, no library files), mirrored
them into the ignored `.cache/vault-workspace/`, and exported the part and the
assembly with Inventor 2025.3. Evidence, receipts and the Windows report are in
`vault-cad-exchange/evidence/2026-10-21-windows-qualification-01/`. The import
smoke test passed on both hosts in disposable copies; Linux also verified that
43 assembly dependency records survive import and repeated imports are no-ops.
The main lock now records the panel only. The Linux report and Windows follow-up
are in the sibling evidence run `2026-10-21-linux-validation-01`; compact results
are tracked under validation/. Tools now pass 34 tests in Guix. No publication
destination has been chosen and no Vault write has occurred. Changes are uncommitted
in the Linux checkouts; shared Git clones are unchanged.

## Manager brief and monitor reference (2026-10-21)

- The previous changes were committed by Peter: tools `163ed4c`, project `f11b2ae`;
  Linux/shared clones were synchronized before this work. Older uncommitted-status
  notes above describe the preceding validation session.
- New requirement from the manager: design work in Inventor and final records in
  Vault. Do not assume FreeCAD-to-STEP import satisfies native design authoring.
  Proposed path: scripted native Inventor features/assembly edits, STEP copies
  for open-source inspection, and dependency-aware native Vault check-in.
- [x] Inspect Peter's `aw2725q-monitor.pdf`; printed nominal dimensions, not scale
  measurements, define a stand-free monitor reference in
  `designs/reference-models/alienware-aw2725q/`.
- [x] Generate a parametric FCStd box/display plane and a closed-solid STEP
  envelope. FreeCAD 1.1.3 save/reopen, saved parameter edit/recompute, STEP validity,
  extent and volume checks pass. The model does not define actual rear contours,
  mounting holes, threads, cable/ventilation space or installation tolerances.
- [x] Share original PDF, preview, text and model/evidence outside Git at
  `/janelia/sciserv/polidorop/Repositories/vault-cad-exchange/evidence/2026-10-21-linux-monitor-reference-01/`.
- [ ] Windows: inspect reference STEP and create/validate a matching native
  parameterized reference. The disposable assembly pilot and cache/input-hash
  checks now pass; targeted geometry questions remain. No production Vault write yet.
- [ ] Confirm bowl outer/rim dimensions and display coverage: six bowls arranged
  3 × 2 at 160 mm outside diameter leave only 12.93 mm of short-axis space.
- New monitor-reference files, README and this plan are uncommitted in the Linux
  project checkout only; shared clones and the reusable tools repo are unchanged.
  Manager logistics, budget/reporting details and the latest Windows handoff are
  in the shared coordination area, outside Git.

## Visual assembly documentation (2026-10-21T17:46:48Z)

- [x] Record Peter's added goal and interface/acceptance requirements in
  `assembly/README.md`: visual physical inventory, small illustrated steps, and
  matching web/PDF outputs from one source, with minimal dependence on prose.
- [x] Prepare a shared handoff for a documentation agent Peter may choose and
  notify the Windows agent to preserve part/configuration identities, every
  occurrence/transform, subassemblies and BOM classifications in future exports.
- [ ] Agree a small fixture and demonstrate a visual BOM plus a few steps using
  FreeCAD/OCCT geometry preparation, Blender renders and HTML/PDF generation.
- [ ] Reconcile the full BOM and actual stock; resolve assembly export completeness.
- [ ] Author/review prerequisites, insertion motions, tool access and in-room
  assembly constraints; validate the sequence through a physical walkthrough.
- Peter created `mechanical-docs`; its handoff, input-contract draft and synthetic
  STEP fixture are ready. No manual/website was generated or published and no
  assembly sequence has been declared feasible. Existing monitor work is preserved.

## Native pilot review (2026-10-21)

- [x] Review Windows reply `20261021T180901Z-windows-native-pilot-results.md`.
- [x] Validate the two-panel pilot STEP in FreeCAD: two valid solids, correct
  dimensions/translations and zero final overlap. Native constraint behavior is
  evidenced by Windows, not reconstructed from STEP.
- [x] Integrate reviewed scripts and compact project results in Linux checkouts;
  preserve the monitor/manual work. No commits, pushes or shared-clone changes.
- [ ] Windows: qualify Linux receipt/state guards and the offline receipt tests.
- [ ] Windows/Linux: export distinct part/configuration geometry and parent-relative
  occurrence/BOM metadata; use mechanical-docs' draft contract as an adapter target.
- [ ] Windows: create the native named-parameter monitor fixture and show a saved
  dimension edit/recompute; imported-only geometry does not establish native authoring.
- Only the panel is in the reference lock. Full assembly remains in shared evidence
  pending the two-part comparison; per-part output is preferred before adding large
  repeated assembly snapshots to Git. No production Vault write is enabled.
