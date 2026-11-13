# Tank-enclosure plan

## Objective

Deliver the modified enclosure with its design records in Vault, STEP-based
access through Git and open-source tools, and a primarily visual inventory and
assembly manual.

The direction of the wider work is in the sibling `mechanical-cad` repository
(`docs/direction.md`); this project is its test case. Finished checkpoints, with
their evidence runs, are in .agents/HISTORY.md.

## Current state (2026-11-12)

- **CAD snapshot.** `references/` holds the accepted snapshot of Vault
  file-version 991056 in the layout of `mechanical-cad`: 37 part directories
  and 7 assembly directories, which flatten to 155 occurrences in 17 groups.
  FreeCAD reconstructs its 479 solids. Since 2026-11-12 the STEP files are
  AP242 with normalised headers, from the package the Windows exporter wrote
  that day of the same Vault versions (receipt under
  `references/receipts/2026-11-12-windows-package-findings-01/`; the AP214
  files and the first receipt are in Git history and under
  `references/receipts/legacy-snapshot-991056/`).
- **Manual.** The phase-1 draft (the enclosure without tanks and backlight) was
  published on 2026-10-23 under `docs/manual/` and is served by the Pages site:
  110 of the 155 occurrences are in this build, 42 are conditional and 3
  deferred; 18 draft steps, of which two are conditional and one deferred. The
  order is a draft and nothing is physically validated.
- **Physical build.** Peter is assembling the enclosure from the published
  manual and taking notes on the documentation.
- **Facts measured again on 2026-11-13.** Every `facts.json`, 37 imported
  parts and the envelope, is now measured with the kernel's adaptive
  integration (`mechanical-cad`, at Peter's word; `tool.integration` in each
  file). The plain integration FreeCAD offers was 0.83 % low in volume for
  one part, the constant-force spring `MCMASTER 9293K121` (18 270.7 mm3
  then, 18 422.2 now, which is what Inventor and a fine mesh give), and had
  its centre of mass 4.0 mm off. No other volume changes by more than 5e-5;
  counts, bounding boxes and validity are the same for all 38. The toggle
  clamp's file carries a note: one of its solids reaches 2.3e-5, not the
  1e-7 asked. No STEP file changed. Measuring needs `mechanical-cad`'s
  environment with the OCP bindings.
- **Vault.** One file written: the monitor envelope, Vault version 994252
  (2026-10-22), recorded in
  `designs/parts/aw2725q-nominal-envelope/vault.json`. Nothing else. The
  envelope is now built from a program; the file built is the same solid as
  the published one (one solid, same bounding box and volume) but not the same
  bytes, and the validator reports that. Since 2026-11-13 the program is
  written with build123d (Peter's word; the first part of a project written
  with it): rebuilt with `mechanical-cad`'s tool, every measured fact is the
  same to the last digit, its four checks pass, and `part.step` differs from
  the file before in 14 lines, each only in the sign of a zero. The project
  validates with the same one finding and `status` is unchanged. Building it
  needs `mechanical-cad`'s environment with build123d (the part's README has
  the command). A read-only check on 2026-11-10
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
- **Layout conversion (2026-11-11 on the branch `layout-conversion`; merged
  into `main` on 2026-11-12, 7a1af68).** The
  tree was converted with `vault-cad import-snapshot`, the 37 parts measured,
  the curated files that name parts re-keyed (`assembly/materials.json`,
  `procurement/modeled-parts.csv`, `procurement/joint-audit.json`), and the
  scripts under `assembly/` pointed at the scene flattened from `references/`
  (`assembly/reference_scene.py`). Checked that day:
  - the layout validates with no error; two findings (37 headers not
    normalised, and the envelope's bytes);
  - the acceptance test of `mechanical-cad` passes all four checks against the
    snapshot on `main`: byte-identical STEP files, the flattened scene equal to
    the exporter's (37 parts, 17 groups, 155 occurrences, largest translation
    difference 6.5e-11 mm), the documentation project loading the same;
  - the project staged by `assembly/prepare_documentation.py` from this tree
    loads in `mechanical_docs inspect` with the same parts, inventory, build
    scope, steps and findings as the accepted one;
  - `survey_reference.py` reproduces the survey of 2026-10-22 (479 solids, 17
    group envelopes within 1e-7 mm, the same coincident tanks);
    `build_reference.py` builds its FreeCAD document; `phase_parts_list.py`
    rewrites the same sheet; `propose_joint_views.py` prints the same proposal
    as on `main`; `site_pages.py` rewrites the same pages apart from one
    sentence of the front page that named the old directory.
  Not run: any mesh, render or manual build.
  What the conversion took out of the tree, all of it in Git history:
  `references/enclosure/` (its STEP files are now the `part.step` files, byte
  for byte, and its four records are under `references/receipts/`, unchanged,
  beside the dependency inventory and acquisition record of the same day);
  `references/ENCLOSURE TOP PANEL.step`, an earlier single export of a part
  the snapshot holds; the per-file import records of the old
  `vault-lock.json`, whose facts are now in each `source.json`; `step/`; and
  under `designs/reference-models/` the FreeCAD document, its generator and
  the STEP exported from it, replaced by `build.py`. The two validation
  records of that model moved to `validation/`.
  `draft_instructions.py` run on the flattened scene lists the three tanks of
  its last step in another order than the tracked `instructions.json`, because
  the scene lists occurrences in another order; nothing else differs. It is
  not run over Peter's edits.
