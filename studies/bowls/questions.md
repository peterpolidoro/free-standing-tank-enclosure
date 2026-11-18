# Bowls over the monitors: what is drawn, and what we need to know

Written by `studies/bowls/derive.py` from `studies/bowls/study.json`; do not edit. The questions are in the
script; the numbers follow the study.

## What is drawn so far

A shallow clear bowl, vacuum formed from thin sheet. It stands on the acrylic sheet that lies on a monitor, and a
flat frame with a hole for each bowl keeps it in place. Only two of its numbers come from the brief (about 16 cm
in diameter, 2 cm deep, roughly six on each monitor). The others are assumed, so that there is something to look
at and to correct:

| | |
| --- | ---: |
| Opening, inside at the rim | 160 mm |
| Depth inside | 20 mm |
| Flat floor | 136 mm across |
| Wall | leans outwards by 10°, with a radius of 10 mm into the floor |
| Rim | a flat flange 5 mm wide; 170 mm across over all |
| Water, filled to the rim | 378 ml |
| Wall thickness | about 1 mm |

## What fits on a monitor

The picture on the monitor is 590 × 333 mm. As drawn, 6 bowls stand over it in 3 columns and 2 rows, and every
opening lies over the picture, by 0.5 mm at the least; two rims are 2.0 mm apart at the nearest.
With a rim of 5 mm the largest opening for 6 bowls is 160.9 mm: the bowl as drawn is at that limit.

| Opening | Most bowls on one monitor |
| ---: | --- |
| 80 mm | 18, as 6 × 3 |
| 100 mm | 15, as 5 × 3 |
| 120 mm | 8, as 4 × 2 |
| 140 mm | 6, as 3 × 2 |
| 150 mm | 6, as 3 × 2 |
| 160 mm (as drawn) | 6, as 3 × 2 |

## Questions

1. Which diameter is 16 cm: the opening, the flat floor, or the bowl with its rim?
2. Is 2 cm the depth of the water or the height of the wall, and how much water is wanted in a bowl?
3. The wall: how steep should it be, and how large a radius into the floor? Does the floor have to be flat, and how much of it?
4. What swims in a bowl, how many to a bowl, and can it jump the wall?
5. What looks at the bowls and from where, and in which light? That decides how clear the floor and the wall have to be, and whether the frame between the bowls should be black.
6. The material: is clear PETG acceptable for the animals, and how are the bowls cleaned? Are they kept or thrown away, and how many are needed in all?
7. Are the bowls lifted out with water in them? A thin bowl bends when it is picked up full by its rim; it can be made stiffer if it has to be carried.
8. The monitor under the sheet is warm. Does the temperature of the water matter, and has it been measured on a monitor of this kind?
9. What keeps spilled water away from the monitors?
10. Would fewer, or more and smaller, bowls on a monitor serve as well as six? The table above says what fits.

## Pictures

From this project's directory, into its `.cache/pictures/` (they are not kept in the repository):

```sh
make section KEY=bowl CUT=+y                                  # the bowl's section, to scale: bowl-section-plus-y.svg
make picture KEY=monitor-with-bowls COLOUR=1 VIEWS=iso        # the bowls on a monitor, every part in a colour
make section KEY=monitor-with-bowls CUT=-y=-80.505         # the stack cut through a row of bowls
make bowl-variant NAME=120-eight SET='opening_diameter=120 columns=4 rows=2'   # another size, built beside this one
```
