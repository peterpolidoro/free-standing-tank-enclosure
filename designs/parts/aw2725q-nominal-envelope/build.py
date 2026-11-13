"""Alienware AW2725Q, stand-free nominal envelope: one box of the published outer size.

A layout reference, not a production part and not a model of the housing; what
it leaves out is listed in parameters.json ("approximations") and README.md.

The origin is the centre of the body's front bounding rectangle. X points
right and Y up when looking at the screen in landscape; Z points out of the
screen towards the viewer, so the front is Z = 0 and the body lies in
negative Z.

`build(parameters)` returns the shape and touches no file. The shape is built
with build123d (until 2026-11-13 with FreeCAD's Part module; the same box).
mechanical-cad/tools/build_part.py calls it and writes part.step, receipt.json
and facts.json beside this file.
"""


def build(parameters):
    from build123d import Align, Box

    if parameters["units"] != "mm":
        raise ValueError("the dimensions are expected in millimetres")
    d = parameters["dimensions_mm"]
    # the published dimensions have to add up before anything is built from them
    for total, parts in (("body_width", ("active_width", "bezel_left", "bezel_right")),
                         ("body_height", ("active_height", "bezel_top", "bezel_bottom"))):
        if abs(d[total] - sum(d[p] for p in parts)) > 1e-8:
            raise ValueError(f"{total} is not the sum of {', '.join(parts)}")
    width, height, depth = d["body_width"], d["body_height"], d["body_depth"]
    if min(width, height, depth) <= 0:
        raise ValueError("the body dimensions must be positive")
    # centred in X and Y, the front face on Z = 0 and the body behind it
    return Box(width, height, depth, align=(Align.CENTER, Align.CENTER, Align.MAX))
