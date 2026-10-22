"""Read-only dimensional survey of accepted geometry (run with FreeCADCmd).

Output is .cache/reference-survey/survey.json; existing output is refused.
World coordinates use the declared +Z-up basis once. Bounds describe envelopes,
not free space, load capacity, insertion paths or mounting/ventilation clearances.
"""
from collections import Counter
from itertools import combinations
import hashlib
import json
from pathlib import Path
import FreeCAD as App
import Part

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "references/enclosure"
OUTPUT = ROOT / ".cache/reference-survey/survey.json"


def read(path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def mat(rows):
    return App.Matrix(*[v for row in rows for v in row])


def bounds(shape):
    b = shape.optimalBoundingBox(True, False)
    return {"min": [b.XMin, b.YMin, b.ZMin], "max": [b.XMax, b.YMax, b.ZMax],
            "extent": [b.XLength, b.YLength, b.ZLength]}


def aggregate(items):
    low = [min(i["min"][a] for i in items) for a in range(3)]
    high = [max(i["max"][a] for i in items) for a in range(3)]
    return {"min": low, "max": high, "extent": [h-l for h,l in zip(high,low)]}


def main():
    if OUTPUT.exists():
        raise FileExistsError(f"Refusing existing {OUTPUT}")
    scene = read(SOURCE / "scene.json")
    cfg = read(ROOT / "assembly/documentation.json")
    if sha(SOURCE / "scene.json") != cfg["scene_sha256"]:
        raise ValueError("Scene differs from the reviewed snapshot")
    receipt = read(SOURCE / "export-receipt.json")
    for rel, rec in receipt["files"].items():
        p = (SOURCE / rel).resolve()
        if not p.is_relative_to(SOURCE.resolve()) or sha(p) != rec["sha256"]:
            raise ValueError(f"Invalid snapshot payload: {rel}")
    basis = mat(scene["coordinate_system"]["basis_to_z_up"])
    groups = {g["id"]: g for g in scene["assemblies"]}
    group_world = {}
    def world(gid, seen=()):
        if gid in seen:
            raise ValueError("Cycle in assembly hierarchy")
        if gid not in group_world:
            g = groups[gid]
            group_world[gid] = mat(g["transform"]) if g["parent_id"] is None else world(g["parent_id"], seen+(gid,)) * mat(g["transform"])
        return group_world[gid]
    shapes = {p["id"]: Part.read(str(SOURCE / p["asset"]["path"])) for p in scene["parts"]}
    records = []
    for o in scene["occurrences"]:
        composed = world(o["parent_id"]) * mat(o["transform"])
        supplied = mat(o["transform_world"])
        if max(abs(a-b) for a,b in zip(composed.A, supplied.A)) > 1e-6:
            raise ValueError(f"Placement disagreement: {o['id']}")
        s = shapes[o["part_id"]].copy()
        s.Placement = App.Placement(basis * supplied) * s.Placement
        records.append({"id": o["id"], "part_id": o["part_id"], "parent_id": o["parent_id"],
                        "visible_effective": o.get("visible_effective"), "bom_structure": o.get("bom_structure"),
                        "solids": len(s.Solids), "bounds_mm": bounds(s)})
    assemblies = []
    for gid in groups:
        members = []
        for o in records:
            parent = o["parent_id"]
            while parent is not None:
                if parent == gid:
                    members.append(o)
                    break
                parent = groups[parent]["parent_id"]
        assemblies.append({"id": gid, "occurrences": len(members), "distinct_parts": len(set(o["part_id"] for o in members)),
                           "part_counts": dict(Counter(o["part_id"] for o in members)),
                           "bounds_mm": aggregate([o["bounds_mm"] for o in members])})
    monitor = read(ROOT / "designs/reference-models/alienware-aw2725q/parameters.json")["dimensions_mm"]
    w, h, depth = monitor["body_width"], monitor["body_height"], monitor["body_depth"]
    coincident = []
    for a, b in combinations(scene["occurrences"], 2):
        if a["part_id"] != b["part_id"]:
            continue
        rotation_delta = max(abs(a["transform_world"][i][j] - b["transform_world"][i][j]) for i in range(3) for j in range(3))
        translation_delta = max(abs(a["transform_world"][i][3] - b["transform_world"][i][3]) for i in range(3))
        if rotation_delta < 1e-8 and translation_delta < 1e-6:
            coincident.append({"part_id": a["part_id"], "occurrence_ids": [a["id"], b["id"]],
                               "max_rotation_element_delta": rotation_delta, "max_translation_delta_mm": translation_delta,
                               "action": "Review native BOM/configuration; preserve both source occurrences pending confirmation."})
    result = {"schema_version": 1, "freecad_version": ".".join(App.Version()[:3]),
              "scene_sha256": sha(SOURCE / "scene.json"), "units": "mm", "up_axis": "+Z",
              "basis": "native (x,y,z) -> (x,-z,y); origin unchanged", "occurrences": records, "assemblies": assemblies,
              "solid_count": sum(o["solids"] for o in records),
              "coincident_same_part_pairs": coincident,
              "two_monitor_footprints_mm": {"side_by_side_landscape": [2*w,h,depth], "front_to_back_landscape": [w,2*h,depth]},
              "six_bowls_per_screen": {"assumed_outer_diameter_mm": 160, "columns":3, "rows":2,
                  "active_width_mm": monitor["active_width"], "active_height_mm": monitor["active_height"],
                  "total_horizontal_gap_and_margin_budget_mm": monitor["active_width"]-480,
                  "total_vertical_gap_and_margin_budget_mm": monitor["active_height"]-320},
              "limits": ["Optimal axis-aligned envelopes, not certified clearance or insertion-path tests.",
                         "Monitor is a nominal rectangular body; mounts, cables, vents, tolerances and support loads excluded.",
                         "Bowl diameter is the manager's approximate value; whether it includes a rim is unknown.",
                         "CAD counts do not prove stock, purchased quantities or complete hardware."]}
    if result["solid_count"] != 479:
        raise ValueError("Unexpected solid count")
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(json.dumps(result, indent=2) + "\n")
    print("REFERENCE_SURVEY_READY", OUTPUT, flush=True)


main()
