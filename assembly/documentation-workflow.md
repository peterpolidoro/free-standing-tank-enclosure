# Build the enclosure documentation

The accepted source is `references/` (Vault root 991056), one directory per
Vault file. The scene the documentation reads is flattened from it by
`mechanical-cad` into the ignored `.cache/reference-scene/`:

```sh
make reference-scene MECHANICAL_CAD="$HOME/Repositories/orb-weaver/mechanical-cad"
```

Staging refuses a scene that was not flattened from the tree as it stands, a
scene whose hash is not the one pinned in `assembly/documentation.json`, and a
STEP file that is not the one the scene records. The pin changes when the
references change or when `mechanical-cad` changes what it writes; review the
new scene (`mechanical_cad compare-scenes` against the old one) before
updating it. The flattened scene loads directly in mechanical-docs. FreeCAD
normalizes STEP geometry to mm, including inch/cm assets. The declared native
Y-up basis is applied once by the documentation loader.

`prepare_documentation.py` copies the frozen inputs into a **new** directory under
`.cache/`, adds `render.json`, `build-scope.json` and any authored
`assembly/inventory.json` or `assembly/instructions.json`, and validates them with mechanical-docs. Without an
authored inventory it generates CAD counts with unknown physical stock, in the
row order of the procurement sheet so that part numbers do not move. Without
instructions it produces an inventory-only project. Existing destinations are
refused, including counted stock or edited instructions: choose a new output
directory rather than regenerating over them.

The separate [procurement sheets](procurement/README.md) record intended build
quantities, stock and missing-hardware candidates. They are not silently merged
into the CAD-count inventory: `procurement_manifests.py` converts them at
staging time into the pipeline's `supplement.json` (items not modelled in CAD)
and the inventory's stock record, which are printed separately from the CAD
counts.

## Managed commands

Run the following from the project checkout, with a clean `mechanical-docs`
checkout for repeatable output. The preparation receipt records that
checkout's commit, its dirty flag and the input hashes. `assembly/render.json`
keeps Cycles with the denoiser and sets the outline budget, so small-part
views get outlines without outlining the entire enclosure.

```sh
cad_project="$PWD"
docs_tools="$HOME/Repositories/orb-weaver/mechanical-docs"
guix shell --pure -m manifest.scm -- python3 assembly/prepare_documentation.py --tools "$docs_tools"

cd "$docs_tools"
guix shell --pure -m manifest.scm -- python3 -B -m mechanical_docs inspect "$cad_project/.cache/manual/project"
guix shell --pure -m .guix/manifest-cad.scm -- FreeCADCmd mechanical_docs/cad_mesh.py --pass "$cad_project/.cache/manual/project" "$cad_project/.cache/manual/meshes" --max-triangles 50000
pixi run --locked -e render render "$cad_project/.cache/manual/project" "$cad_project/.cache/manual/meshes/meshes.json" "$cad_project/.cache/manual/renders"
guix shell --pure -m .guix/manifest-publish.scm -- python3 -B -m mechanical_docs manual "$cad_project/.cache/manual/project" --renders "$cad_project/.cache/manual/renders" --out "$cad_project/.cache/manual/manual" --meshes "$cad_project/.cache/manual/meshes/meshes.json"
guix shell --pure -m .guix/manifest-publish.scm -- python3 -B -m mechanical_docs check "$cad_project/.cache/manual/manual"
```

See mechanical-docs' `docs/environment.md` for Pixi initialization and host glibc
detection when launching Pixi from inside Guix. Keep its lockfile. For a different
workspace, pass `--output .cache/another-manual/project` to preparation and use that
path consistently. Reuse already verified renders when inputs and settings have
not changed (`--reuse` in the render stage): after a corrected
`assembly/instructions.json` only the overview and the steps whose state
changed are rendered again.

## Publish the built manual into the repository

Peter wants the generated documentation stored in this project repository and served
as a GitHub Pages site like his other projects. After a build whose `check` passed, copy
it into the tracked `docs/manual/` directory of the MkDocs site:

```sh
python3 assembly/publish_manual.py --manual "$cad_project/.cache/manual/manual" \
  --appendix-pdf "$cad_project/.cache/manual/manual-appendix/<id>.pdf"
```

The script verifies every copied file by hash, refuses a failed check report, keeps the
HTML, images, hotspots, PDFs, receipts and `manual.json` (not the check rasters) and
writes `docs/manual/SOURCE.json`, then regenerates the site pages with
`assembly/site_pages.py`: the front page with numbered subassembly callouts, one
page per subassembly definition with the instance count from the committed
scene, the parts with their this-build column, the joints, the supplementary
items, the draft steps and the build record. The model-viewer block appears
when the build ships `viewer/assembled.glb`, `viewer/exploded.glb` and
`viewer/hotspots.json`. Commit the package and the pages together with the
sources they were built from; `make site` builds the site locally and the Pages
workflow deploys it when a push to `main` changes the site. A package from a
documentation evidence run is published the same way with
`--evidence-run <name>`.

## Source-byte preservation

The original PowerShell metadata has UTF-8 BOMs and CRLF line endings. Earlier
Git JSON attributes normalized those files on commit, so a fresh clone at
`683c0ba` fails the export receipt despite an unchanged local acquisition.
The corrected `.gitattributes` exempts the exporter's records (now under
`references/receipts/`) from text conversion. Those four files must be staged with their original bytes along
with that change; they are recoverable from the accepted pilot-02 evidence.
Do not recalculate the receipt to bless normalized files or edit the raw snapshot.
Fresh checkouts with both `core.autocrlf=false` and `true` were checked against all
40 original payload hashes using the corrected Git blobs.

The old `inventory-raw.json` contains the original exporter serialization bug
(a string naming an OrderedDictionary). It remains immutable evidence. Build
current CAD inventory from the validated scene; Windows' newer exporter repairs
this bug but its lifecycle changes still need final qualification.

## Read-only geometry survey

```sh
cd "$cad_project"
guix shell --pure -m manifest.scm -- FreeCADCmd assembly/survey_reference.py
```

This writes `.cache/reference-survey/survey.json` and refuses an existing output.
Check the output and `REFERENCE_SURVEY_READY` marker: FreeCADCmd can exit zero
after reporting a Python exception. The survey composes placements, compares
native/world transforms, measures 479 solids and flags coincident instances of
the same part. It does not establish mounting clearance, structural capacity or
assembly order. Compact results are in `validation/2026-10-22-reference-survey.md`.

## Materials

`assembly/materials.json` is the curated materials file beside the STEP references
(`make materials-manifest` creates or refreshes it from the scene; `--check` validates it).
The CAD material is kept as `cad_claim` and never trusted silently; `material`, `finish` and
`mass_basis` stay null until a person sets `status` to `confirmed` or `corrected` with
`evidence`, `decided_by` and `decided_date`. Renders and glTF use `render.appearance` when set,
otherwise the CAD colour, otherwise a neutral material. Rules and the exporter's side of the
contract: vault-cad-tools `docs/authoring-and-materials.md`.
