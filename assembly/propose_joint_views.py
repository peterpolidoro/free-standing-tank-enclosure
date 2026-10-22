"""Propose `joint_views` for render.json from the accepted scene and joint-audit.json.

One close-up per existing-scope joint: the small parts that form the joint on the
first instance of its group, framed alone, with the named context assembly faded.
Long rails are left to the faded context so the framing stays a close-up. The view
direction points from the joint outward from the enclosure centre (Z-up frame used
by the renderer: native (x, y, z) -> (x, -z, y)), with the stated upward component.
Output is a proposal to review and paste into assembly/render.json; nothing moves.
"""
from __future__ import annotations

import json
import math
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CENTRE = (596.9, 596.9, 1213.3)   # root bounds centre, Z-up mm (validation/2026-10-22-reference-survey.json)

SPECS = {
    "caster_to_plate": {"primary": ["FREE STANDING FRAME:1/CASTER ASSEMBLY:1/HOLKIE LEVELING CASTER:1", "FREE STANDING FRAME:1/CASTER ASSEMBLY:1/CASTER MOUNTING PLATE:1"], "z": 0.25},
    "caster_plate_to_frame": {"primary": ["FREE STANDING FRAME:1/CASTER ASSEMBLY:1/CASTER MOUNTING PLATE:1"], "context": "FREE STANDING FRAME:1", "direction": [-0.7, 0.7, -0.25]},  # from below the plate so the rail end does not hide the contact face
    "handle_to_panel": {"primary": ["PANEL ASSEMBLY:1/MCMASTER_1950A67_Unthreaded-Hole Pull Handle:1"], "context": "PANEL ASSEMBLY:1", "direction": [-0.85, -0.3, 0.4]},  # grazing along the panel so its edge shows
    "clamp_to_mount": {"primary": ["TOGGLE CLAMP ASSEMBLY:1/MCMASTER 5004A11_Compact Hold-Down Toggle Clamp:1", "TOGGLE CLAMP ASSEMBLY:1/TOGGLE CLAMP MOUNT:1"], "z": 0.6},
    "clamp_mount_to_frame": {"primary": ["TOGGLE CLAMP ASSEMBLY:1/TOGGLE CLAMP MOUNT:1"], "context": ["FREE STANDING FRAME:1"], "z": 1.6},  # steep from above along the corner column; only the frame is faded, panels hidden (list context, 2026-10-22)
    "lower_support_to_frame": {"primary": ["FREE STANDING FRAME:1/PANEL LOWER SUPPORT LEFT:1"], "context": "FREE STANDING FRAME:1", "z": 0.4},
    "main_frame_joints": {"primary": ["FREE STANDING FRAME:1/MCMASTER 47065T245:1"], "context": "FREE STANDING FRAME:1", "z": 0.5},
    "camera_frame_joints": {"primary": ["CAMERA FRAME:1/MCMASTER 47065T845_Silver Corner Bracket:1"], "context": "CAMERA FRAME:1", "inward": True, "z": 0.45},  # from inside the camera frame
    "support_frame_corners": {"primary": ["TANK SUPPORT FRAME:1/T SLOT CORNER 47065T242:1"], "context": "TANK SUPPORT FRAME:1", "z": 0.7},
    "support_brackets": {"primary": ["TANK SUPPORT FRAME:1/TANK SUPPORT BRACKET:1"], "context": "TANK SUPPORT FRAME:1", "z": 0.5},
    "vibration_mounts": {"primary": ["TANK SUPPORT FRAME:1/MCMASTER 9378K24_Natural Rubber Vibration-Damping Sandwich Mount:1"], "near": ["MCMASTER 90313A107_18-8 Stainless Steel Oversized Washer"], "radius": 80, "context": "TANK SUPPORT FRAME:1", "z": 0.4},
    "camera_plates": {"primary": ["CAMERA FRAME:1/CAMERA MOUNT PLATE:1"], "near": ["ROLLER MOUNT PLATE", "SPRING MOUNT PLATE", "CAMERA MOUNT PLATE - TELEDYNE KINETIX"], "radius": 300, "context": "CAMERA FRAME:1", "along_thin_axis": "outward", "tilt": [0.15, 0.3]},  # along the plates' normal, outer face
    "spring_roller": {"primary": ["CAMERA FRAME:1/SPRING ROLLER:1"], "near": ["MCMASTER 5972K164_Ball Bearing", "MCMASTER 90265A164_18-8 Stainless Steel Shoulder Screw", "MCMASTER 9293K121_Constant-Force Spring"], "radius": 200, "context": "CAMERA FRAME:1", "z": 0.5},
    "camera_attachment": {"primary": ["CAMERA FRAME:1/CAMERA MOUNT PLATE:1"], "near": ["CAMERA MOUNT PLATE - TELEDYNE KINETIX"], "radius": 300, "context": "CAMERA FRAME:1", "along_thin_axis": "inward", "tilt": [0.15, 0.3]},  # the opposite face, where a camera would mount
    "top_panel": {"primary": ["ENCLOSURE TOP PANEL:1"], "context": "root", "z": 1.2},
    "panel_retention": {"primary": ["FREE STANDING FRAME:1/PANEL LOWER SUPPORT LEFT:1"], "near": ["PANEL LOWER SUPPORT RIGHT"], "radius": 1300, "max_near": 1, "context": "FREE STANDING FRAME:1", "z": -0.15},  # from the front, slightly below the supports
}


