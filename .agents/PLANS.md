# Tank-enclosure pilot plan

## Objective

Deliver the modified enclosure with native Inventor/Vault design records,
STEP-based access through Git and open-source tools, and a primarily visual
inventory and assembly manual. The acceptable production authoring workflow
still needs to be reconciled with the manager's Inventor requirement.

## Coordinator resumed (2026-10-22T16:47:10Z)

Peter committed the project preparation work as `6dc874a` and synchronized the
shared project clone; mechanical-docs is committed at `3ab5214` with the
documentation agent now implementing the supplementary-inventory contract on top.
Tools remain clean at `0705b40`. The previous "dirty on 683c0ba" notes are historical.

- [x] Relay the authorized read-only native BOM/kit/drawing audit to Windows and
  send the documentation agent the supplementary-manifest decisions and joint ids
  (coordination messages `20261022T161838Z-linux-*`).
- [x] Windows delivered the audit (`evidence/2026-10-22-windows-native-bom-audit-01/`).
  Linux cross-checks: root parts-only view = the 37 exported parts, quantities
  equal `cad_occurrences` for all 37 (155 total); all 16 existing-scope joints
  classified (7 a2, 7 e, 2 d); no drawings exist in Vault for any version of the
  44 masters; no virtual/suppressed/excluded/reference items; coincident tank
  unresolved by CAD. Findings folded into `assembly/procurement/` (README section,
  `joint-audit.json` `native_audit`, CSV evidence and identification columns).
- [x] Windows patch `dd415d54...` (full replacement on tools 0705b40, supersedes
  f45d968e...) applies cleanly in an isolated clone; 60 portable tests pass there.
  Scene contract regression (`suppressed`/`mirrored`) acknowledged and restored.
- [ ] Integrate that patch into the Linux tools worktree after the independent
  static review; then older Inventor scripts migrate to the session helper.
- [x] Peter (2026-10-22): tank(s) and the lower-panel light box are replaced by the
  two monitors and bowls in the modified build (intent, not designer-confirmed);
  hidden bodies and outside drawings are unknown to him and stay low priority.
  Which occurrences form the light box is still unidentified.
- [x] Peter (2026-10-22): first live publication pilot = `step/AW2725Q-nominal-envelope.step`
  into `$/DATA/PROJECTS/_PROJECTS BY LAB/SCHULZE (LAB)/ENCLOSURE` (recorded in
  `vault-project.toml [publication]`). Sequence after commit/push: Linux
  `prepare-publish`; Windows (after M1-M3/P1 fixes) snapshot, plan, single live add,
  exact-byte re-download, result; Linux result ingest (to implement). No other writes.
- [ ] Vendor documentation or physical kit inspection for the eight compound
  purchased parts; physical stock count; only then a priced purchase shortlist.
- [x] Documentation delivered the supplement validator (23 fields) and the joint
  close-up mechanism on the fixture (102 tests). Linux: `assembly/procurement_manifests.py`
  converts the CSVs to `supplement.json` and the inventory stock record at staging
  time; `assembly/propose_joint_views.py` generated 16 joint views; `render.json`
  adopts the six inspection groups. Staged `.cache/manual/project-supplement-01`
  loads in mechanical-docs (20 rows, 0 stock counts, 16 joint views). Overlay for
  the documentation build: `evidence/2026-10-22-linux-supplement-mapping-01/`.
- [x] Documentation built the enclosure with the overlay (16 joint close-ups, 36/54-page
  PDFs, all checks pass); Linux adjusted the 7 views that hid the attachment, raised the
  outline budget to 600000 and added `assembly/project-notes.json` (printed note on the
  intended build change). Rebuild requested; the documentation agent has not read it yet.
- [x] FIRST LIVE VAULT ADD (2026-10-22T18:23:24Z): `step/AW2725Q-nominal-envelope.step` is Vault master
  994251 / version 994252 in the project folder (953863); verified by Windows, re-checked
  on Linux, recorded in `vault-lock.json` `publications` by `import-publish-result`.
- [ ] Windows: placement pilot of two monitor envelopes on the lower platform in a disposable
  copy, exported for Linux review; then an adapter design document before any native
  check-in. The real monitor support, acrylic and bowl design remain undesigned.

## Session wrap-up (2026-10-22, supersedes earlier current-checkpoint notes)

Both external agents finished. Read the shared `coordination/NEXT-AGENT.md` for
full recovery paths, patch hashes, role messages and the continuation order.

- Windows delivered a full replacement patch against tools 0705b40, SHA-256
  f45d968e885f49d70b34b1d21ad2618d9fb36a71e42ef83f227d61d4e7217d51.
  It reports closure of the four cleanup/harness review cases and adds an offline
  publication planner plus a dry-run-only SDK executor. Applied/tested only in an
  isolated Linux clone (55 tests pass); full code review/integration remains.
- Windows explicitly did NOT start the native BOM/drawing/attachment audit. This
  is the next Windows priority and already within Peter's requested read-only work.
  A new runtime/task relay is needed; no new user approval for reading is implied.
- Documentation delivered six group inspection views, long-extrusion/end views,
  a 16-page draft inventory (25 with appendix) and coincident-tank finding. Fresh
  Linux tests: 84 pass, 2 FreeCAD-only tests skipped; agent reports those 2 passed
  separately. Supplementary inventory is proposed, NOT implemented.
- Wrap-up verified 15 artifact checks: 51 render image hashes, both PDF/HTML data
  packages, Windows 40 payload hashes and 37 unchanged geometry DATA sections,
  and 155 unchanged identities/placements/BOM classifications. New Windows scene
  omits the earlier suppressed/mirrored fields; retain accepted snapshot and
  review that contract difference before importing anything.
