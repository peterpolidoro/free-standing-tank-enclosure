# Free-standing tank enclosure

STEP exchange pilot for the existing Vault assembly:

`$/PROJECTS/_PROJECTS BY LAB/SCHULZE (LAB)/ENCLOSURE/Free Standing Enclosure.iam`

The path was supplied by Peter. Concrete Vault IDs, dependency versions, and model
states have **not** been resolved. No CAD models have been imported yet.

## Ownership and layout

- `references/`: STEP exports of specific Vault versions, managed by the importer.
- `designs/`: editable FreeCAD documents or CAD scripts authored here.
- `step/`: authored STEP deliverables eligible for publication back to Vault.
- `drawings/`: supporting drawings and specifications.
- `vault-project.toml`: server identity and project locator; no credentials.
- `vault-lock.json`: imported provenance and, eventually, verified publications.
- `.cache/`: ignored Inventor originals, API probes, and temporary conversions.

To modify an imported design, preserve the reference and create a design under
`designs/`, exporting your deliverable under `step/`. Refreshing references must
not overwrite those authored files. Vault remains the source for imported
Inventor models; this repository is the source for Linux-authored designs.

## Tools

Reusable commands live in the sibling `vault-cad-tools` repository. From that
repository on Linux:

```sh
guix shell --pure -m manifest.scm -- python3 run.py --project ../free-standing-tank-enclosure status
```

On Windows, run `pixi install --locked` in the tools checkout, then
`pixi run --locked cli --project ..\free-standing-tank-enclosure status`.
The tools repository owns the shared Windows Python/Git environment and lockfile;
this project does not duplicate that environment.
See its README and `docs/exchange-protocol.md`. No STEP conversion or Vault
upload is implemented by this project's files.

The project manifest provides FreeCAD for local authoring. The tools' smaller
manifest is sufficient for metadata and transfer work. Neither installs Autodesk
software. FreeCAD import and Inventor round-trip validation remain pilot tasks.

Use ordinary Git initially. `.gitattributes` preserves STEP bytes and disables
automatic text merging. Large files may justify LFS later, but the initial
publication packager deliberately rejects LFS pointers. Raw native downloads
remain in `.cache/`; retain editable `.FCStd` or scripts in Git.

## Publication

Commit a new `step/*.step` deliverable before preparing its publication request.
The request names an explicit destination folder and fails if a file already
exists there. The Windows uploader and update/check-in behavior are not yet
implemented. A prepared request is not an upload authorization receipt or a
successful publication. Never replace the Inventor source with a STEP file.

## Pilot acceptance

1. Resolve the root assembly and dependency versions, including shared library
   components outside the project folder.
2. Export one part and the assembly, recording exact source versions, model
   state, STEP protocol, translator version, and SHA-256.
3. Import and inspect solids, dimensions, placement, and completeness in FreeCAD.
4. Create and commit a simple new STEP part; add it to an agreed Vault folder.
5. Open/reference the part in Inventor and verify an acceptable assembly workflow.
6. Repeat a source refresh and test conflict handling before bulk import.
