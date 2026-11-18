# Bowl forming plug

The tool a [bowl](../bowl/README.md) is vacuum formed over: the inside of the
bowl as a solid, standing on a base. A heated sheet is drawn down over it; the
plug gives the bowl its inside and the base gives the flange its upper face.

**A concept, like the bowl it follows.** It shows how the tool comes from the
part and what it would be; it is not to be made before the bowl is settled
and whoever forms the parts has seen it.

**Its numbers are in [the study](../../../studies/bowls/README.md)**
(`studies/bowls/study.json`, under `plug`; what follows is in
[`summary.md`](../../../studies/bowls/summary.md) there). `parameters.json` and
`checks.json` here are written from the study by its script.

## How the vacuum reaches the part

**No hose goes to the plug.** A vacuum former has a table with holes in it, or
a box under the table, and the pump draws through that. The sheet is clamped
in a frame, heated, and brought down over the tool until it seals round it
against the table; then everything under the sheet is drawn empty, the space
round the tool included, and the air above presses the sheet onto the tool.
The tool only has to let the air out from where the sheet would otherwise
trap it. A hose is fitted to the tool only where there is no former: then the
tool is built as a box of its own with a port for a workshop vacuum. That is
not drawn here.

Over a plug the sheet touches the top first and the foot last. Air is caught
in the turn where the plug's wall meets the base, and without a way out the
sheet bridges that turn instead of following it. So:

- **Vents.** Small holes through the base, evenly round the foot of the plug,
  in that turn. Guides advise no more than half a millimetre where a vent
  meets the formed surface, so that the sheet does not show it. Each is met
  from below by a wider hole, which is what makes so small a hole possible to
  make: the vent itself is only as long as its land.
- **Channels in the underside.** A vent ends in the underside of the base.
  Where the base lies flat on the table, between two of the table's holes, the
  vent would be shut. A ring channel through the feet of all the vents and
  spokes from it to the base's edge carry the air to the table's holes and to
  the space round the tool. Standing the tool on a piece of mesh does the
  same; the channels make it not depend on that.

The top of the plug needs no vent: the sheet meets it first and nothing is
caught there. The base is wider than the flange's trimmed edge, so that the
flange is formed flat to its edge.

What this rests on: published guides for the vents and the vacuum box (linked
from the bowl's README), and reasoning for the channels. None of it has been
tried here, and the former that will be used has not been looked at. To ask
whoever runs it: the size of the table and where its holes are, whether tools
stand on mesh there, and how high a tool may be.

## It is built from the bowl

`parameters.json` names the bowl as an input and holds no dimension of it.
`build.py` takes the bowl's solid and

1. finds the space inside it: a cylinder from inside the floor to the plane
   of the rim, less the bowl, is two pieces, and the one on the axis is that
   space;
2. enlarges it by the shrinkage allowance and turns it over;
3. sets it on the base;
4. drills the vents and their reliefs;
5. cuts the channels in the underside.

When the bowl changes, `make validate` says this part is to be built again,
and building it gives the new tool.

Each step holds what the kernel returns to a volume worked out another way and
stops when they differ. That caught a mistake while this was written: the
enlarged plug stood a tenth of a millimetre into its base, because
build123d's `scale` enlarges a shape about the origin it had before it was
moved. The space inside the bowl is worked out from the section's first
moment, without the kernel, and what the vents and channels take out from
their own dimensions (`plan` in `build.py`); the kernel's solid agrees with
both to less than a cubic millimetre.

## The frame

Z is the plug's axis and points up, away from the base. The underside of the
base is Z = 0.

## How it would be made, and what is open

- **Printed or machined.** As it stands it prints base down without
  support: the print check (`make print-check KEY=bowl-forming-plug`) finds
  flat faces on the plate, no face that looks down flatter than 45° and
  nothing that starts in mid-air. Every roof inside it leans: a relief ends
  in a cone and a channel is a triangle. `make print KEY=bowl-forming-plug`
  writes the mesh and shows it to a slicer. It is not sliced: that needs a
  printer and a material. A printed plug leaves its layers in a clear part
  (see the bowl): it would have to be filled and polished, or the plug turned
  from aluminium or tooling board, or given a polished insert for the floor.
  Which, and on which machine, is not decided.
- **Heat.** The tool has to stand the hot sheet for as many parts as are
  wanted. Twelve bowls and spares is a short run; the printing material has
  to be chosen for it.
- **The vents.** A printer may not make a hole of half a millimetre; they can
  be drilled into the reliefs after printing.
- **A plug or a cavity.** Over a plug the inside of the bowl touches the
  tool; in a cavity the outside would, and the vents would be in the bottom
  corner of the cavity. The same construction gives the cavity (the space
  outside the bowl instead of inside). Not built.
- **Several at once.** Six plugs on one plate would form six bowls from one
  sheet if the former is large enough. Not built.

## Building and checking it

```sh
make bowls                               # everything that follows from the study, built and checked
make part KEY=bowl-forming-plug          # this part alone, after the bowl
make picture KEY=bowl-forming-plug VIEWS=iso,below UP=+Z
```

The checks are: one solid, its size, its volume, and sixteen points: the top
of the plug, its wall where the bowl's is straight, the base, a vent that is
narrow near the surface, wide below and a cone between, the ring channel and
the base above it, a spoke and the base beside it.