- **Placements checked against Inventor's own export (2026-11-12).** Windows
  exported `Free Standing Enclosure.iam` as one AP242 STEP file, read-only
  (no Vault access, nothing saved, the 44 documents bound to the acquisition
  by hash). `mechanical-cad/tools/compare_assembly_step.py` on this branch
  and that file, in the assembly's own frame: 479 of 479 solids where
  `references/assemblies/` puts them, within 6.4e-11 mm, and no other visible
  solid in the file; read in the wrong frame as a control, none matches. The
  44 occurrences below the two flexible instances are among them. The file
  is evidence in the shared directory
  (`evidence/2026-11-12-windows-assembly-step-01/`, the comparison in
  `evidence/2026-11-12-linux-windows-assembly-step-review-01/`) and is in no
  repository.
- **Short commands (2026-11-12, on the same branch).** `make` alone lists
  them. `make assemblies` lists the seven assemblies and says which are built;
  `make assembly [KEY=<key>]` builds one as a STEP file and a FreeCAD document
  under `.cache/assemblies/`; `make validate` and `make reference-scene` need
  no parameter. The CAD targets are handed to the Makefile of `mechanical-cad`,
  found beside this repository or through the ignored `local.mk`. Run that
  day: `make`, `make validate` (no error, the two findings), `make assemblies`,
  `make assembly KEY=camera-frame` (16 parts, 36 occurrences, 124 solids, each
  within 0.002 mm of its recorded place, 25 s), an unknown key (refused, with
  the list of keys) and `make reference-scene` (the same scene, byte for
  byte). The site and project-data targets were moved in the file, not
  changed, and not run again.
