"""The plug a bowl is vacuum formed over, made from the bowl itself.

A heated sheet is drawn down over this tool. The plug gives the bowl its
inside; the base it stands on gives the flange its upper face. So the tool is
the space inside the bowl, turned over, enlarged by what the sheet shrinks as
it cools, on a plate. It is built against the bowl's solid and has no
dimension of the bowl typed into it: when the bowl changes, this part is
reported stale and built again.

    1. The space inside the bowl: a cylinder that reaches from inside the
       floor to the plane of the rim and almost to the flange's edge, less the
       bowl, is two pieces, and the one on the axis is that space.
    2. Enlarged, and turned over with the rim's plane at Z = 0.
    3. Set on a base plate, and joined to it across a flat face.
    4. Vents: small holes through the base round the foot of the plug, where
       the sheet arrives last, each met from below by a wider hole that ends
       in a cone.
    5. Channels in the underside: a ring through the feet of the vents and
       spokes from it to the base's edge. A vent ends in the underside of the
       base; where the base lies flat on the former's table the channels
       carry the air from there to the table's own holes and to the space
       round the tool, which is under the sheet and is drawn empty as well.

Every roof inside the tool leans (the cones, and the two sides of a channel),
so that it prints base down without support.

The frame: Z is the plug's axis and points up, away from the base; the
underside of the base is Z = 0.

Every solid the kernel returns is held to a volume worked out another way,
and the build stops when they differ: a boolean operation can return a valid
solid that is not the one asked for. `plan` works out, without the kernel,
where the vents and channels are and how much they take out of the base; the
study's script uses it for this part's checks as well.

`build(parameters, inputs)` returns the solid and touches no file.
"""


