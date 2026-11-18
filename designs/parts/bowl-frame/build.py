"""The frame that keeps the bowls in place over one monitor: a flat plate with a hole for each bowl.

The plate lies on the acrylic sheet and has the sheet's outline. A bowl stands
on the sheet, through its hole, and the hole keeps it from sliding. It is cut
from sheet: every face is flat or square to the plate.

It is built against three parts and takes its numbers from them:

    monitor   the lit area, from the monitor's interface: the bowls are laid
              out about its centre
    bowl      the solid: a hole is as wide as the bowl is at the plate's upper
              face, plus a clearance; and from its interface how wide its
              opening is
    sheet     the outline of the plate

The frame of the plate is the monitor's in X and Y (origin at the centre of
the body's front, X to the right and Y up as the screen is looked at), with
the plate's underside at Z = 0 and Z up, towards the bowls' openings.

`layout(parameters, inputs)` works out where the bowls stand and how wide the
holes are and refuses an arrangement that does not fit; `build` cuts the plate.
Neither touches a file.
"""


def layout(parameters, inputs):
    """Where the bowls stand and what is left around them, as a dictionary; a ValueError when they do not fit."""
    from build123d import Align, Box, Pos

    from mechanical_cad import interfaces

    arrangement, assumed, limits = parameters["layout"], parameters["assumed_mm"], parameters["limits_mm"]
    display = interfaces.feature(inputs["monitor"].interface, "active-display")
    if display["normal"] != [0.0, 0.0, 1.0] or display["x"] != [1.0, 0.0, 0.0]:
        raise ValueError("the lit area is expected in the monitor's front, with x to the right")
    xs, ys = [p[0] for p in display["polygon"]], [p[1] for p in display["polygon"]]
    centre = (display["point"][0] + (max(xs) + min(xs)) / 2, display["point"][1] + (max(ys) + min(ys)) / 2)
    half = ((max(xs) - min(xs)) / 2, (max(ys) - min(ys)) / 2)

    # The bowl as it is: how wide where the plate's upper face meets it, how wide over all, how wide its opening.
    bowl = inputs["bowl"].build123d()
    thickness = assumed["thickness"]
    box = bowl.bounding_box()
    if thickness >= box.max.Z - 1e-9:
        raise ValueError("the plate is as thick as the bowl is high; the bowl would not reach the sheet")
    within = bowl & (Pos(0, 0, box.min.Z) * Box(4 * box.size.X, 4 * box.size.Y, thickness,
                                              align=(Align.CENTER, Align.CENTER, Align.MIN)))
    reach = within.bounding_box()
    widest = max(reach.max.X, -reach.min.X, reach.max.Y, -reach.min.Y)
    hole = widest + assumed["radial_clearance"]
    flange = max(box.max.X, -box.min.X, box.max.Y, -box.min.Y)
    opening = interfaces.feature(inputs["bowl"].interface, "opening-edge")["point"]
    opening = (opening[0] ** 2 + opening[1] ** 2) ** 0.5

    columns, rows = arrangement["columns"], arrangement["rows"]
    pitch = (arrangement["pitch_x"], arrangement["pitch_y"])
    seats = [(centre[0] + (i - (columns - 1) / 2) * pitch[0], centre[1] + (j - (rows - 1) / 2) * pitch[1])
             for j in range(rows) for i in range(columns)]

    sheet = inputs["sheet"].facts["bounding_box_mm"]
    # What was measured of the sheet carries the kernel's margin of 1e-7 mm; a tenth of a micron is the sheet's size.
    plate = {"min": [round(v, 4) for v in sheet["min"][:2]], "max": [round(v, 4) for v in sheet["max"][:2]]}
    spans = [(columns - 1) * pitch[0] / 2, (rows - 1) * pitch[1] / 2]
    found = {
        "seats": seats, "hole_diameter": 2 * hole, "bowl_diameter_at_upper_face": 2 * widest, "plate": plate,
        "opening_inside_display": min(half[k] - spans[k] - opening for k in (0, 1)),
        "web_between_holes": min(pitch[k] - 2 * hole for k in (0, 1) if (columns, rows)[k] > 1),
        "web_to_edge": min(min(x - hole - plate["min"][0], plate["max"][0] - x - hole,
                               y - hole - plate["min"][1], plate["max"][1] - y - hole) for x, y in seats),
        "gap_between_flanges": min(pitch[k] - 2 * flange for k in (0, 1) if (columns, rows)[k] > 1),
    }
    wrong = []
    if found["opening_inside_display"] < limits["opening_inside_display"] - 1e-9:
        wrong.append(f"the bowls' openings reach {-found['opening_inside_display']:.2f} mm beyond the lit area"
                     if found["opening_inside_display"] < 0 else
                     f"the bowls' openings stay only {found['opening_inside_display']:.2f} mm inside the lit area")
    for name, least in (("web_between_holes", "least_web"), ("web_to_edge", "least_web"),
                        ("gap_between_flanges", "least_gap_between_flanges")):
        if found[name] < limits[least] - 1e-9:
            wrong.append(f"{name.replace('_', ' ')} is {found[name]:.2f} mm, less than {limits[least]} mm")
    if wrong:
        raise ValueError("the bowls do not fit as laid out: " + "; ".join(wrong))
    return found


def build(parameters, inputs):
    from build123d import Align, Cylinder, Pos, RectangleRounded, extrude

    if parameters["units"] != "mm":
        raise ValueError("the dimensions are expected in millimetres")
    assumed = parameters["assumed_mm"]
    found = layout(parameters, inputs)
    low, high = found["plate"]["min"], found["plate"]["max"]
    thickness = assumed["thickness"]
    outline = RectangleRounded(high[0] - low[0], high[1] - low[1], assumed["corner_radius"])
    plate = Pos((low[0] + high[0]) / 2, (low[1] + high[1]) / 2, 0) * extrude(outline, amount=thickness)
    solid_volume = plate.volume
    for x, y in found["seats"]:
        plate -= Pos(x, y, -1) * Cylinder(found["hole_diameter"] / 2, thickness + 2,
                                           align=(Align.CENTER, Align.CENTER, Align.MIN))
    # Hold what the kernel cut to what a plate with these holes must be.
    from math import pi
    expected = solid_volume - len(found["seats"]) * pi * (found["hole_diameter"] / 2) ** 2 * thickness
    if abs(plate.volume - expected) > 1e-6 * expected:
        raise ValueError(f"the plate's volume is {plate.volume:.3f} mm3 where {expected:.3f} mm3 was expected")
    return plate