- **Opening an assembly in FreeCAD (2026-11-12, on the same branch).**
  `make open [KEY=<key>]` builds the assembly if need be and opens its
  FreeCAD document in the FreeCAD window that `guix shell` provides. The
  first look at a built document in the window found it empty: a document
  saved without a window opens with every object hidden. `mechanical-cad`
  now writes what the window shows into the document, and files built before
  that are listed as out of date. Seen in the window after the fix (FreeCAD
  1.1.3): the whole enclosure upright and in view as the document opens, its
  155 occurrences shown and the 37 part files hidden; the caster assembly
  likewise. `make open KEY=caster-assembly` brought FreeCAD up on the
  document. Everything is one grey; the files carry no colour.

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
3. The branch `layout-conversion` was merged into `main` by Peter on
   2026-11-12 (fast-forward, 7a1af68). The worktree of the branch is no
   longer needed; its ignored `.cache/` holds the preview run of the manual
   (`manual-ap242/`) and the built assemblies, which are rebuilt on demand.
   What is left of the conversion:
   - `vault-cad-tools` reads the new `vault-lock.json` since 2026-11-11: its
     `status` on this tree reports the 37 parts and 7 assemblies clean and the
     envelope as changed since it was published. A publication now starts
     from `designs/parts/<key>/part.step` and is recorded in the part's
     `vault.json`. No publication has been made from this layout. The file
     name a part gets in Vault (`<key>.step` unless another is given) is
     Peter's to settle before the next one.
   - The published manual under `docs/manual/` names parts by the exporter's
     ids. `assembly/site_pages.py` reads the scene under those ids until a
     manual built from this tree is published; that branch of the script goes
     then.
   - A checkout needs its own `local.mk` where `mechanical-cad` is not
     beside it.
   - On Windows the new layout was checked out and read on 2026-11-12
     (shared evidence `2026-11-12-windows-new-layout-01`): `status` gives
     what Linux gets, and a repeat import of the same Vault versions into a
     clone leaves all 44 directories untouched, as on Linux
     (`2026-11-12-linux-main-baseline-01`). `mechanical_cad validate` failed
     there with one error: Git for Windows had written CRLF into 29 text
     files, `build.py` of the envelope among them, whose hash its receipt
     records. The fault was in `.gitattributes`, which gave LF only to
     `.md`, `.toml` and `.json`. Corrected on 2026-11-13: `* text=auto
     eol=lf`, and `.glb` named as binary. No tracked file changes on Linux.
     Reproduced and checked on Linux in clones with `core.autocrlf=true`
     (29 files converted and the same error before; none and a clean
     validation after). Not yet seen on Windows with the committed change.
4. The re-export as AP242, imported into the branch on 2026-11-12 on
   Peter's word (`vault-cad import-snapshot` of the package in
   `evidence/2026-11-12-windows-package-findings-01/` of the shared
   directory, run `2026-11-12-windows-package-findings-01`): all 44 files
   rewritten, every key kept, 44 overrides derived from the exporter's
   placements in context. Checked on the branch: 37 parts measured, all
   valid; the layout validates with one finding (the envelope's bytes; the
   finding about headers is gone); the flattened scene equals the one before
   the import with no placement differing by anything (37 parts, 17 groups,
   155 occurrences), only the 37 STEP files differ, and those are the AP242
   files whose geometry was compared with the AP214 ones on 2026-11-11; and
   against Inventor's own export of the root assembly 479 of 479 solids are
   where these records put them. `assembly/documentation.json` is pinned to
   the new scene, and `prepare_documentation.py` takes the package's
   `package.json` as the exporter's receipt.
   The documentation pipeline was run on the branch that day, at preview
   quality, into `.cache/manual-ap242/`: staging, `inspect`, meshes (37
   parts, all checks passed), 88 Cycles renders, the manual and its `check`
   (all passed). Against the published `docs/manual/manual.json` the steps,
   joints, supplementary items, group and callout numbers and every
   inventory row's name, number, counts and dimensions are the same; part
   ids, asset paths and image sizes differ, as they must, and there is no 3D
   viewer because that stage was not run. Two things turned up and are
   corrected: the site pages lost the earlier exporter's part ids, which an
   import takes out of `source.json` (`assembly/reference_scene.py` now reads
   them from `references/receipts/legacy-snapshot-991056/scene.json`, and
   the pages regenerate without a change); and the manual lost its line
   saying that quantities are CAD instance counts, which `mechanical-docs`
   printed only for the exporter's own scene (corrected there). Not done: a
   full-quality render, the viewer stage, and any publication; the published
   manual is still the one of 2026-10-23.
5. After the build: new parts written as code under `designs/`, manufactured
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
- `assembly/build_reference.py`. `make assembly` now builds the FreeCAD
  document of the whole enclosure, checks every solid's place and builds any
  sub-assembly too; the earlier script builds a document of the root only
  (checked by solid count, volume and bounds) and nothing reads its output.
  Remove it, or keep it?
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
