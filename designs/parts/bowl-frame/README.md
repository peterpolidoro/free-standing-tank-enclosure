# Bowl frame

Keeps six [bowls](../bowl/README.md) in place over one monitor: a flat plate
with a hole for each bowl. The plate lies on the acrylic sheet; a bowl stands
on the sheet, through its hole, and cannot slide.

**A concept, not a released part.** The brief asks for "a frame to hold the
bowls, roughly six on each monitor" and says nothing more. The layout follows
from the bowl as assumed and the monitor's drawing; the thickness, the
material and how the plate is located on the sheet are open.

**Its numbers are in [the study](../../../studies/bowls/README.md)**:
`studies/bowls/study.json` holds how many bowls there are, how they are
spaced, the limits a layout has to keep and the plate's thickness, and
[`summary.md`](../../../studies/bowls/summary.md) there says what follows:
the pitches, how far the openings stay inside the lit area, how much plate is
left between two holes and at the edge, where each bowl stands.
`parameters.json`, `checks.json` and `interface.json` here are written from
the study by its script.

## The layout, and how tight it is

The lit area of the display is 589.97 × 332.93 mm. Two bowls with a 160 mm
opening take 320 mm of its height, which leaves **12.93 mm** for everything
else: the flanges of the two rows between them, and whatever the openings
stay inside the picture at the top and at the bottom. Along the width there
is room. The lit area is not centred on the monitor: it lies 5.48 mm above
the body's centre, because the lower bezel is wider, so the upper row comes
closest to the plate's edge.

So six bowls of that size fit one monitor with next to nothing to spare
across its height. A larger flange, a rim that is to be gripped, or a display
that begins a millimetre later than the drawing says, and they do not.
[`options.md`](../../../studies/bowls/options.md) in the study lists which
sizes fit, the largest opening for a flange, and how many smaller bowls
would.

`build.py` works the layout out again from the parts it is built against and
**refuses** one in which an opening leaves the lit area, a web is thinner than
the limit or two flanges come closer than the limit, and says by how much. The
study's script refuses the same before anything is built.

## It is built from three parts

`build.py` takes

- the lit area from the monitor's `interface.json` (`active-display`),
- the bowl's solid: a hole is as wide as the bowl is at the plate's upper
  face, plus the clearance,
- the plate's outline from the [cover sheet](../display-cover-sheet/README.md).

A plate of another thickness gets other holes without a number being typed:
a thin plate meets the bowl on the radius between its floor and its wall, so
the bowl sits in its hole like a cup in a ring; a thicker one meets the
straight part of the wall.

## The frame

The monitor's, in X and Y: the origin is over the centre of the body's
front, X runs along the display's width and Y along its height. The
underside of the plate is Z = 0 and Z points up. `interface.json` names the
underside and a seat for each bowl, the bowl's axis.

## How it would be made, and what is open

- **Cut from sheet.** Every face is flat or square to the plate, so a laser,
  a router or a water jet makes it in one pass. `make cut KEY=bowl-frame`
  writes the drawing (`.cache/cut/bowl-frame.dxf`, in millimetres, the plate
  seen from above) and checks it against the solid: closed loops, the outline
  and a hole for each bowl, and the area of the solid's face. The plate is
  the size of the monitor, which is more than a small laser's bed.
- **The material.** Not chosen. Black acrylic would also mask the display
  between the bowls, if that helps the cameras; that is a question for the
  researcher.
- **Locating it.** Nothing here holds the plate to the sheet or the sheet to
  the monitor. With so little to spare across the display's height, how the
  three are registered matters more than it would otherwise: pins, a lip
  round the sheet, or the plate and the sheet cut as one stack.
- **One plate or two.** One monitor's plate is drawn. The two monitors lie
  side by side; one plate over both would fix the bowls of both, and needs
  the monitors' positions, which are not decided.
- **The upper edge.** The web between the upper row's holes and the plate's
  edge is narrow for acrylic. A sheet, and a plate on it, that reach a few
  millimetres beyond the monitor at the top would cure it: `sheet.overhang`
  in the study.

## Building and checking it

```sh
make bowls                               # everything that follows from the study, built and checked
make part KEY=bowl-frame                 # this part alone, after the monitor, the bowl and the cover sheet
make fit KEY=monitor-with-bowls SUBJECT='BOWL FRAME:1,BOWL:1,BOWL:2,BOWL:3,BOWL:4,BOWL:5,BOWL:6' CLEARANCE=3
```
