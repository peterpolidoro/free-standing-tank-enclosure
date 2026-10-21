# Free-standing tank enclosure

STEP exchange pilot for the existing Vault assembly:

`$/DATA/PROJECTS/_PROJECTS BY LAB/SCHULZE (LAB)/ENCLOSURE/Free Standing Enclosure.iam`

The path was supplied by Peter (without the leading `DATA` folder; the Vault
server resolved it on 2026-10-21). Resolved identity: file-version 991056,
master 988153, version 5, revision 0, state Work in Progress, folder 953863,
model state `[Primary]`; 43 dependency versions in four folders. Windows
exported the part `ENCLOSURE TOP PANEL.ipt` (version 991092) and the assembly to
STEP with receipts. The panel is now in `references/ENCLOSURE TOP PANEL.step`:
FreeCAD 1.1.3 finds one valid solid with matching 47 × 1/8 × 47 inch extents.
The assembly loads as 479 valid solids. Windows accounted for the 24 extra native
solids as hidden bodies in one McMaster part. Linux verified the new export
against all 44 native input records and confirmed its STEP data matches the earlier
export exactly. Two other McMaster parts show 8.46% and 12.30% volume differences
between native and re-imported STEP; targeted checks remain before baseline
acceptance. The full assembly stays in shared evidence. See the
[latest review](validation/2026-10-21-native-pilot-review.md).

## Monitor reference and design requirement

The manager's brief requires design work in Inventor and completed records in
Vault. Native feature creation through the Inventor API is a proposed way to
minimize GUI work while retaining editable native files. Acceptance of
FreeCAD-authored production parts imported through STEP is not established.

A [nominal AW2725Q monitor reference](designs/reference-models/alienware-aw2725q/README.md)
is available as a parametric FCStd and a one-solid STEP envelope, generated from
the printed dimensions in Peter's supplier drawing. It includes an active-display
reference in FCStd and records the 100 × 100 mm mounting spacing without guessing
hole locations or fastening details. It is a stand-free layout reference, not a
production part or a detailed housing. FreeCAD validation passed; Inventor checks
are pending. A 3 × 2 array of nominal 160 mm bowls leaves only 12.93 mm total on
the display's short axis for all gaps and margins, before allowing for larger rims.

## Visual assembly manual

The project also aims to provide a primarily visual parts inventory and
step-by-step assembly manual, with a web version and printable PDF generated
from one instruction source. See [assembly manual requirements](assembly/README.md).
Part identities, quantities, subassemblies and placements must survive CAD export;
assembly order and tool access require explicit review and a physical walkthrough.
The separate `mechanical-docs` repository now contains a handoff and validated
synthetic STEP fixture. The manual and renderer remain implementation work.

## Ownership and layout

- `references/`: STEP exports of specific Vault versions, managed by the importer.
- `designs/`: editable FreeCAD documents or CAD scripts authored here.
- `step/`: authored STEP deliverables eligible for publication back to Vault.
- `drawings/`: supporting drawings and specifications.
- `assembly/`: visual manual requirements and future inventory/sequence sources.
- `vault-project.toml`: server identity and project locator; no credentials.
- `vault-lock.json`: imported provenance and, eventually, verified publications.
- `validation/`: geometry checks, acceptance decisions, and unresolved comparisons.
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
software. Automated FreeCAD import checks have run; full assembly completeness,
visual review, and the reverse publication pilot remain outstanding.

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
