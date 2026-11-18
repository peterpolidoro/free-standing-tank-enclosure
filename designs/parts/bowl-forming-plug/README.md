# Bowl forming plug

The tool a [bowl](../bowl/README.md) is vacuum formed over: the inside of the
bowl as a solid, standing on a base. A heated sheet is drawn down over it; the
plug gives the bowl its inside and the base gives the flange its upper face.

**A concept, like the bowl it follows.** It shows how the tool comes from the
part and what it would be; it is not to be made before the bowl is settled
and whoever forms the parts has seen it.

| | |
| --- | --- |
| Overall | 200.85 mm across, 32.1 mm high |
| The plug | the bowl's inside, 0.5 % larger: 20.1 mm high, 164.2 mm across at its foot |
| The base | 12 mm thick, 15 mm wider all round than the flange's trimmed edge |
| Vents | twelve, 0.5 mm across, round the foot of the plug; each met from below by a 3 mm hole that narrows in a 45° cone and ends 2 mm under the surface |

## It is built from the bowl

`parameters.json` names the bowl as an input and holds no dimension of it.
`build.py` takes the bowl's solid and

1. finds the space inside it: a cylinder from inside the floor to the plane
   of the rim, less the bowl, is two pieces, and the one on the axis is that
   space;
2. enlarges it by the shrinkage allowance and turns it over;
3. sets it on the base;
4. drills the vents where the plug's wall turns into the base, which is where
   the sheet arrives last.

When the bowl changes, `make validate` says this part is to be built again,
and building it gives the new tool.

Each step holds what the kernel returns to a volume worked out another way and
stops when they differ. That caught a mistake while this was written: the
enlarged plug stood 0.105 mm into its base, because build123d's `scale`
enlarges a shape about the origin it had before it was moved. The space
inside the bowl is 378 302.97 mm³ by the section's first moment, without the
kernel, and the kernel gives the same.

## The frame

Z is the plug's axis and points up, away from the base. The underside of the
base is Z = 0, the upper face of the base Z = 12, the top of the plug
Z = 32.1.

## How it would be made, and what is open

- **Printed or machined.** As it stands it prints base down without
  support: the print check (`make print-check KEY=bowl-forming-plug`)
  finds one flat face on the plate, no face
  that looks down flatter than 45° and nothing that starts in mid-air. The
  first version failed it: each relief ended in a flat roof 3 mm across,
  and now ends in a cone. `make print KEY=bowl-forming-plug` writes the mesh
  (closed, 0.01 % from the solid's volume) and shows it to a slicer, which
  finds one manifold part. It is not sliced: that needs a printer and a
  material. A printed plug leaves its layers in a clear part
  (see the bowl): it would have to be filled and polished, or the plug turned
  from aluminium or tooling board, or given a polished insert for the floor.
  Which, and on which machine, is not decided.
- **Heat.** The tool has to stand the hot sheet for as many parts as are
  wanted. Twelve bowls and spares is a short run; the printing material has
  to be chosen for it.
- **Vents.** 0.5 mm at the surface is what the guides advise so that the
  sheet does not show them. A printer may not make so small a hole; they can
  be drilled into the reliefs after printing. Whether the former draws
  through the base or round it is to be asked.
- **A plug or a cavity.** Over a plug the inside of the bowl touches the
  tool; in a cavity the outside would. The same construction gives the
  cavity (the space outside the bowl instead of inside). Not built.
- **Several at once.** Six plugs on one plate would form six bowls from one
  sheet if the former is large enough. Not built.
- **The former.** Its platen, the sheet sizes it takes and who runs it are
  not known here.

## Building and checking it

```sh
make part KEY=bowl-forming-plug          # after the bowl: it is built against the bowl's part.step
make picture KEY=bowl-forming-plug VIEWS=iso,below UP=+Z
```

`checks.json` holds seventeen checks: one solid, its size, its volume, and
thirteen points: the top of the plug at 20.1 mm above the base, its wall at
mid-height, the base, a vent that is narrow near the surface, wide below and
a cone between, and the base between two vents.
