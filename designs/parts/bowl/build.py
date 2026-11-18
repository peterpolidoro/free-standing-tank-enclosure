"""The bowl the fish swim in: a shallow dish formed from clear sheet.

A solid of revolution with one wall thickness throughout: a flat floor, a
radius into a wall that leans outwards, a radius at the rim and a flat flange
around the opening. It is the part as designed, with a nominal wall; a formed
part is thinner where the sheet was stretched most.

The frame: the origin is the centre of the underside of the floor, which is
the face that rests on the acrylic sheet, and Z points up along the bowl's
axis, out of its opening. The floor's upper face is at Z = wall thickness and
the upper face of the flange, the rim, at Z = wall thickness + inside depth.

parameters.json says which numbers were asked for and which are assumed.
`profile(parameters)` gives the section in the plane through the axis, as
(radius, height) pairs, and is what the checks and the README's numbers are
worked out from. `build(parameters)` returns the solid and touches no file;
mechanical-cad/tools/build_part.py calls it and writes part.step, receipt.json
and facts.json beside this file.
"""


def profile(parameters):
    """The corners of the section before they are rounded, and the radius that rounds each.

    The inside surface runs floor, wall, rim: (0, t), a1, a2, a3. The outside
    surface is the same line moved out by the wall thickness: b3, b2, b1,
    (0, 0). Rounding a1 with the floor's corner radius and b1 with that radius
    plus the wall, and a2 with the rim's radius and b2 with that radius less
    the wall, gives arcs about the same two centres, so the wall has one
    thickness all the way.
    """
    from math import cos, radians, sin, tan

    asked, assumed = parameters["requested_mm"], parameters["assumed_mm"]
    rim, depth = asked["inside_diameter_at_rim"] / 2, asked["inside_depth"]
    t, draft = assumed["wall_thickness"], radians(assumed["wall_draft_deg"])
    floor_radius, rim_radius, flange = assumed["floor_corner_radius"], assumed["rim_radius"], assumed["flange_width"]
    if not 0 <= draft < radians(60):
        raise ValueError("the wall's draft is between 0 and 60 degrees")
    if rim_radius < t:
        raise ValueError("the rim's radius cannot be smaller than the wall: the outside of the bend would have none")
    turn = tan((radians(90) - draft) / 2)          # a radius r takes r * turn of each line it joins
    floor_corner = rim - depth * tan(draft)        # where the inside of the wall would meet the floor
    if floor_corner - floor_radius * turn <= 0:
        raise ValueError("the floor's corner radius leaves no flat floor")
    if (floor_radius + rim_radius) * turn > depth / cos(draft):
        raise ValueError("the wall is too short for its two radii")
    if flange <= rim_radius * turn:
        raise ValueError("the flange is narrower than the rim's radius needs")
    # The outside of the wall: the inside line moved by t along (cos, -sin).
    def outside_at(z):
        s = (z - (t + depth - t * sin(draft))) / cos(draft)
        return rim + t * cos(draft) + s * sin(draft)

    inside = [(0.0, t), (floor_corner, t), (rim, t + depth), (rim + flange, t + depth)]
    outside = [(rim + flange, depth), (outside_at(depth), depth), (outside_at(0.0), 0.0), (0.0, 0.0)]
    radii = {1: floor_radius, 2: rim_radius, 5: rim_radius - t, 6: floor_radius + t}
    return inside + outside, radii


def build(parameters):
    from build123d import Axis, Plane, Polygon, fillet, revolve

    if parameters["units"] != "mm":
        raise ValueError("the dimensions are expected in millimetres")
    corners, radii = profile(parameters)
    section = Polygon(*corners, align=None)
    for index, radius in sorted(radii.items()):
        if radius <= 0:
            continue                       # a rim radius equal to the wall leaves a sharp outside corner
        x, y = corners[index]
        vertex = min(section.vertices(), key=lambda v: (v.X - x) ** 2 + (v.Y - y) ** 2)
        section = fillet(vertex, radius)
    # The section is drawn in a plane's own x and y; in the plane XZ those are the radius and the height.
    return revolve(Plane.XZ * section, Axis.Z)
