"""Build a disposable, hierarchical FreeCAD reference from the accepted STEP snapshot.

Run with FreeCADCmd assembly/build_reference.py. Output is under .cache/ and is
not an editable native Inventor assembly: constraints/history are not recreated.
Original STEP units are interpreted by FreeCAD; returned coordinates are in mm.
"""
from pathlib import Path
import hashlib
import json
import math
import FreeCAD as App
import Part

ROOT = Path(__file__).resolve().parents[1]
BUNDLE = ROOT / "references/enclosure"
OUTPUT = ROOT / ".cache/enclosure-reference.FCStd"

def read(path):
    return json.loads(path.read_text(encoding="utf-8-sig"))

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def matrix(rows):
    assert len(rows) == 4 and all(len(r) == 4 for r in rows)
    assert all(math.isfinite(x) for r in rows for x in r)
    return App.Matrix(*[x for r in rows for x in r])

def measure(root):
    s = Part.getShape(root)
    b = s.BoundBox
    return {"solids": len(s.Solids), "volume_mm3": s.Volume,
            "bounds_mm": [b.XMin, b.YMin, b.ZMin, b.XMax, b.YMax, b.ZMax]}

def main():
    if OUTPUT.exists():
        raise RuntimeError(f"Refusing to overwrite {OUTPUT}; move it aside before rebuilding")
    scene = read(BUNDLE / "scene.json")
    receipt = read(BUNDLE / "export-receipt.json")
    assert scene["units"] == "mm" and scene["coordinate_system"]["up_axis"] == "+Y"
    for rel, record in receipt["files"].items():
        f = (BUNDLE / rel).resolve()
        assert f.is_relative_to(BUNDLE.resolve()) and not f.is_symlink()
        assert digest(f) == record["sha256"] and f.stat().st_size == record["bytes"]
    shapes = {}
    for p in scene["parts"]:
        shapes[p["id"]] = Part.read(str(BUNDLE / p["asset"]["path"]))
    doc = App.newDocument("EnclosureReference")
    doc.Label = "Free Standing Enclosure — imported reference"
    groups = {}
    for i, g in enumerate(scene["assemblies"]):
        group = doc.addObject("App::Part", "Assembly" + str(i))
        group.Label = "Enclosure reference" if g["id"] == "root" else g["id"].rsplit("/", 1)[-1]
        group.Placement = App.Placement(matrix(g["transform"]))
        group.addProperty("App::PropertyString", "SourceOccurrence", "Provenance")
        group.SourceOccurrence = g["id"]
        groups[g["id"]] = group
    for g in scene["assemblies"]:
        if g["parent_id"] is not None:
            groups[g["parent_id"]].addObject(groups[g["id"]])
    for i, o in enumerate(scene["occurrences"]):
        obj = doc.addObject("Part::Feature", "Occurrence" + str(i))
        obj.Label = o["id"].rsplit("/", 1)[-1]
        obj.Shape = shapes[o["part_id"]].copy()
        # Compose rather than replace the STEP shape's own placement.
        obj.Placement = App.Placement(matrix(o["transform"])) * obj.Placement
        for name, value in [("SourceOccurrence", o["id"]), ("SourcePart", o["part_id"])]:
            obj.addProperty("App::PropertyString", name, "Provenance")
            setattr(obj, name, value)
        groups[o["parent_id"]].addObject(obj)
    doc.recompute()
    before = measure(groups["root"])
    assert before["solids"] == 479
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    root_name = groups["root"].Name
    doc.saveAs(str(OUTPUT))
    App.closeDocument(doc.Name)
    reopened = App.openDocument(str(OUTPUT))
    after = measure(reopened.getObject(root_name))
    assert after["solids"] == before["solids"]
    assert abs(after["volume_mm3"] - before["volume_mm3"]) < 0.01
    assert max(abs(x-y) for x,y in zip(after["bounds_mm"],before["bounds_mm"])) < 1e-6
    App.closeDocument(reopened.Name)
    result = {"freecad_version": ".".join(App.Version()[:3]), "scene_sha256": digest(BUNDLE/"scene.json"),
              "output_sha256": digest(OUTPUT), "occurrences": len(scene["occurrences"]),
              "assembly_groups": len(groups), "measurement": after, "save_reopen_passed": True,
              "qualification": "Generated reference with imported shapes/placements; no native constraints, design approval or assembly procedure."}
    OUTPUT.with_suffix(".validation.json").write_text(json.dumps(result, indent=2)+"\n")
    print("ENCLOSURE_REFERENCE_READY", OUTPUT, json.dumps(result), flush=True)

main()
