"""Write a DRAFT assembly sequence (assembly/instructions.json) from the accepted scene.

The order is a modular proposal grouped by subassembly and by height, not a validated
procedure: Peter records the real order from the physical build and this file is then
edited by hand. Every installed occurrence appears exactly once (the loader requires
it); steps that place deferred or conditional items are labelled in their captions and
scoped by assembly/build-scope.json. Nothing here asserts fasteners or tool access.
"""
from __future__ import annotations

import json
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CENTRE = [597.0, 597.0, 1213.0]


def zup(t):
    return (t[0][3], -t[2][3], t[1][3])


def main():
    scene = json.loads((ROOT / "references/enclosure/scene.json").read_text(encoding="utf-8-sig"))
    scope = json.loads((ROOT / "assembly/build-scope.json").read_text(encoding="utf-8"))
    deferred = set(scope["deferred_occurrence_ids"])
    conditional = [g["id"] for g in scope["conditional_groups"]]
    occ = {o["id"]: o for o in scene["occurrences"]}
    names = {p["id"]: p["name"] for p in scene["parts"]}
    z = {oid: zup(o["transform_world"])[2] for oid, o in occ.items()}

    def kids(parent, name_part=None):
        out = [oid for oid, o in occ.items() if o["parent_id"] == parent and (name_part is None or name_part in names[o["part_id"]])]
        return sorted(out, key=lambda k: (names[occ[k]["part_id"]], k))

    frame = "FREE STANDING FRAME:1"
    rails = [o for o in kids(frame) if "T-Slotted Framing" in names[occ[o]["part_id"]] and "96in" not in names[occ[o]["part_id"]]]
    columns = kids(frame, "96in")
    long_ext = kids(frame, "47065T271")
    connectors = kids(frame, "47065T245")
    low = lambda ids: [o for o in ids if z[o] < 400]
    high = lambda ids: [o for o in ids if z[o] > 2200]
    mid = lambda ids: [o for o in ids if 400 <= z[o] <= 2200]
    supports = kids(frame, "PANEL LOWER SUPPORT")
    casters = []
    for g in sorted(a["id"] for a in scene["assemblies"] if a["parent_id"] == frame):
        casters += kids(g)
    cam = "CAMERA FRAME:1"
    cam_struct = [o for o in kids(cam) if any(k in names[occ[o]["part_id"]] for k in ("T-Slotted Framing", "Corner Bracket"))]
    cam_mech = [o for o in kids(cam) if any(k in names[occ[o]["part_id"]] for k in ("Spring", "Bearing", "Shoulder Screw", "SPRING ROLLER", "ROLLER MOUNT PLATE", "SPRING MOUNT PLATE"))]
    cam_plates = [o for o in kids(cam) if "CAMERA MOUNT PLATE" in names[occ[o]["part_id"]]]
    assert sorted(cam_struct + cam_mech + cam_plates) == sorted(kids(cam)), "camera frame split must cover all children"

    steps = []
    def step(sid, add, caption, view="overview", requires="previous"):
        add = [a for a in add if a not in deferred]
        if not add:
            return
        req = [steps[-1]["id"]] if (requires == "previous" and steps) else []
        steps.append({"id": sid, "requires": req, "add": add, "view": view, "caption": caption})

    step("bottom-frame", low(rails) + low(connectors) + low(long_ext),
         "Lay out the bottom frame: lower rails and corner connectors. Order among rails is free; square the frame before tightening. Hardware: see joints main_frame_joints.")
    step("casters", casters,
         "Bolt each caster to its mounting plate and attach the four plates under the bottom frame corners (joints caster_to_plate, caster_plate_to_frame). Hardware unverified.")
    step("columns", columns, "Stand the four 96 in columns on the bottom frame corners.")
    step("middle-rails", mid(rails) + mid(connectors) + mid(long_ext), "Add the mid-height rails and extrusions between the columns.")
    step("top-frame", high(rails) + high(connectors) + high(long_ext), "Close the top frame: upper rails and corner connectors.", view="top-region")
    step("lower-supports", supports, "Fit the eight panel lower supports (left and right) to the frame (joint lower_support_to_frame).")
    clamp_ids = []
    for g in sorted(a["id"] for a in scene["assemblies"] if a["id"].startswith("TOGGLE CLAMP ASSEMBLY")):
        clamp_ids += kids(g)
    step("toggle-clamps", clamp_ids, "Assemble the four toggle-clamp mounts (two clamps each) and attach them to the columns (joints clamp_to_mount, clamp_mount_to_frame).")
    step("camera-frame-structure", cam_struct, "Assemble the camera frame extrusions and corner brackets (joint camera_frame_joints).", view="top-region")
    step("camera-frame-mechanism", cam_mech, "Fit the roller and spring mechanism: roller plates, spring plates, rollers, bearings, shoulder screws, springs (joint spring_roller).", view="top-region")
    step("camera-plates", cam_plates, "Fit the camera mount plates (joints camera_plates, camera_attachment). The camera itself is not in CAD.", view="top-region")
    for n in range(1, 5):
        g = f"PANEL ASSEMBLY:{n}"
        step(f"panel-{n}", kids(g), f"Fit two pull handles to panel {n} (joint handle_to_panel) and hang the panel on its lower supports and toggle clamps (joint panel_retention).")
    step("top-panel", ["ENCLOSURE TOP PANEL:1"], "Place the top panel (joint top_panel: nothing in CAD retains it).", view="top-region")
    for g in conditional:
        step(f"conditional-{g.lower().replace(' ', '-').replace(':', '-')}", kids(g),
             f"CONDITIONAL (build-scope.json): {g}, the tank support frame. Install now only if it cannot be installed after the panels; otherwise defer with the tanks. Joints support_frame_corners, support_brackets, vibration_mounts.")
    deferred_ids = [o for o in occ if o in deferred]
    if deferred_ids:
        steps.append({"id": "deferred-tanks", "requires": [steps[-1]["id"]], "add": deferred_ids, "view": "overview",
                      "caption": "DEFERRED (build-scope.json): the tanks are not part of phase 1 and are listed here only because every CAD occurrence must appear once. They are to be replaced by monitors and bowls."})
    installed = {o for s in steps for o in s["add"]}
    missing = sorted(set(occ) - installed)
    assert not missing, f"not placed by any step: {missing[:5]}"
    eye = [CENTRE[0] - 2700, CENTRE[1] - 3375, CENTRE[2] + 2025]
    data = {
        "schema_version": "draft-1", "scene": "scene.json", "id": "free-standing-enclosure-phase-1-draft",
        "title": "Free Standing Enclosure, phase 1 (no tanks, no backlight): DRAFT modular order",
        "review_state": "draft",
        "views": [
            {"id": "overview", "projection": "orthographic", "eye": eye, "target": CENTRE, "up": [0, 0, 1]},
            {"id": "top-region", "projection": "orthographic", "eye": [CENTRE[0] - 2200, CENTRE[1] - 2750, 3900], "target": [CENTRE[0], CENTRE[1], 2250], "up": [0, 0, 1]},
        ],
        "steps": steps,
    }
    out = ROOT / "assembly/instructions.json"
    out.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
    print(out, len(steps), "steps,", sum(len(s["add"]) for s in steps), "occurrences")
    for s in steps:
        print(f"  {s['id']:<36} +{len(s['add']):>3}")


if __name__ == "__main__":
    main()