def plan(tool, circle, base_radius, foot):
    """Where the vents and the channels are, and the volume they take out of the tool, without the kernel.

    `circle` is the radius the vents stand on, `base_radius` the base's, `foot`
    the width of the turn between the plug's wall and the base, in which a
    vent comes out. Returns the dimensions that follow, the angles of the
    vents and of the spokes in degrees, and `removed_least` and
    `removed_most`: a vent's last stretch, from the base's upper face into
    that turn, is between nothing and `foot` long.

    Where a relief or a spoke meets the ring, the ring is taken as straight;
    it is a hundred times wider than they are, and what that leaves out is
    less than a tenth of a cubic millimetre.
    """
    from math import asin, pi, radians, sin, sqrt, tan

    count, across = tool["vent_count"], tool["vent_diameter"]
    thickness, land = tool["base_thickness"], tool["vent_land"]
    wide, lean = tool["vent_relief_diameter"] / 2, tan(radians(tool["roof_deg"]))
    width, spokes = tool["channel_width"], tool["radial_channels"]
    if not 20 <= tool["roof_deg"] < 90:
        raise ValueError("the roofs inside the tool lean between 20 and 90 degrees above the base's underside")
    out = {"vent_angles": [360.0 * k / count for k in range(count)]}
    least = most = 0.0
    if count:
        if across >= foot:
            raise ValueError(f"a vent of {across} mm is wider than the turn at the foot of the plug ({foot:.2f} mm)")
        roof = (wide - across / 2) * lean            # the height of the cone a relief ends in
        shoulder = thickness - land - roof           # where the relief's straight part ends
        if wide <= across / 2 or not 0 < land < thickness or shoulder <= 0:
            raise ValueError("a relief has to be wider than its vent, and its cone has to fit under the vent's land")
        relief = pi * wide ** 2 * shoulder + pi * roof / 3 * (wide ** 2 + wide * across / 2 + (across / 2) ** 2)
        narrow = pi * (across / 2) ** 2
        least += count * (relief + narrow * land)
        most += count * (relief + narrow * (land + foot))
        out.update(wide=wide, roof=roof, shoulder=shoulder)
    if width:
        depth = width / 2 * lean                     # a channel is a triangle: its two sides are roofs
        if depth >= thickness / 2:
            raise ValueError("the channels are deeper than half the base")
        section = width * depth / 2
        cut = 2 * pi * circle * section              # the ring; its section is symmetric about the circle
        if count:
            if depth > out["shoulder"]:
                raise ValueError("the channels are deeper than the straight part of a relief")
            # What a relief and the ring share: level by level, the relief's disc within the channel's width.
            steps, shared = 2000, 0.0
            for i in range(steps):
                half = width / 2 * (1 - (i + 0.5) / steps)
                disc = pi * wide ** 2 if half >= wide else 2 * (half * sqrt(wide ** 2 - half ** 2) + wide ** 2 * asin(half / wide))
                shared += disc * depth / steps
            cut -= count * shared
        if spokes:
            if count:
                if spokes > count:
                    raise ValueError("there are more spokes than vents; each runs midway between two vents")
                step = 360.0 / count
                angles = [((j * count) // spokes + 0.5) * step for j in range(spokes)]
                if circle * sin(radians(step / 2)) <= width / 2 + wide:
                    raise ValueError("the vents stand too close together for a spoke between two of them")
            else:
                angles = [360.0 * j / spokes for j in range(spokes)]
            # A spoke from the ring's circle to the base's edge, less the curve of that edge and what it shares
            # with the ring's outer half.
            cut += spokes * (section * (base_radius - circle) - width ** 3 * depth / (96 * base_radius) - width ** 2 * depth / 6)
            out["spoke_angles"] = angles
        least += cut
        most += cut
        out["channel_depth"] = depth
    out.update(removed_least=least, removed_most=most)
    return out


def build(parameters, inputs):
    from math import cos, radians, sin

    from build123d import Align, Axis, Cone, Cylinder, Plane, Polygon, Pos, Rot, extrude, revolve, scale

    from mechanical_cad import interfaces

    if parameters["units"] != "mm":
        raise ValueError("the dimensions are expected in millimetres")
    tool, grow = parameters["tool_mm"], 1 + parameters["shrinkage"]["allowance"]
    low = (Align.CENTER, Align.CENTER, Align.MIN)

    def same(volume, expected, what, relative=1e-6):
        if abs(volume - expected) > relative * abs(expected):
            raise ValueError(f"{what}: the kernel gives {volume:.4f} mm3 where {expected:.4f} mm3 was expected")

    # 1. The space inside the bowl.
    bowl_input = inputs["bowl"]
    bowl = bowl_input.build123d()
    box = bowl.bounding_box()
    floor = interfaces.feature(bowl_input.interface, "floor")["point"][2]
    rim = interfaces.feature(bowl_input.interface, "rim")["point"][2]
    opening = interfaces.feature(bowl_input.interface, "opening-edge")["point"]
    opening = (opening[0] ** 2 + opening[1] ** 2) ** 0.5
    flange = max(box.max.X, -box.min.X, box.max.Y, -box.min.Y)
    reach = flange - 0.1 * (flange - opening)          # inside the flange's edge, outside the rim's radius
    start = (box.min.Z + floor) / 2                    # inside the floor's thickness
    block = Pos(0, 0, start) * Cylinder(reach, rim - start, align=low)
    pieces = (block - bowl).solids()
    on_axis = [s for s in pieces if s.is_inside((0, 0, (floor + rim) / 2))]
    if len(on_axis) != 1:
        raise ValueError(f"expected one piece of space on the bowl's axis, found {len(on_axis)} of {len(pieces)}")
    inside = on_axis[0]
    top_radius = max(inside.bounding_box().max.X, -inside.bounding_box().min.X)
    if top_radius > reach - 1e-3:
        raise ValueError("the space inside the bowl is not closed by the bowl at its rim; is the flange too narrow?")
    same(sum(s.volume for s in pieces) + (bowl & block).volume, block.volume, "the bowl and the space around it")

    # 2. Enlarged and turned over. It is enlarged first, about the bowl's origin: build123d's scale works in the
    # frame a shape had before it was moved, so a shape that was moved first is enlarged about another point than
    # the origin it now has (the first version of this did that, and the volume held in step 3 showed it). The
    # rim's plane is then at rim * grow; it goes to Z = 0, and half a turn about X puts the floor on top.
    plug = Rot(180, 0, 0) * (Pos(0, 0, -rim * grow) * scale(inside, grow))
    same(plug.volume, inside.volume * grow ** 3, "the plug enlarged")
    foot_plane, crown = plug.bounding_box().min.Z, plug.bounding_box().max.Z
    if abs(foot_plane) > 1e-6 or abs(crown - (rim - floor) * grow) > 1e-6:
        raise ValueError(f"the plug should stand on Z = 0 and be {(rim - floor) * grow:.4f} mm high; "
                         f"it reaches from {foot_plane:.6f} to {crown:.6f}")

    # 3. On its base.
    thickness = tool["base_thickness"]
    base_radius = flange * grow + tool["base_margin"]
    base = Cylinder(base_radius, thickness, align=low)
    solid = base + Pos(0, 0, thickness) * plug
    same(solid.volume, base.volume + plug.volume, "the plug on its base")
    if len(solid.solids()) != 1:
        raise ValueError("the plug and its base did not become one solid")

    # 4 and 5. Vents round the foot of the plug, where its wall turns into the base, and channels under the base.
    foot = (top_radius - opening) * grow                # the width of that turn, seen from above
    circle = (top_radius + opening) / 2 * grow
    found = plan(tool, circle, base_radius, foot)
    across, width = tool["vent_diameter"], tool["channel_width"]
    before = solid.volume
    for angle in found["vent_angles"]:
        at = Pos(circle * cos(radians(angle)), circle * sin(radians(angle)), 0)
        solid -= at * Pos(0, 0, -1) * Cylinder(across / 2, thickness + foot + 1, align=low)
        solid -= at * Pos(0, 0, -1) * Cylinder(found["wide"], found["shoulder"] + 1, align=low)
        solid -= at * Pos(0, 0, found["shoulder"]) * Cone(found["wide"], across / 2, found["roof"], align=low)
    if width:
        depth = found["channel_depth"]
        # A channel's section: a triangle on the underside, carried 1 mm below it so that no face of the cut lies
        # in the underside itself.
        section = [(-width / 2, -1), (width / 2, -1), (width / 2, 0), (0, depth), (-width / 2, 0)]
        solid -= revolve(Plane.XZ * Polygon(*[(circle + x, z) for x, z in section], align=None), Axis.Z)
        for angle in found.get("spoke_angles", []):
            spoke = Pos(circle, 0, 0) * extrude(Plane.YZ * Polygon(*section, align=None), amount=base_radius + 1 - circle)
            solid -= Rot(0, 0, angle) * spoke
    removed = before - solid.volume
    if not found["removed_least"] - 0.5 <= removed <= found["removed_most"] + 0.5:
        raise ValueError(f"the vents and channels removed {removed:.4f} mm3; between {found['removed_least']:.4f} and "
                         f"{found['removed_most']:.4f} mm3 was expected")
    if len(solid.solids()) != 1:
        raise ValueError("the vents and channels cut the tool apart")
    return solid
