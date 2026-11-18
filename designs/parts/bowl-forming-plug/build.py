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
    2. Turned over, with the rim's plane at Z = 0, and enlarged about the
       origin, which keeps that plane where it is.
    3. Set on a base plate, and joined to it across a flat face.
    4. Vents: small holes through the base round the foot of the plug, each
       met from below by a wider one that ends in a cone.

The frame: Z is the plug's axis and points up, away from the base; the
underside of the base is Z = 0.

Every solid the kernel returns is held to a volume worked out another way,
and the build stops when they differ: a boolean operation can return a valid
solid that is not the one asked for.

`build(parameters, inputs)` returns the solid and touches no file.
"""


def build(parameters, inputs):
    from math import cos, pi, radians, sin, tan

    from build123d import Align, Cone, Cylinder, Pos, Rot, scale

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
    base_radius = flange * grow + tool["base_margin"]
    base = Cylinder(base_radius, tool["base_thickness"], align=low)
    solid = base + Pos(0, 0, tool["base_thickness"]) * plug
    same(solid.volume, base.volume + plug.volume, "the plug on its base")
    if len(solid.solids()) != 1:
        raise ValueError("the plug and its base did not become one solid")

    # 4. Vents round the foot of the plug, where its wall turns into the base.
    count, across = tool["vent_count"], tool["vent_diameter"]
    foot = (top_radius - opening) * grow                # the width of that turn, seen from above
    if count:
        if across >= foot:
            raise ValueError(f"a vent of {across} mm is wider than the turn at the foot of the plug ({foot:.2f} mm)")
        if not 0 < tool["vent_land"] < tool["base_thickness"]:
            raise ValueError("the vent's land is more than nothing and less than the base's thickness")
        circle = (top_radius + opening) / 2 * grow
        # Each relief ends in a cone, so that its roof leans and the tool prints without support, base down.
        wide = tool["vent_relief_diameter"] / 2
        roof = (wide - across / 2) * tan(radians(tool["vent_relief_roof_deg"]))
        shoulder = tool["base_thickness"] - tool["vent_land"] - roof
        if wide <= across / 2 or shoulder <= 0:
            raise ValueError("the relief has to be wider than the vent, and its cone has to fit under the vent's land")
        before = solid.volume
        for k in range(count):
            angle = radians(360 * k / count)
            at = Pos(circle * cos(angle), circle * sin(angle), 0)
            solid -= at * Pos(0, 0, -1) * Cylinder(across / 2, tool["base_thickness"] + foot + 1, align=low)
            solid -= at * Pos(0, 0, -1) * Cylinder(wide, shoulder + 1, align=low)
            solid -= at * Pos(0, 0, shoulder) * Cone(wide, across / 2, roof, align=low)
        # A relief is a cylinder with a cone on it that narrows to the vent; the vent itself is counted from the
        # cone's tip upwards, and inside the cone only what the cone leaves of it.
        narrow = pi * (across / 2) ** 2
        relief = pi * wide ** 2 * shoulder + pi * roof / 3 * (wide ** 2 + wide * across / 2 + (across / 2) ** 2)
        removed = before - solid.volume
        least, most = count * (relief + narrow * tool["vent_land"]), count * (relief + narrow * (tool["vent_land"] + foot))
        if not least * (1 - 1e-6) <= removed <= most * (1 + 1e-6):
            raise ValueError(f"the vents removed {removed:.4f} mm3; between {least:.4f} and {most:.4f} mm3 was expected")
        if len(solid.solids()) != 1:
            raise ValueError("the vents cut the tool apart")
    return solid
