# Free-standing tank enclosure

The documentation site, with the pictorial manual and the build documents: [https://peterpolidoro.github.io/free-standing-tank-enclosure/](https://peterpolidoro.github.io/free-standing-tank-enclosure/) (built from `docs/` by `.github/workflows/pages.yml`; `make site` builds it locally).

**Status (2026-11-10).** The enclosure is being assembled from the published
draft manual, and the notes from that build will correct it. The CAD snapshot
below is accepted as reference geometry. Nothing in the manual is reviewed or
physically validated, no purchase list is approved, and the monitor and bowl
changes are not designed.

## The CAD snapshot

The source is the Vault assembly

`$/DATA/PROJECTS/_PROJECTS BY LAB/SCHULZE (LAB)/ENCLOSURE/Free Standing Enclosure.iam`

resolved on 2026-10-21 as file-version 991056 (master 988153, version 5,
revision 0, state Work in Progress, model state `[Primary]`), with 43 dependency
versions in four folders.

The accepted snapshot is kept under `references/`, one directory per Vault
file: 37 parts, each with its STEP file, what Vault and Inventor said about it
and what FreeCAD measures of it, and 7 assemblies, each listing its direct
children and where they sit. Flattened, they place 155 occurrences. A FreeCAD
reconstruction reproduces the 479 solids, the volume and the bounds of the full
assembly export. The gap between native and exported body counts was hidden
geometry, and the large volume differences were Inventor's default-accuracy
measurements; see the [review](validation/2026-10-21-pilot-02-review.md). On
2026-11-12 the placements were checked against a new export of the whole
assembly from Inventor: each of its 479 visible solids is where these records
put it, within 1e-10 mm. The part files total 19.83 MiB, the largest 3.73 MiB.

No assembly is stored as a file of its own. `make assemblies` lists the seven,
and `make assembly` builds the whole enclosure, or with `KEY=<key>` any one of
them, as one STEP file and one FreeCAD document under the ignored
`.cache/assemblies/`; `make open` builds it if need be and opens it in the
FreeCAD window. They are for looking at, in FreeCAD or any other CAD
system; they hold positions and shapes, not constraints or features, and the
part files and manifests under `references/` stay the source.

A [dimensional survey](validation/2026-10-22-reference-survey.md) flags two
coincident tank instances that must not be counted as purchases without review.

## Visual assembly manual

A primarily visual parts inventory and step-by-step manual, as a web site and a
printable PDF generated from one instruction source; see the
[requirements](assembly/README.md). The `mechanical-docs` pipeline builds it
from the snapshot and the curated files under `assembly/`
([build recipe](assembly/documentation-workflow.md)), and the built package is
committed under `docs/manual/` and served by the site.

The published package is the phase-1 draft of 2026-10-23: the enclosure without
tanks and backlight, as a front page with the subassemblies drawn apart,
picture-led parts cards, six subassembly views, 16 joint close-ups and 18 draft
steps (PDF 59 pages; with the technical appendix 77). The step order is a draft
to be corrected from the physical build. Quantities are CAD instance counts,
not stock or an approved bill of materials; the
[stock and completeness sheets](assembly/procurement/README.md) track what is
still unknown.

## Monitor reference and the Inventor requirement

A [nominal AW2725Q monitor reference](designs/parts/aw2725q-nominal-envelope/README.md)
is available as a one-solid STEP envelope, built by a program from the printed
dimensions in Peter's supplier drawing.
It records the 100 × 100 mm mounting spacing without guessing hole locations or
fastening details. It is a stand-free layout reference, not a production part.
It passed validation in FreeCAD and in Inventor, and it is the one file this
project has published to Vault (2026-10-22, Vault version 994252). A 3 × 2 array
of nominal 160 mm bowls leaves only 12.93 mm in total on the display's short
axis for all gaps and margins, before allowing for larger rims.

The manager's brief requires design work in Inventor and completed records in
Vault. Peter's decisions of 2026-10-23 (`mechanical-cad/docs/direction.md`) are
that new parts are written as code that produces STEP and reach Inventor users
as referenced STEP files, with Inventor used for authoring only when a
collaborator insists. The two have not been reconciled: whether code-authored
parts referenced from Inventor satisfy the brief is open. Authoring natively
through the Inventor API was demonstrated on Windows (named parameters,
sketches, an extrusion, an edit and a restore) and stays available.

## Ownership and layout

- `references/`: what Vault holds, at exact versions. `parts/<key>/` and
  `assemblies/<key>/` hold one Vault file each; `receipts/` holds the
  exporter's records, unchanged. Written by the import command, never by hand.
- `designs/`: what is authored here. `parts/<key>/` holds a part's program,
  its parameters and checks, and the STEP file built from them, which is the
  deliverable.
- `drawings/`: supporting drawings and specifications.
- `assembly/`: manual sources/build recipe, geometry survey, and procurement audit sheets.
- `vault-project.toml`: server identity and project locator; no credentials.
- `vault-lock.json`: an index derived from the directories under
  `references/` and `designs/`; it shows what an import changed and repeats
  the verified publications.
- `validation/`: geometry checks, acceptance decisions, and unresolved comparisons.
- `.cache/`: ignored. Inventor originals, API probes, temporary conversions,
  the scene flattened from `references/` that the scripts and the manual
  read (`make reference-scene`), and the assemblies built for looking at
  (`make assembly`).

To modify an imported design, preserve the reference and create a design under
`designs/`. Refreshing references must not overwrite those authored files.
Vault remains the source for imported Inventor models; this repository is the
source for Linux-authored designs.

The layout is specified in `mechanical-cad/docs/layout-specification.md` and
checked from that repository with `python3 -m mechanical_cad validate`. The
STEP files exported from Inventor are AP242 (Peter, 2026-11-11) since the
re-export of 2026-11-12: the same Vault versions, exported again by the
package mode of the Windows exporter, with normalised headers. Each has the
geometry of the AP214 file it replaced.

## Tools

`make` alone lists this project's short commands:

```sh
make validate                    # references/ and designs/ against the layout
make assemblies                  # the assemblies, and which are built
make assembly                    # the whole enclosure, as one STEP file and one FreeCAD document
make assembly KEY=camera-frame   # one assembly of that list
make open                        # build the whole enclosure if need be, then open it in FreeCAD
make open KEY=camera-frame       # the same for one assembly
make reference-scene             # the scene the manual and the scripts under assembly/ read
make site                        # the documentation site
```

The CAD commands are run by the `mechanical-cad` checkout, which is looked for
beside this repository. When it is somewhere else, say so once in `local.mk`
here, which Git ignores: `MECHANICAL_CAD = /path/to/mechanical-cad`. Where
there is no `make` (Windows), `python -m mechanical_cad assemblies PROJECT`
from that checkout prints the same list. `make open` starts the FreeCAD that
`guix shell` provides and returns when its window is closed.

Reusable Vault commands live in the sibling `vault-cad-tools` repository. From that
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

`status` there compares each directory under `references/` with the index in
`vault-lock.json` and each published part with the file that was published.
References are written by `import-snapshot` there, from the package the
Windows exporter writes.

The project manifest provides FreeCAD for local authoring. The tools' smaller
manifest is sufficient for metadata and transfer work. Neither installs Autodesk
software. FreeCAD imports and assembly reconstruction checks pass. Visual/design
review, a complete hardware BOM, a physical stock count and a validated assembly
procedure remain outstanding.

Use ordinary Git initially. `.gitattributes` preserves STEP bytes and disables
automatic text merging. Large files may justify LFS later, but the initial
publication packager deliberately rejects LFS pointers. Raw native downloads
remain in `.cache/`; retain editable `.FCStd` or scripts in Git.

## Publication

The deliverable of an authored part is `designs/parts/<key>/part.step`; build
and commit it before preparing its publication request (`prepare-publish
designs/parts/<key>/part.step`). The file is named `<key>.step` in Vault unless
another name is given. The request names an explicit
destination folder and fails if a file already exists there. Adding a new file
is implemented and was done once, on Peter's request, for the monitor envelope
(the record is `designs/parts/aw2725q-nominal-envelope/vault.json`); updating
or checking in an existing file is not. A prepared request is not an authorization and not a publication: nothing
is written to Vault without Peter's explicit request. Never replace the
Inventor source with a STEP file.

## Pilot acceptance

1. Resolve the root assembly and dependency versions, including shared library
   components outside the project folder. Done 2026-10-21.
2. Export one part and the assembly, recording exact source versions, model
   state, STEP protocol, translator version, and SHA-256. Done 2026-10-21.
3. Import and inspect solids, dimensions, placement, and completeness in FreeCAD.
   Done 2026-10-21.
4. Create and commit a simple new STEP part; add it to an agreed Vault folder.
   Done 2026-10-22.
5. Open/reference the part in Inventor and verify an acceptable assembly workflow.
   Partly: placing the envelope, and keeping the STEP as a referenced source in
   a wrapper part, were shown in a disposable copy on Windows. Nothing of that
   is in Vault, and the workflow has not been agreed with the designers.
6. Repeat a source refresh and test conflict handling before bulk import. Not
   done.

## Licence

Material authored for this project (scripts, manifests, documentation and the
designs made for it) is released under the 3-clause BSD licence, copyright
Howard Hughes Medical Institute; see [LICENSE](LICENSE).

Component models that originate from suppliers (for example the McMaster-Carr
parts under `references/parts/`) are not covered by that licence.
They are kept as geometry references and remain subject to their suppliers'
terms.
