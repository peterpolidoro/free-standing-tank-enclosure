"""A flat sheet that lies on the monitor's front: a stand-in for the acrylic the bowls are set on.

Its outline is the outline of the monitor's body, taken from the monitor's
interface, grown by `overhang` on every side. Its frame is the monitor's: the
underside is Z = 0, which is the front of the screen, and the sheet lies in
positive Z, towards the bowls.

`build(parameters, inputs)` returns the solid and touches no file.
"""


def build(parameters, inputs):
    from build123d import Pos, RectangleRounded, extrude

    from mechanical_cad import interfaces

    if parameters["units"] != "mm":
        raise ValueError("the dimensions are expected in millimetres")
    assumed = parameters["assumed_mm"]
    body = interfaces.feature(inputs["monitor"].interface, "body")
    if body["normal"] != [0.0, 0.0, 1.0] or body["x"] != [1.0, 0.0, 0.0]:
        raise ValueError("the monitor's outline is expected in its front, with x to the right")
    xs, ys = [p[0] for p in body["polygon"]], [p[1] for p in body["polygon"]]
    width = max(xs) - min(xs) + 2 * assumed["overhang"]
    height = max(ys) - min(ys) + 2 * assumed["overhang"]
    centre = (body["point"][0] + (max(xs) + min(xs)) / 2, body["point"][1] + (max(ys) + min(ys)) / 2)
    outline = RectangleRounded(width, height, assumed["corner_radius"])
    return Pos(centre[0], centre[1], body["point"][2]) * extrude(outline, amount=assumed["thickness"])
