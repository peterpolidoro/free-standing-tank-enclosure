# Tank-enclosure pilot plan

## Objective

Use Git and open-source CAD tools to work with the specified Vault project, and
publish Linux-created STEP parts for Inventor teammates.

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
- [ ] Resolve native/STEP completeness and precise dimensions, accept assembly,
  and have Peter commit the reference baseline. The Windows counters used
  unfiltered `SurfaceBodies.Count` (503 native / 479 re-imported), not `IsSolid`.
  Ordinary and optimal bounding boxes differ; see validation/2026-10-21-linux.json.
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