- Complete standalone HTML/PDF packages were assembled in new handoff evidence
  from checksum-matched images. Original shared manuals omitted their images;
  no re-render or changes to earlier evidence were needed.
- All local source changes remain uncommitted. Tools/shared clones remain clean;
  Windows work is preserved as its patch, project and mechanical-docs as full
  recovery patches in `evidence/2026-10-22-session-handoff-01/`.

Next: read-only native BOM/kit/attachment audit and intended tank configuration;
review/integrate Windows patch; agree supplementary inventory contract and project
mapping; adopt/review docs render overlay; reconcile physical stock and purchase
specifications. Full assembly procedure, production monitor/bowl design and live
Vault publication remain unfinished. No commits, pushes, orders or Vault writes.

## Earlier checkpoint (2026-10-22)

Previous dated sections are historical progress notes. Current bases are project
`683c0ba`, tools `0705b40`, documentation `27f9581`; Peter synchronized the shared
project clone. This session leaves new project work uncommitted and does not
modify shared Git checkouts or Vault.

- [x] Review Windows hardening-02 evidence: completed checkpoint, not a lost run.
  Full replacement patch is preserved; integration waits for focused cleanup and
  harness failure cases. Windows agent has restarted per Peter.
- [x] Verify documentation production artifacts and loader: 37 parts, 155 instances,
  17 groups, mm normalization and one basis conversion. 76 tests pass at the
  reviewed checkpoint; 12-page inventory PDF exists. Documentation agent is
  improving pictorial inventory and isolated inspection views.
- [x] Create a project-specific documentation recipe/stager with source hashes,
  independent copies, preserved stock, no implicit assembly steps, and Cycles
  outline budget. Fifteen preparation/Git/procurement checks pass against clean
  documentation commit 27f9581. Full new-config rendering has not been repeated.
- [x] Diagnose fresh-clone receipt failures: Git normalized raw CRLF metadata.
  Preserve original four JSON files with an attributes override; verify all 40
  payload hashes through both LF and CRLF-configured Git checkouts. Include the
  exact raw JSON blobs in the next commit; do not merely commit attributes.
- [x] Survey the accepted STEP geometry in FreeCAD: 479 solids, 155 placements,
  17 group bounds. Flag one pair of coincident same-part tank instances; do not
  remove either or derive purchasing quantities before native/configuration review.
- [x] Create a 37-row modeled stock worksheet and 20 candidate attachment/design
  audits. Unknown stock/required/order quantities remain blank. These complement
  the CAD inventory; they are not an approved purchase BOM.
- [ ] Windows: read-only native structured/parts-only BOM, virtual/suppressed/
  reference components and associated drawing audit, ahead of optional offline
  upload-adapter expansion after the cleanup fixes.
- [ ] Documentation: attachment close-ups and supplementary inventory contract;
  preserve kit boundaries and unknown quantities.
- [ ] Reconcile intended assembly configuration, kit contents and physical stock;
  confirm every missing hardware SKU/quantity before preparing a purchase shortlist.
- [ ] Design/review monitor supports, removal paths, acrylic interface and bowl
  rim/layout; front-to-back nominal footprint is promising but not a fit approval.
- [ ] Author and physically validate actual assembly order/tool access. Any live
  Vault write still needs a concrete destination/payload and qualified adapter.

Details: `assembly/documentation-workflow.md`, `assembly/procurement/README.md`,
`validation/2026-10-22-reference-survey.md`. Shared coordination records the two
active agent assignments and user requests. The current evidence run is
`vault-cad-exchange/evidence/2026-10-22-linux-project-preparation-01/`.

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
- [x] Resolve the default-accuracy volume differences with VeryHigh measurements;
  accept the frozen 37-part reference snapshot after matching reconstruction in
  FreeCAD. See validation/2026-10-21-pilot-02-review.md. Physical/design review remains.
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
The main lock now records the earlier panel plus 37 parts in references/enclosure/. The Linux report and Windows follow-up
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
- [x] Windows: inspect reference STEP and create/validate a matching native
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
- [x] Windows: qualify Linux receipt/state guards and all 11 offline receipt tests.
- [ ] Windows/Linux: export distinct part/configuration geometry and parent-relative
  occurrence/BOM metadata; use mechanical-docs' draft contract as an adapter target.
- [x] Windows: create the native named-parameter monitor fixture and show a saved
  dimension edit/recompute; imported-only geometry does not establish native authoring.
- The reference lock now includes 37 accepted part assets plus the earlier panel.
  Full monolithic STEP remains in shared evidence. No production Vault write is enabled.

## Accepted snapshot and documentation handoff (pilot 02)

- Peter committed/synchronized the prior work as tools 498279f / project 43f99b8.
- [x] Linux: verify 40 receipt payloads, root/37 part source hashes, 155 local/world
  transforms and all FreeCAD shapes; reconstruct and match all 479 solid signatures.
- [x] Import all 37 part references with provenance; repeat imports are no-ops.
- [x] Generate/save/reopen hierarchical reference FCStd under ignored .cache/;
  preserve original STEP/header units and raw metadata in the Git snapshot.
- [x] Windows: 29 native parameter checks; Linux native monitor STEP validation.
- [ ] Documentation: correct FreeCAD mm normalization, map IDs/preserve metadata,
  apply the root basis once, then load the first production example. Keep flexible
  instance groups distinct. No physical stock or assembly sequence is inferred.
- [ ] Windows: harden the prototype per-part exporter (all opened inputs including
  groups, explicit model-state handling, path/collision/unknown-unit failures).
- [ ] User/Windows: concrete publication destination and qualified STEP/native
  check-in adapter. Service mode and production assembly edits remain unqualified.
- New code, accepted part snapshot and reports are uncommitted in local CAD repos;
  shared clones and mechanical-docs were not edited by this CAD review.
