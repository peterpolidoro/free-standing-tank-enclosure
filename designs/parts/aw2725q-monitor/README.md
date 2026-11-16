# Alienware AW2725Q reference model

The monitor without its stand, as far as the supplier's outline drawing shows
it: for designing the mount and for layout in the enclosure. It is a reference
model of a purchased item, not a manufactured part and not the maker's CAD
model. The [nominal envelope](../aw2725q-nominal-envelope/README.md) beside it
is the box around this model and stays as it is; it is the file published to
Vault.

| | |
| --- | --- |
| The thin panel | 609.51 × 355.97 mm, about 8 mm thick at its edge |
| The back | rises in four flat faces from the panel's edge to the rear housing |
| The rear housing | a dome with a rounded outline of about 478 × 278 mm |
| The collar around the mount | reaches the published depth of 72.63 mm |
| The mount recess | about 123 mm square, inside the collar |
| The mount plate | 60.20 mm behind the front of the screen |
| Four pads in the recess's corners | 61.50 mm behind the front, 1.30 mm proud of the plate |
| Four screw holes | on a 100 × 100 mm pattern, one in each pad |

One solid, filled. The stand, the port bay, connectors, vents, buttons and
threads are left out (`parameters.json`, `not_modelled`).

## What a mount has to know

**The mounting face lies in a recess.** The pads the screws go into are 61.5 mm
behind the front of the screen, and the collar around them is at 72.63 mm, so
the face is about 11 mm below its surroundings, in an opening about 123 mm
square. A flat plate larger than that opening does not reach the pads. The
stand's own plate sits in this recess.

The pattern is centred on the axis the stand turns about, 172.51 mm below the
top of the body, which is 5.475 mm above the body's centre and the centre of
the active display.

## Where the numbers come from

The source is Peter's `aw2725q-monitor.pdf` ("AW2725Q Outline Dimension", one
page; its hash is in `parameters.json`). The drawing calls its dimensions
nominal and itself not to scale.

- **Printed on the drawing** (`printed_mm`): the body's width, height and
  depth; the pivot axis below the top; the 100 × 100 mm pattern; the three
  depths in the mount recess (pads 61.50, plate 60.20, a lower band 60.50).
- **Read off the drawing's pictures** (`estimated_mm`): everything that places
  and shapes the housing, the collar and the recess, and that the pattern is
  centred on the pivot axis. Each was scaled by a dimension printed in the same
  view; the views agree with their printed dimensions within one per cent, so
  these are good to about 2 mm at best.
- **From the mounting standard, not from the drawing** (`assumed_mm`): the
  holes as 4 mm, 10 mm deep. A 100 × 100 mm pattern is M4 in the VESA
  standard; the thread, its depth and the screw length are in the monitor's
  manual and on the monitor.

## To measure on the monitor

A calliper and a depth gauge are enough. Each replaces a number in
`parameters.json`, and the model is built again from it.

| Measure | Replaces |
| --- | --- |
| Thickness of the panel at its edge | `edge_thickness` |
| Width and height of the mount recess | `mount_recess_size` |
| Depth of the recess: collar to plate, collar to a pad | checks 72.63 − 60.20 and 72.63 − 61.50 |
| Width and height of the collar around the recess | `mount_collar` |
| Hole centres to the top edge and to a side edge of the body | the pattern's centre |
| Thread and usable depth of the holes | `assumed_mm` |
| Width and height of the rear housing where it meets the back, and how far behind the front that is | `housing_rim` |
| Where the ports are and how far a plug and its cable stand out | not modelled yet |

## The frame

The envelope's: the origin is the centre of the body's front bounding
rectangle, X points right and Y up when looking at the screen in landscape, Z
points out of the screen towards the viewer. The front is Z = 0 and the model
lies in negative Z, so a depth d of the drawing is Z = −d.

## Building and checking it

`build.py` is written with build123d; `build(parameters)` returns the solid and
touches no file. From the `mechanical-cad` checkout, in its environment with
FreeCAD and build123d:

```sh
guix shell --pure -L .guix/modules -m manifest.scm -m .guix/manifest-build123d.scm -- FreeCADCmd tools/build_part.py --pass /path/to/this/project/designs/parts/aw2725q-monitor
```

It writes `part.step`, `receipt.json` and `facts.json`, which are not edited.
Building it again from unchanged inputs changes no file.

`checks.json` states what the model must satisfy, and the build fails when
one of its eighteen checks does: one solid, the published outer size, the
front on Z = 0 and centred, less material than the envelope's box; and
fourteen points of the mount, each of which has to be material or empty. In
each of the four holes of the 100 × 100 mm pattern 5 mm deep is empty, and
1 mm beyond a hole's bottom is material; a pad is material just under
Z = −61.5 and empty just above; the plate likewise at Z = −60.2, and open
between the pads; the collar likewise at Z = −72.63; and either side of the
recess's wall, 61.5 mm from its centre. What the kernel finds at each point
is recorded in `facts.json`, so `python3 -m mechanical_cad check` reads the
checks without a kernel.

Pictures without a window, from this project's directory (the model's frame
has Y up):

```sh
make picture KEY=aw2725q-monitor VIEWS=iso-back,below UP=+Y
```

The first build of this model passed its four checks and was wrong: the
housing's surface was twisted, which only the picture showed. The housing is
now lofted through superellipses, each one closed curve, where it was lofted
through rounded rectangles.
