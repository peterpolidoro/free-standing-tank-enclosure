"""Run with FreeCADCmd. Produces a nominal envelope, not a mounting design."""

import hashlib
import json
from pathlib import Path

import FreeCAD as App
import Part


ROOT = Path(__file__).resolve().parent
PARAMETERS = ROOT / "parameters.json"
data = json.loads(PARAMETERS.read_text())
d = data["dimensions_mm"]
assert data["units"] == "mm"
assert abs(d["body_width"] - d["active_width"] - d["bezel_left"] - d["bezel_right"]) < 1e-8
assert abs(d["body_height"] - d["active_height"] - d["bezel_top"] - d["bezel_bottom"]) < 1e-8

doc = App.newDocument("AW2725Q_Reference")
doc.Label = "AW2725Q — NOMINAL ENVELOPE ONLY"
p = doc.addObject("App::FeaturePython", "Dimensions")
p.Label = "Published dimensions (mm)"
mapping = {
    "BodyWidth": "body_width", "BodyHeight": "body_height", "BodyDepth": "body_depth",
    "ActiveWidth": "active_width", "ActiveHeight": "active_height",
    "LeftBezel": "bezel_left", "TopBezel": "bezel_top",
    "MountSpacingX": "mount_pattern_horizontal", "MountSpacingY": "mount_pattern_vertical",
}
for name, key in mapping.items():
    p.addProperty("App::PropertyLength", name, "Nominal dimensions")
    setattr(p, name, d[key])
p.addProperty("App::PropertyString", "Source", "Provenance")
p.Source = "aw2725q-monitor.pdf, page 1; nominal dimensions; drawing not to scale"
p.addProperty("App::PropertyString", "SourceSHA256", "Provenance")
p.SourceSHA256 = data["source"]["sha256"]
p.addProperty("App::PropertyStringList", "Limitations", "Provenance")
p.Limitations = data["approximations"]

body = doc.addObject("Part::Box", "NominalEnvelope")
body.Label = "AW2725Q nominal envelope — NO STAND / NOT ACTUAL HOUSING"
for prop, expression in {
    "Length": "Dimensions.BodyWidth", "Width": "Dimensions.BodyHeight",
    "Height": "Dimensions.BodyDepth", "Placement.Base.x": "-Dimensions.BodyWidth / 2",
    "Placement.Base.y": "-Dimensions.BodyHeight / 2", "Placement.Base.z": "-Dimensions.BodyDepth",
}.items():
    body.setExpression(prop, expression)

screen = doc.addObject("Part::Plane", "ActiveDisplay")
screen.Label = "Active display — planar construction reference"
for prop, expression in {
    "Length": "Dimensions.ActiveWidth", "Width": "Dimensions.ActiveHeight",
    "Placement.Base.x": "-Dimensions.BodyWidth / 2 + Dimensions.LeftBezel",
    "Placement.Base.y": "Dimensions.BodyHeight / 2 - Dimensions.TopBezel - Dimensions.ActiveHeight",
}.items():
    screen.setExpression(prop, expression)
doc.recompute()
assert body.Shape.isValid() and len(body.Shape.Solids) == 1
assert screen.Shape.isValid()
fcstd = ROOT / "AW2725Q-nominal-envelope.FCStd"
step = ROOT / "AW2725Q-nominal-envelope.step"
doc.saveAs(str(fcstd))
# Export only the closed envelope. The construction plane remains in FCStd.
Part.export([body], str(step))
App.closeDocument(doc.Name)

reopened = App.openDocument(str(fcstd))
reopened.recompute()
assert reopened.NominalEnvelope.Shape.isValid()
assert reopened.ActiveDisplay.Shape.isValid()
nominal_volume = reopened.NominalEnvelope.Shape.Volume
# Exercise the saved parameter expressions without saving the changed document.
reopened.Dimensions.BodyWidth = d["body_width"] + 10
reopened.recompute()
assert abs(reopened.NominalEnvelope.Shape.BoundBox.XLength - d["body_width"] - 10) < 1e-7
App.closeDocument(reopened.Name)
round_trip = Part.read(str(step))
bb = round_trip.BoundBox
extent = [bb.XLength, bb.YLength, bb.ZLength]
expected = [d["body_width"], d["body_height"], d["body_depth"]]
assert round_trip.isValid() and len(round_trip.Solids) == 1
assert all(abs(a - b) < 1e-7 for a, b in zip(extent, expected))
assert abs(round_trip.Volume - nominal_volume) < 1e-5
layout = data["layout_check"]
diameter = layout["assumed_bowl_outer_diameter_mm"]
report = {
    "model": data["model"], "freecad_version": list(App.Version()[:3]),
    "source_sha256": data["source"]["sha256"],
    "fcstd_save_reopen": "passed", "saved_parameter_recompute": "passed",
    "step_reimport_valid": round_trip.isValid(), "step_solids": len(round_trip.Solids),
    "step_extent_mm": extent, "step_volume_mm3": round_trip.Volume,
    "step_min_mm": [bb.XMin, bb.YMin, bb.ZMin],
    "step_max_mm": [bb.XMax, bb.YMax, bb.ZMax],
    "bowl_grid_total_unused_active_width_mm": d["active_width"] - layout["columns"] * diameter,
    "bowl_grid_total_unused_active_height_mm": d["active_height"] - layout["rows"] * diameter,
    "files": {f.name: {"bytes": f.stat().st_size, "sha256": hashlib.sha256(f.read_bytes()).hexdigest()}
              for f in [PARAMETERS, fcstd, step]},
    "limitations": data["approximations"],
    "inventor_validation": "Not run; requested from Windows agent",
}
(ROOT / "validation.json").write_text(json.dumps(report, indent=2) + "\n")
print("AW2725Q_REFERENCE_VALIDATED", json.dumps(report), flush=True)
