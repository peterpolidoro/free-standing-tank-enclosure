# One monitor with its bowls

The monitor lying face-up, the [cover sheet](../../parts/display-cover-sheet/README.md)
on its screen, the [bowl frame](../../parts/bowl-frame/README.md) on the sheet
and six [bowls](../../parts/bowl/README.md) standing on the sheet in the
frame's holes. It is the stack the brief describes for one monitor, drawn so
that it can be looked at and checked; every part of it but the monitor is a
concept.

The frame of the assembly is the monitor's own: the front of the screen is
Z = 0 and faces up, X runs along the display's width, Y along its height. The
sheet lies on the screen, the frame on the sheet, and the bowls stand on the
sheet in the frame's holes.

`assembly.json` is written by [the study](../../../studies/bowls/README.md)'s
script from `studies/bowls/study.json`, with a bowl at every seat of the
frame; where each stands is in `studies/bowls/summary.md`. Change the study,
not this file.

```sh
make assembly KEY=monitor-with-bowls     # one STEP file and one FreeCAD document, in .cache/assemblies/
make open KEY=monitor-with-bowls         # the FreeCAD window
make picture KEY=monitor-with-bowls VIEWS=iso,+z UP=+Z
make fit KEY=monitor-with-bowls SUBJECT='BOWL FRAME:1,BOWL:1,BOWL:2,BOWL:3,BOWL:4,BOWL:5,BOWL:6' CLEARANCE=3
```

`make bowls` does all of that after the study has changed. The fit check on
2026-11-18, with the study as it stood: nothing interferes; the frame and the
six bowls each touch the sheet; a bowl is 0.45 mm from the frame, measured
square to its surface (0.5 mm sideways); the flanges of two bowls in one
column are 1.97 mm apart.

Where this stack sits in the enclosure, and so the second monitor beside it,
waits for the monitors' mount.
