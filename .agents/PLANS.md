# Tank-enclosure plan

## Objective

Deliver the modified enclosure with its design records in Vault, STEP-based
access through Git and open-source tools, and a primarily visual inventory and
assembly manual.

The direction of the wider work is in the sibling `mechanical-cad` repository
(`docs/direction.md`); this project is its test case. Finished checkpoints, with
their evidence runs, are in .agents/HISTORY.md.

## Current state (2026-11-10)

- **CAD snapshot.** `references/enclosure/` holds the accepted snapshot of Vault
  file-version 991056: 37 STEP parts, 155 occurrences, 17 groups. FreeCAD
  reconstructs its 479 solids.
- **Manual.** The phase-1 draft (the enclosure without tanks and backlight) was
  published on 2026-10-23 under `docs/manual/` and is served by the Pages site:
  110 of the 155 occurrences are in this build, 42 are conditional and 3
  deferred; 18 draft steps, of which two are conditional and one deferred. The
  order is a draft and nothing is physically validated.
- **Physical build.** Peter is assembling the enclosure from the published
  manual and taking notes on the documentation.
- **Vault.** One file written: the monitor envelope
  `step/AW2725Q-nominal-envelope.step`, Vault version 994252 (2026-10-22),
  recorded in `vault-lock.json`. Nothing else. A read-only check on 2026-11-10
  found that none of the snapshot's 44 files has changed in Vault since
  2026-10-21: every one is still at the version that was exported, revision 0,
  Work in Progress, not checked out.
- **Procurement.** `assembly/procurement/` has a 37-row stock sheet and 20
  supplementary rows (16 for the existing design, 4 for new design). No stock is
  counted and no quantity is approved. The native BOM audit is folded in: of
  the 16 joints of the existing design, 7 have their hardware in the native BOM
  and exported, 7 are unknown and 2 are absent from every native source. Vault
  holds no drawing for any version of the 44 files.
- **Materials.** `assembly/materials.json` has 37 rows, 23 with a CAD claim and
  14 unknown; none is curated.
- **Size.** `docs/` is 141 MB of tracked files, almost all of it the manual
  package; `.git` is 229 MB. Each publication adds images, PDFs and viewer
  files.
- **This date.** The README files, the build recipe and the guidance were
  brought up to date, the plan was cut down and its past moved to
  .agents/HISTORY.md, and the Pages workflow now runs only when a push changes
  `docs/`, `mkdocs.yml` or the workflow itself.

## Next work

1. Peter's notes from the build and his corrected `assembly/instructions.json`.
   Then: re-render with `--reuse` in `mechanical-docs` (only the overview and
   the steps whose state changed), republish with `assembly/publish_manual.py`,
   build the site strictly with `make site`. Known before the build, from the
   documentation's reading of the bounding boxes (2026-10-23): the camera frame
   needs a side entry before the panels go on, and the conditional tank support
   frames cannot go in after the panels, the camera frame and the top panel.
   A third, low view for some steps is worth considering.
2. Out of the build: decide the conditional tank support frames
   (`assembly/build-scope.json`, `conditional_groups`); name the occurrences
   that form the backlight; record counted stock in the procurement sheets;
   write plain `scene.json` in `build-scope.scene` on the file's next revision.
3. The layout conversion, on a branch, on Peter's word. He decided the
   layout's three choices on 2026-11-11: two roots, readable keys, and AP242
   for files exported from Inventor. The files here are AP214 and stay so
   until the re-export that follows the conversion. A dry
   run on 2026-11-10 converted `references/enclosure/` into the proposed layout
   in the ignored `.cache/layout-dry-run-01/` and passed the acceptance test of
   `mechanical-cad/docs/layout-proposal.md`; nothing tracked here changed. What
   the branch still needs:
   - the converted `references/` tree and the derived lock (the dry run's
     output, regenerated on the branch with `vault-cad import-snapshot`);
   - the curated files that carry part ids re-keyed by script:
     `assembly/materials.json`, `assembly/procurement/modeled-parts.csv`,
     `supplementary-bom.csv` (its `part:` references) and `joint-audit.json`;
   - the eight scripts under `assembly/` that read `references/enclosure/`
     pointed at the scene flattened by `mechanical-cad`
     (`survey_reference.py`, `prepare_documentation.py`,
     `propose_joint_views.py`, `materials_manifest.py`,
     `draft_instructions.py`, `site_pages.py`, `procurement_manifests.py`,
     `build_reference.py`);
   - the monitor envelope moved to `designs/parts/`, built with
     `mechanical-cad/tools/build_part.py`, with its publication record in a
     `vault.json` and `step/` retired;
   - the `.gitattributes` rule that keeps the exporter's records byte for byte
     moved with them to `references/receipts/`;
   - the acceptance test run on the branch.
   `main` stays as it is until that passes.