def zup(t):
    x, y, z = t[0][3], t[1][3], t[2][3]
    return (x, -z, y)


def thin_axis_world(scene, o):
    """Unit vector (Z-up frame) along the thinnest local extent of the occurrence's part,
    rotated by the occurrence's world transform: a plate's normal."""
    for p in scene["parts"]:
        if p["id"] == o["part_id"]:
            e = p["identifying_dimensions_mm"]["extent"]
            break
    else:
        raise KeyError(o["part_id"])
    k = min(range(3), key=lambda i: e[i])
    t = o["transform_world"]
    w = (t[0][k], t[1][k], t[2][k])            # local axis k expressed in the native frame
    w = (w[0], -w[2], w[1])                    # native (x, y, z) -> Z-up (x, -z, y)
    n = math.sqrt(sum(v * v for v in w))
    return tuple(v / n for v in w)


def main():
    scene = json.loads((ROOT / "references/enclosure/scene.json").read_text(encoding="utf-8-sig"))
    audit = json.loads((ROOT / "assembly/procurement/joint-audit.json").read_text(encoding="utf-8"))
    occ = {o["id"]: o for o in scene["occurrences"]}
    asm = {a["id"] for a in scene["assemblies"]}
    pos = {oid: zup(o["transform_world"]) for oid, o in occ.items()}
    joint_ids = [j["id"] for j in audit["joints"] if j["scope"] == "existing"]
    missing = [j for j in joint_ids if j not in SPECS]
    if missing:
        sys.exit(f"no view spec for joints {missing}")
    views = []
    for jid in joint_ids:
        s = SPECS[jid]
        ids = list(s["primary"])
        for oid in ids:
            if oid not in occ:
                sys.exit(f"{jid}: unknown occurrence {oid}")
        if s.get("near"):
            base = pos[ids[0]]
            parent = occ[ids[0]]["parent_id"]
            cands = []
            for oid, o in occ.items():
                name = oid.rsplit("/", 1)[-1].rsplit(":", 1)[0]
                if o["parent_id"] == parent and name in s["near"] and oid not in ids:
                    d = math.dist(pos[oid], base)
                    if d <= s["radius"]:
                        cands.append((d, oid))
            ids += [oid for _, oid in sorted(cands)[: s.get("max_near", len(cands))]]
        ctx = s.get("context")
        if isinstance(ctx, list):
            # list context: assembly and/or occurrence ids that are drawn faded; need not contain the subject
            for cid in ctx:
                if cid not in asm and cid not in occ:
                    sys.exit(f"{jid}: unknown context id {cid}")
        elif ctx is not None:
            if ctx not in asm:
                sys.exit(f"{jid}: unknown context {ctx}")
            for oid in ids:
                if ctx != "root" and not oid.startswith(ctx + "/"):
                    sys.exit(f"{jid}: {oid} is not inside context {ctx}")
        c = [sum(pos[o][k] for o in ids) / len(ids) for k in range(3)]
        hx, hy = c[0] - CENTRE[0], c[1] - CENTRE[1]
        n = math.hypot(hx, hy)
        hx, hy = (hx / n, hy / n) if n > 1e-6 else (1.0, -1.2)
        if s.get("inward"):
            hx, hy = -hx, -hy
        if "direction" in s:
            d = tuple(s["direction"])
        elif "along_thin_axis" in s:
            # look along the thin axis of the first subject (a plate's normal); outward = away from the enclosure centre
            w = thin_axis_world(scene, occ[ids[0]])
            outward = sum(w[k] * (c[k] - CENTRE[k]) for k in range(3))
            sign = 1.0 if outward >= 0 else -1.0
            if s["along_thin_axis"] == "inward":
                sign = -sign
            side = (-w[1], w[0], 0.0)              # a horizontal vector perpendicular to the normal, for a slight tilt
            d = tuple(sign * w[k] + s["tilt"][0] * side[k] + (s["tilt"][1] if k == 2 else 0.0) for k in range(3))
        else:
            d = (hx, hy, s["z"])
        m = math.sqrt(sum(v * v for v in d))
        view = {"joint_id": jid, "occurrence_ids": ids, "direction": [round(v / m, 3) for v in d]}
        if ctx is not None:
            view["context"] = ctx
        if s.get("context_style"):
            view["context_style"] = s["context_style"]
        views.append(view)
    json.dump(views, sys.stdout, indent=2)
    print()


if __name__ == "__main__":
    main()
