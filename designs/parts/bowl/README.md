# Bowl, vacuum formed

The clear bowl the fish swim in. It stands on the acrylic sheet that lies on a
monitor, six to a monitor, each in a hole of the [bowl frame](../bowl-frame/README.md).

**A concept, not a released part.** The brief gives two numbers, "about 16 cm
in diameter and 2 cm deep", and says the bowls are vacuum formed and clear.
Everything else is assumed so that there is something to look at, to lay out
and to ask about. No mould is to be made from it before the questions below
are answered.

**Its numbers are in [the study](../../../studies/bowls/README.md)**:
`studies/bowls/study.json` holds what was asked for and what is assumed, and
[`summary.md`](../../../studies/bowls/summary.md) there says what follows (how
wide the bowl is over its flange, how large the flat floor, how much water).
`parameters.json`, `checks.json` and `interface.json` here are written from
the study by its script; change the study, not them.

## The shape

A solid of revolution with one wall thickness throughout: a flat floor, a
radius into a wall that leans outwards, a radius at the rim and a flat flange
round the opening. Seven numbers give it: the opening and the depth, which
were asked for, and the wall's thickness, its draft, the two radii and the
flange, which are assumed. The model is nominal: a formed part is thinner
where the sheet was stretched most.

## The frame

The origin is the centre of the underside of the floor, which is the face
that rests on the sheet. Z is the bowl's axis and points up, out of the
opening. `interface.json` names the underside, the floor inside, the rim (the
upper face of the flange), the axis, and two points other parts are laid out
by: where the opening's edge is and where the flat floor ends.

## How it would be made

Vacuum formed from clear sheet over the [forming plug](../bowl-forming-plug/README.md),
which is built from this part's solid, and trimmed round the flange. What that
asks of the shape, from published design guides (linked below; none of this
has been tried here):

- **Draft.** A part formed over a plug shrinks onto it and needs draft to come
  off. The guides give 3° to 5° as the least for a plug and one gives 8° for
  stiff sheet such as PETG.
- **Radii.** Not smaller than the sheet is thick; 3 to 5 mm is advised.
- **Depth.** A bowl an eighth as deep as it is wide is a shallow draw, so the
  wall thins little.
- **Which face is clear.** A formed part takes the tool's finish on the face
  that touches the tool. Over a plug that is the *inside* of the bowl, floor
  included, and the outside keeps the sheet's own surface. The floor is what
  the display is seen through, so the top of the plug has to be as smooth as
  the floor should be clear: a printed plug shows its layers in the part.
  That is the first thing a trial part will show.
- **Shrinkage.** The plug is larger than the bowl's inside by an allowance.
  The guides give 0.4 to 0.8 % in general; the trial part, measured, gives
  the number.

The sheet is not chosen. Clear PETG is the usual sheet for forming clear
parts; whether it suits the animals and the cleaning is a question below.

## To ask the researcher

1. Which diameter is 16 cm: the opening, the flat floor, or the bowl with its
   rim? Six bowls with a 160 mm opening fit over one display with half a
   millimetre to spare ([which sizes fit](../../../studies/bowls/options.md)).
2. Is 2 cm the depth of the water or the height of the wall, and how much
   water is wanted?
3. The wall: how steep, and how large a radius into the floor? Does the floor
   have to be flat, and how much of it?
4. What swims in it, how many to a bowl, and can it jump the wall?
5. What looks at the bowls and from where, and in which light? That decides
   how clear the floor and the wall have to be, and whether the frame should
   be black.
6. The material: is PETG acceptable for the animals, and how are the bowls
   cleaned? Are they kept or thrown away, and how many are needed?
7. Are the bowls lifted out with water in them? A thin bowl with 0.4 litre
   in it bends when it is picked up by its rim.
8. The monitor under the sheet is warm. Does the water's temperature matter,
   and has it been measured on a monitor of this kind?
9. What keeps spilled water from the monitors?

## Building and checking it

`build.py` is written with build123d: the section, with its four corners
rounded about two centres so that the wall has one thickness, turned about
the axis. From this project's directory:

```sh
make bowls                               # everything that follows from the study, built and checked
make part KEY=bowl                       # this part alone
make picture KEY=bowl VIEWS=iso,+x UP=+Z
```

The checks are: one solid, its size, its volume (the section's first moment
about the axis times 2π, worked out without the kernel; the kernel gave the
same to 6 parts in 10⁹), and fourteen points that must be material or empty:
the floor and the space above and under it, the wall just inside each of its
faces and the space just outside them, which holds its thickness to a few
hundredths, the flange, the opening. The interface adds ten.

## Sources

- [Mayku: design principles for tooling](https://help.mayku.me/design-principles-for-tooling) and
  [tool design and creation](https://help.mayku.me/tool-design-and-creation): draft, vents, tool finish.
- [Plastic Mouldings Northern: design rules for vacuum formed components](https://plasticmouldingsnorthern.co.uk/blogs/design-rules-for-large-format-vacuum-formed-components/): draft for male and female tools.
- [Monash dFab: die design guide](https://madamakers.gitbook.io/monash-ada-workshops-dfab/vacuum-forming/home/die-design-guide): radii, shrinkage.
- [RapidMade: PETG and clear thermoformed parts](https://rapidmade.com/petg-plastic-strengths-weaknesses-and-how-to-get-crystal-clear-thermoformed-parts/) and
  [Universal Plastics design guide](https://www.universalplastics.com/wp-content/uploads/2014/03/UP-Design-Guide-v1.21.pdf): the tool's finish on a clear part.
