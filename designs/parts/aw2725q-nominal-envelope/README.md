# Alienware AW2725Q reference envelope

A stand-free **nominal envelope**, for layout of the Schulze monitor enclosure.
This is a supplier reference model, not a production part or a detailed model
of the monitor housing. The source is Peter's `aw2725q-monitor.pdf`, page 1,
which explicitly labels its dimensions nominal and its drawing not to scale.
Only printed dimensions are used; no dimensions are inferred by scaling the image.

| Quantity | Nominal mm |
| --- | ---: |
| Body width × height × maximum depth | 609.51 × 355.97 × 72.63 |
| Active display width × height | 589.97 × 332.93 |
| Left / right bezel | 9.77 / 9.77 |
| Top / bottom bezel | 6.04 / 17.00 |
| Mounting pattern spacing | 100 × 100 |

Origin is the center of the body's front bounding rectangle. X points right,
Y up, and Z toward the viewer looking at the screen in normal landscape
orientation. The front is Z=0 and the body extends to Z=-72.63 mm. In the
face-up installation, positive Z points toward the bowls. The active display's
center is Y=+5.48 mm because the upper and lower bezels differ.

`build.py` builds the single closed envelope solid from `parameters.json`,
which defines the inputs, the assumptions and the provenance. It is written
with build123d, a Python library on the OpenCASCADE kernel. The active
display is described there by its size and bezels; it is not part of the
solid. `checks.json` states what the solid must satisfy (one solid, the
published outer size, the front on Z = 0 and centred, the volume of the box).
`part.step`, `receipt.json` and `facts.json` are written by the build command
and are not edited.

From the `mechanical-cad` checkout, in its environment with FreeCAD and
build123d (its README, "Guix packages"; the first use compiles the kernel's
Python bindings, about twenty minutes):

```sh
guix shell --pure -L .guix/modules -m manifest.scm -m .guix/manifest-build123d.scm -- FreeCADCmd tools/build_part.py --pass /path/to/this/project/designs/parts/aw2725q-nominal-envelope
```

Building it again from unchanged inputs changes no file. FreeCAD writes and
measures the file; `receipt.json` names build123d and its version beside it.

Until 2026-11-13 the program built the box with FreeCAD's `Part` module. It
was rewritten with build123d that day, the first part of a project written
with it, and the result compared: one solid of six faces, and the volume, the
area, the centre of mass and the bounding box are the same to the last digit.
`part.step` differs from the file before in 14 of its 187 lines, each only
in the sign of a zero in a direction (`-0.` then, `0.` now).

An earlier form of this model was a parametric FreeCAD document with a
construction plane for the active display, and the STEP exported from it was
copied to `step/` and added to Vault on 2026-10-22 as the first publication
pilot (`vault.json`; master 994251, version 994252). The file built here is
the same solid, by measurement: one solid, the same bounding box and the same
volume (15 758 333.161 mm³). Its bytes differ from the published file's,
because the header is now normalised and the product is named after the part,
and the validator says so. The checks made on the earlier files, in FreeCAD
and in Inventor, are recorded in
`validation/2026-10-22-aw2725q-envelope-freecad.json` and
`validation/2026-10-22-aw2725q-envelope-inventor.json`. It is a pilot payload
and a layout reference, not a production part.

The full rectangular box approximates the curved body. It does not model the
stand, connectors, cables, ventilation, buttons, corner radii, fastener threads,
engagement depth, recesses, or display recess. The 100 × 100 mm mounting pattern
is recorded as data only: no mounting holes or unverified hole datum are created.
The PDF also contains rear Z callouts, but these are not used to invent a detailed
mounting interface. Nominal dimensions alone provide no installation clearance;
verify the actual monitor and mounting details before designing brackets.

For a preliminary 3 × 2 grid of 160 mm **outer-diameter** bowls, the unused active
display width is 109.97 mm and the unused height is only 12.93 mm, summed over
all gaps and edge margins. Confirm the bowl rim dimensions and whether the entire
bowl footprint must lie over the active display. No bowl or retaining frame has
been designed or approved yet.

The project brief requires design work in Inventor and final records in Vault.
This FreeCAD reference supports open-source inspection. On Windows a matching
native Inventor reference with named dimensions was created and edited as a
fixture, and two envelopes were placed in a disposable copy of the assembly.
How production parts are authored, and whether natives are checked in, is not
settled; see the project README.

## Native Inventor proof (2026-10-21, pilot 02)

The Windows agent ran `vault-cad-tools/windows/Invoke-NativeParameterPilot.ps1`
with this parameters.json: six named user parameters, dimensioned sketches and
an extrusion, native save/reopen, depth edit 72.63→80→72.63 mm, save and STEP
export. All 29 checks passed without GUI interaction. The existing Linux STEP
passed Inventor bounds/volume checks; the native export independently passes
FreeCAD checks with the same nominal bounds and volume. See native-validation.json.
Native IPT scratch files remain outside Git; this is a reference, not a finished mount.
