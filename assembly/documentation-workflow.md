# Build the enclosure documentation

The accepted source is `references/enclosure/` (Vault root 991056). The original
40 payload hashes and scene/receipt hashes must match before staging. The source
scene loads directly in mechanical-docs; no scene rewrite is needed. FreeCAD
normalizes STEP geometry to mm, including inch/cm assets. The declared native
Y-up basis is applied once by the documentation loader.

`prepare_documentation.py` copies the frozen inputs into a **new** directory under
`.cache/`, adds `render.json` and any authored `assembly/inventory.json` or
`assembly/instructions.json`, and validates them with mechanical-docs. Without an
authored inventory it generates CAD counts with unknown physical stock. Without
instructions it produces an inventory-only project. Existing destinations are
refused, including counted stock or edited instructions: choose a new output
directory rather than regenerating over them.

The separate [procurement sheets](procurement/README.md) record intended build
quantities, stock and missing-hardware candidates. They are not silently merged
into the CAD-count inventory. The documentation agent is reviewing support for
supplementary non-geometric inventory.

## Managed commands

Run the following from the project checkout. `mechanical-docs` commit `27f9581`
is the reviewed baseline; use a clean, reviewed checkout for repeatable output.
The preparation receipt records the actual commit, dirty flag and input hashes.
Rendering config keeps Cycles/OIDN and limits expensive outlines to 400,000
triangles; this retains small-part outlines without outlining the entire enclosure.

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
path consistently. Reuse already verified renders when inputs/settings have not
changed; the first production inventory already exists in shared evidence.

This session verified preparation, exact-copy receipts, the clean baseline loader,
existing-output refusal and malformed/tampered input rejection. It did not rebuild
all production images/PDFs with this new config. The earlier 12-page production
inventory PDF and all 38 renders were independently checked against their receipts.

## Publish the built manual into the repository

Peter wants the generated documentation stored in this project repository. After a
build whose `check` passed, copy it into the tracked `documentation/` directory:

```sh
python3 assembly/publish_manual.py --manual "$cad_project/.cache/manual/manual" \
  --appendix-pdf "$cad_project/.cache/manual/manual-appendix/<id>.pdf" --name enclosure
```

The script verifies every copied file by hash, refuses a failed check report, keeps the
HTML, images, hotspots, PDFs, receipts and `manual.json` (not the check rasters) and
writes `documentation/enclosure/SOURCE.json`. Commit the package together with the
sources it was built from. A package from a documentation-agent evidence run is
published the same way with `--evidence-run <name>`.

## Source-byte preservation

The original PowerShell metadata has UTF-8 BOMs and CRLF line endings. Earlier
Git JSON attributes normalized those files on commit, so a fresh clone at
`683c0ba` fails the export receipt despite an unchanged local acquisition.
The corrected `.gitattributes` exempts raw `references/enclosure/*.json` from
text conversion. Those four files must be staged with their original bytes along
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
