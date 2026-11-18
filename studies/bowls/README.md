# The bowls over a monitor: one file of numbers

The bowl, the plug it is formed over, the frame that holds six over a monitor
and the stand-in for the acrylic sheet all follow from
[`study.json`](study.json). Change a number there, run one command, and every
part, every check and the assembly follow.

| | |
| --- | --- |
| [`study.json`](study.json) | **The file to edit.** What the brief asked for, what is assumed, how many bowls and how they are spaced, the frame, the sheet, the plug; and what each number means |
| [`summary.md`](summary.md) | The numbers as they stand, written by the script: the bowl, how it fits the display, the frame, the plug, where each bowl stands |
| [`options.md`](options.md) | Which bowl sizes fit a monitor, for several flanges, and the most bowls of each size; written by `make bowl-options` |
| [`derive.py`](derive.py) | The script. It needs Python and nothing else |

## Adjusting the bowls

```sh
make bowl-show SET='opening_diameter=150 flange_width=8'   # what would follow, at once; nothing is written
make bowl-options                                          # which sizes fit: options.md
# then edit studies/bowls/study.json, and:
make bowls                                                 # write, build, check, fit, print check, cut file
make open KEY=monitor-with-bowls                           # look at it in FreeCAD
```

`make bowl-show` and `make bowl-options` need no CAD and answer in a second:
whether six bowls of another size fit, what is left round them, how much
water a bowl holds, how large the flat floor is. `make bowls` takes about two
minutes. It stops at the first thing that does not hold: a layout that does
not fit (with the limit it breaks and the amount), a part whose solid does not
pass its checks, or two parts that share volume.

To look at another set of numbers beside the tracked parts without changing
them:

```sh
make bowl-variant NAME=150-deep SET='opening_diameter=150 depth=25 wall_draft_deg=15 flange_width=8'
```

builds the same parts with those numbers as a project of their own under the
ignored `.cache/bowl-variants/150-deep/` and checks them the same way.

A number is named by its place in the study, `bowl.asked.opening_diameter`, or
by its last word where only one number has it, `opening_diameter`. `thickness`
and `corner_radius` occur twice (`frame.thickness`, `sheet.thickness`).

## What can be changed

- **The bowl**: the opening and the depth (asked for), the wall, its draft,
  the radius at the floor, the radius at the rim, the flange.
- **How many and where**: columns and rows over the lit area. A pitch of
  `"auto"` spaces the bowls evenly where the limits allow it, and otherwise
  half way between the smallest pitch the flanges and the frame need and the
  largest that keeps the openings over the picture. A number in its place is
  taken as given, and refused if it breaks a limit.
- **The limits**: how far inside the lit area an opening has to stay, the
  least frame between two holes and at the plate's edge, the least gap between
  two flanges.
- **The frame**: its thickness (the holes follow the bowl's shape at that
  height), the clearance round a bowl, its corners.
- **The sheet**: thickness and how far it, and the frame on it, reach beyond
  the monitor.
- **The plug**: the shrinkage allowance, the base, the vents, the channels in
  its underside, the angle of every roof inside it.

The monitor is not part of the study: its lit area and its outline are read
from `designs/parts/aw2725q-monitor/interface.json`.

## Who writes what

`derive.py` is the one writer of the `parameters.json`, `checks.json` and
`interface.json` of the four parts (`bowl`, `bowl-forming-plug`, `bowl-frame`,
`display-cover-sheet`), of `designs/assemblies/monitor-with-bowls/assembly.json`,
and of `summary.md` and `options.md`. Do not edit those; each says so. The
programs (`build.py`) and the README files are written by hand, and
`mechanical-cad`'s build command writes each `part.step`, `receipt.json` and
`facts.json`.

The checks the script writes are points of a part that must be material or
empty, worked out from the study's numbers without a CAD kernel: where the
wall is at a height, where the flange is, where a hole of the frame ends. The
programs work the same surfaces out their own way when they build the solids,
so a check that fails is a disagreement between the two, not a number that
was forgotten.

## Tried

On 2026-11-18 a variant with ten numbers changed at once (a 150 mm opening,
25 mm deep, 15° of draft, a 15 mm radius at the floor, an 8 mm flange, a
1.5 mm wall, a 3 mm radius at the rim, a 9 mm frame, sixteen vents, eight
spokes) was written, built, checked and tested for fit without any other
edit: five parts, ninety checks, no interference, and the plug passes the
print check.
