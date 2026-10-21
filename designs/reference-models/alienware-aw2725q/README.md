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

`AW2725Q-nominal-envelope.FCStd` contains an editable parametric box and an active
display construction plane. The `Dimensions` object holds the nominal sizes.
`AW2725Q-nominal-envelope.step` contains only the single closed envelope solid;
the display plane is excluded. `parameters.json` defines the inputs, assumptions
and provenance. `validation.json` records the actual FreeCAD save/reopen,
parameter-change and STEP reimport checks, with hashes. Inventor validation is
pending. Do not put this reference in `step/` as a production publication payload.

From the project repository root, regenerate with the managed environment:

```sh
guix shell --pure -m manifest.scm -- FreeCADCmd designs/reference-models/alienware-aw2725q/build_reference.py
```

The script writes beside itself. Re-running may produce different file hashes
because native/STEP writers include metadata; unchanged dimensions should yield
the same geometry. Keep the validation receipt with the files it describes.

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
This FreeCAD reference supports open-source inspection. The Windows agent is
asked to create a matching native Inventor reference with named dimensions and
verify import/placement. Production design authoring and native Vault check-in
remain separate qualification work.

## Native Inventor proof (2026-10-21, pilot 02)

The Windows agent ran `vault-cad-tools/windows/Invoke-NativeParameterPilot.ps1`
with this parameters.json: six named user parameters, dimensioned sketches and
an extrusion, native save/reopen, depth edit 72.63→80→72.63 mm, save and STEP
export. All 29 checks passed without GUI interaction. The existing Linux STEP
passed Inventor bounds/volume checks; the native export independently passes
FreeCAD checks with the same nominal bounds and volume. See native-validation.json.
Native IPT scratch files remain outside Git; this is a reference, not a finished mount.
