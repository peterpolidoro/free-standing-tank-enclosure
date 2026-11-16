"""Alienware AW2725Q without its stand: a reference model for designing a mount.

More than the nominal envelope beside it (aw2725q-nominal-envelope) and less
than the monitor: the thin panel, the back that rises in four flat faces to
the rear housing, the housing as a dome, the collar on it that reaches the
published depth, and
inside the collar the mount recess with its four raised pads and screw holes.
It is one solid, filled; the stand, the ports, vents, buttons and every
fastener are left out.

parameters.json says where each number comes from. `printed_mm` are printed on
the supplier's outline drawing. `estimated_mm` were read off the pictures of
that drawing, which says of itself "not to scale"; they place and shape the
housing and the recess and are to be measured on the monitor. `assumed_mm`
come from the mounting standard, not from the drawing.

The frame is the envelope's: the origin is the centre of the body's front
bounding rectangle, X points right and Y up when looking at the screen in
landscape, Z points out of the screen towards the viewer. The front is Z = 0
and everything lies in negative Z, so a depth d of the drawing is Z = -d.

`build(parameters)` returns the shape and touches no file.
mechanical-cad/tools/build_part.py calls it and writes part.step, receipt.json
and facts.json beside this file.
"""


def build(parameters):
    from math import cos, pi, sin

    from build123d import Align, Box, Cylinder, Pos, Rectangle, RectangleRounded, Spline, extrude, loft, make_face

    if parameters["units"] != "mm":
        raise ValueError("the dimensions are expected in millimetres")
    printed, estimated, assumed = (parameters[k] for k in ("printed_mm", "estimated_mm", "assumed_mm"))
    width, height, depth = printed["body_width"], printed["body_height"], printed["body_depth"]
    centre, back = Align.CENTER, Align.MAX

    # The stand turns about an axis the drawing places below the top of the body.
    # The housing and the mount pattern are centred on it (estimated: the
    # pictures show them there within a millimetre).
    axis_y = height / 2 - printed["pivot_axis_below_top"]

    def rectangle(section, y):
        return Pos(0, y, -section["depth"]) * Rectangle(section["width"], section["height"])

    def squircle(section, y):
        """A superellipse |x/a|^n + |y/b|^n = 1 at the depth of the section, as a face.

        One closed curve that starts on the +X axis, so that a loft through
        several of them pairs each point with the one above it. Rounded
        rectangles, with eight edges each, came out twisted.
        """
        a, b, n = section["width"] / 2, section["height"] / 2, section["exponent"]
        points = []
        for i in range(96):
            angle = 2 * pi * i / 96
            c, s = cos(angle), sin(angle)
            r = (abs(c / a) ** n + abs(s / b) ** n) ** (-1 / n)
            points.append((r * c, r * s))
        return Pos(0, y, -section["depth"]) * make_face(Spline(*points, periodic=True))

    rim = estimated["housing_rim"]
    sections = [rim] + estimated["housing_sections"]
    depths = [s["depth"] for s in sections]
    edge = estimated["edge_thickness"]
    if not (0 < edge < rim["depth"] and depths == sorted(depths) and depths[-1] < depth):
        raise ValueError("the sections must go back from the panel's edge, in order, and end short of the published depth")

    # the panel; the back rising from its edge, in four flat faces, to the
    # rectangle around the housing's rim; and the housing as a dome on that
    panel = Box(width, height, edge, align=(centre, centre, back))
    cover = loft([rectangle({"depth": edge, "width": width, "height": height}, 0.0), rectangle(rim, axis_y)], ruled=True)
    housing = loft([squircle(s, axis_y) for s in sections])

    # The collar around the mount stands on the dome and is taken to be what
    # reaches the published depth; the recess inside it is a square pocket down
    # to the plate.
    plate, pad = printed["mount_plate_z"], printed["mount_pad_z"]
    recess, pad_size = estimated["mount_recess_size"], estimated["mount_pad_size"]
    collar = estimated["mount_collar"]
    if not (edge < plate < pad < depth and pad_size < recess / 2 and recess < min(collar["width"], collar["height"])):
        raise ValueError("the mount plate and its pads must lie inside the collar")
    rim_of_collar = extrude(Pos(0, axis_y, -depth) * RectangleRounded(collar["width"], collar["height"], collar["corner_radius"]),
                            amount=depth - plate)
    body = panel + cover + housing + rim_of_collar
    body -= Pos(0, axis_y, -plate) * Box(recess, recess, depth, align=(centre, centre, back))

    # four pads in its corners, proud of the plate, each with a screw hole
    spacing = (printed["mount_pattern_horizontal"], printed["mount_pattern_vertical"])
    corners = [(sx, sy) for sx in (-1, 1) for sy in (-1, 1)]
    inset = recess / 2 - pad_size / 2
    for sx, sy in corners:
        if abs(spacing[0] / 2 - inset) > pad_size / 2 - assumed["mount_hole_diameter"] or \
           abs(spacing[1] / 2 - inset) > pad_size / 2 - assumed["mount_hole_diameter"]:
            raise ValueError("a screw hole does not lie well inside its pad")
        body += Pos(sx * inset, axis_y + sy * inset, -plate) * Box(pad_size, pad_size, pad - plate, align=(centre, centre, back))
    for sx, sy in corners:
        body -= Pos(sx * spacing[0] / 2, axis_y + sy * spacing[1] / 2, -pad) * Cylinder(
            assumed["mount_hole_diameter"] / 2, assumed["mount_hole_depth"], align=(centre, centre, Align.MIN))

    # nothing reaches outside the published envelope
    return body & Box(width, height, depth, align=(centre, centre, back))