4. After the build: new parts written as code under `designs/`, manufactured
   and checked, then placed in Vault through `vault-cad-tools`.

## Open items

For Peter to settle:

- The README's licence scope statement. It says component models that
  originate from suppliers (for example the McMaster-Carr parts under
  `references/enclosure/assets/`) are not covered by the licence and remain
  subject to their suppliers' terms. The wording is an agent's draft. Whether
  those models may be redistributed publicly at all was not assessed.
- The Inventor requirement. The manager's brief asks for design work in
  Inventor and finished records in Vault; the decision of 2026-10-23 is that
  new parts are written as code and referenced from Inventor as STEP. The two
  are not reconciled (README, "Monitor reference and the Inventor
  requirement").
- Whether the generated manual packages move out of tracked `docs/` (proposed
  on 2026-11-10, not approved).
- Names in tracked and published files: the Vault path and server name, and
  account and host names inside the exported records and the published
  `docs/manual/manual.json`. See `mechanical-cad/docs/direction.md`, "Not
  settled".
- Which Vault files this project mirrors. The snapshot follows one root
  assembly. The project's Vault folder holds 32 files, six of which are not in
  the snapshot: a second root assembly `SLLB Enclosure.iam` (19 of its 20
  dependencies are in the snapshot already), the 56-inch extrusion only it
  uses, three parts nothing in the folder uses (`SLLB Enclosure 102in ...`,
  `T BRACKET 47065T278`, `EXTRUSTION 15 SERIES TABLE CLAMP`), and the
  published monitor envelope. The snapshot in turn holds 18 files from outside
  the folder (McMaster parts and parts of two other projects).
  Peter on 2026-11-10: he does not know `SLLB Enclosure.iam` and wants to look
  at it in Inventor before giving an opinion. What the read-only discovery of
  that day recorded about it: version 3, last checked in on 2026-03-06, six
  months before the free-standing enclosure's last check-in; its direct
  children are `CAMERA FRAME.iam` (the same sub-assembly this project uses),
  the `MCMASTER 47065T245` corner cube and the 44-inch and 56-inch
  extrusions; its only parent is `2W.353 TOP ASSY.iam` in the lab's `2W.353`
  folder. So a change to the camera frame in Vault reaches both assemblies.
- The intended tank configuration. The CAD count is three, and two of the
  three (the tank at the root and the one inside `TANK SUPPORT FRAME:1`) sit at
  the same position.
- The monitor height reference: the lower platform's top is at 501.6 mm, the
  instructed 584.16 mm is the top of the lower tank resting on it. Paused with
  the placement pilot.
- Curating `assembly/materials.json`.

Not started:

- Vendor documentation or a physical kit inspection for the eight compound
  purchased parts, then a physical stock count, and only then a priced purchase
  shortlist. No order is placed without Peter's explicit request.
- The design of the monitor supports and their removal path, the acrylic
  interface, and the bowls and bowl frame. Six bowls of 160 mm outside diameter
  in a 3 × 2 array leave 12.93 mm in total on the display's short axis; confirm
  the bowl and rim dimensions first.
- A refresh of the snapshot from a changed Vault, and conflict handling, have
  never been exercised.
- No record says anyone has looked at the site's 3D viewer in a browser since
  it was published.
- Low priority, by Peter on 2026-10-22: the hidden bodies in
  `MCMASTER 47065T245`, and drawings outside the 44 files. Measured on
  2026-11-10: each of that part's three hidden bodies is a 940.2 mm³ solid;
  the AP214 export leaves them out, an AP242 export carries them, and
  Inventor's own volume for the part counts them. With AP242 decided
  (2026-11-11), `mechanical-cad` leaves the bodies an AP242 file marks
  invisible out when it measures a part and when it writes the scene the
  manual is drawn from; this is the one part of the 37 that has any.

## Decisions

- Phase 1 is the enclosure without tanks and backlight; the monitor, bowl and
  tank-frame design is deferred (Peter, 2026-10-22).
- In the modified build the tanks and the lower light box are replaced by two
  monitors under acrylic and bowls (Peter, 2026-10-22; his intent, not
  confirmed by the designer).
- The HTML documentation is a GitHub Pages site built from this repository,
  and the built manual is stored here (Peter, 2026-10-22).
- Publications to Vault go to the project's existing folder, recorded in
  `vault-project.toml` (Peter, 2026-10-22).
- Licence: 3-clause BSD, copyright Howard Hughes Medical Institute, for the
  material authored for this project (Peter, 2026-11-10).
