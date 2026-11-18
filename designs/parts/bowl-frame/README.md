# Bowl frame

Keeps six [bowls](../bowl/README.md) in place over one monitor: a flat plate
with a hole for each bowl. The plate lies on the acrylic sheet; a bowl stands
on the sheet, through its hole, and cannot slide.

**A concept, not a released part.** The brief asks for "a frame to hold the
bowls, roughly six on each monitor" and says nothing more. The layout below
follows from the bowl as assumed and the monitor's drawing; the thickness, the
material and how the plate is located on the sheet are open.

| | |
| --- | --- |
| Plate | 609.51 × 355.97 mm, the outline of the [cover sheet](../display-cover-sheet/README.md); 6 mm thick |
| Holes | six of 156.76 mm, in three columns 196.5 mm apart and two rows 172 mm apart, about the centre of the lit area |
| Between two holes | 15.2 mm of plate between the rows, 39.7 mm between the columns |
| Between a hole and the edge | 8.1 mm at the upper edge, 19.1 mm at the lower, 29.9 mm at the sides |

## The layout, and how tight it is

The lit area of the display is 589.97 × 332.93 mm. Two bowls with a 160 mm
opening take 320 mm of its height, which leaves **12.93 mm** for everything
else. The layout here spends it so:

- The two rows are 172 mm apart. The openings of the bowls then end 0.47 mm
  inside the lit area at the top and at the bottom, so every opening lies
  over the picture, just.
- The flanges of two bowls, 170 mm across, are 2 mm apart between the rows.
- Along the width there is room: the columns stand in thirds of the lit
  area, 18.5 mm inside it at each side.
- The lit area is not centred on the monitor: it lies 5.48 mm above the
  body's centre, because the lower bezel is wider. So the holes of the upper
  row come within 8.1 mm of the plate's edge, and the flanges of that row
  end 1.5 mm inside the edge of the monitor's body.

So six bowls of this size fit one monitor with nothing to spare across its
height. A larger flange, a rim that is to be gripped, or a display that
begins a millimetre later than the drawing says, and they do not. A bowl of
150 mm would leave 33 mm. `build.py` works the layout out and **refuses** one
in which an opening leaves the lit area, a web is thinner than 6 mm or two
flanges come closer than 1 mm, and says by how much.

## It is built from three parts

`parameters.json` names its inputs and the layout; `build.py` takes

- the lit area from the monitor's `interface.json` (`active-display`),
- the bowl's solid: a hole is as wide as the bowl is at the plate's upper
  face, 155.76 mm for a 6 mm plate, and 0.5 mm more all round,
- the plate's outline from the cover sheet.

A plate of another thickness gets other holes without a number being typed:
a 6 mm plate meets the bowl on the radius between its floor and its wall, so
the bowl sits in its hole like a cup in a ring; from about 9 mm up it meets
the straight part of the wall.

## The frame

The monitor's, in X and Y: the origin is over the centre of the body's
front, X runs along the display's width and Y along its height. The
underside of the plate is Z = 0 and Z points up. `interface.json` names the
underside and the six seats, each the axis of a bowl; `checks.json` and the
interface together hold eighteen checks.

## How it would be made, and what is open

- **Cut from sheet.** Every face is flat or square to the plate, so a laser,
  a router or a water jet makes it in one pass. `make cut KEY=bowl-frame` in
  `mechanical-cad` writes the drawing (`.cache/cut/bowl-frame.dxf`, in
  millimetres, the plate seen from above) and checks it against the solid:
  seven closed loops, the outline and six holes, 4.88 m of cut. The plate
  is 610 × 356 mm, which is more than a small laser's bed.
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
- **The upper edge.** 8.1 mm of web along 600 mm of plate is weak in
  acrylic. A plate that overhangs the monitor at the top by a few
  millimetres, with the sheet, would cure it.

## Building and checking it

```sh
make part KEY=bowl-frame                 # after the monitor, the bowl and the cover sheet
make fit KEY=monitor-with-bowls SUBJECT='BOWL FRAME:1,BOWL:1,BOWL:2,BOWL:3,BOWL:4,BOWL:5,BOWL:6' CLEARANCE=3
```
