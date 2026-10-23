"""Create or refresh the curated materials file, assembly/materials.json, from the scene.

Rule (vault-cad-tools docs/authoring-and-materials.md): the CAD material is a claim, kept
under `cad_claim` and never trusted silently; `material`, `finish`, `mass_basis` are the
curated values and stay null until a person confirms or corrects them with evidence.

Running it again refreshes only the `cad_claim` of each part from the scene and adds rows
for new parts; curated fields, statuses and evidence are kept. A row whose part left the
scene is kept with `status: "orphan"` for review. Unknown values are null, never guessed.
"""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCENE = ROOT / "references" / "enclosure" / "scene.json"
OUT = ROOT / "assembly" / "materials.json"
DEFAULT_NAMES = {"", "generic", "default", "none"}
STATUSES = ("unknown", "cad_claimed", "confirmed", "corrected", "orphan")


def read(path):
    return json.loads(Path(path).read_text(encoding="utf-8-sig"))


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def claim_of(part, exporter):
    props = part.get("properties", {})
    material = props.get("material") or None
    return {
        "material": material,
        "appearance": props.get("appearance") or None,
        "density_g_cm3": props.get("density_g_cm3"),
        "is_default": (material or "").strip().lower() in DEFAULT_NAMES,
        "source": f"{exporter}: iProperty Material (appearance, density not exported yet)",
    }


def new_row(part, claim):
    return {
        "part_id": part["id"], "name": part["name"],
        "cad_claim": claim,
        "material": None, "finish": None, "mass_basis": None,
        "status": "unknown" if claim["is_default"] else "cad_claimed",
        "evidence": None, "decided_by": None, "decided_date": None,
        "render": {"appearance": None},
    }


def validate(doc):
    problems = []
    seen = set()
    for r in doc["parts"]:
        if r["part_id"] in seen:
            problems.append(f"duplicate part_id {r['part_id']}")
        seen.add(r["part_id"])
        if r["status"] not in STATUSES:
            problems.append(f"{r['part_id']}: unknown status {r['status']!r}")
        if r["status"] in ("confirmed", "corrected"):
            for f in ("material", "evidence", "decided_by", "decided_date"):
                if not r.get(f):
                    problems.append(f"{r['part_id']}: status {r['status']} needs {f}")
        if r["status"] in ("unknown", "cad_claimed") and r.get("material") is not None:
            problems.append(f"{r['part_id']}: curated material set but status is {r['status']}; use confirmed or corrected with evidence")
    return problems


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--scene", type=Path, default=SCENE)
    ap.add_argument("--out", type=Path, default=OUT)
    ap.add_argument("--check", action="store_true", help="validate the existing file and change nothing")
    a = ap.parse_args(argv)
    scene = read(a.scene)
    exporter = scene.get("source", {}).get("exporter", "exporter")
    existing = read(a.out) if a.out.exists() else None
    if a.check:
        if existing is None:
            raise SystemExit(f"{a.out} does not exist")
        problems = validate(existing)
        for p in problems:
            print("problem:", p)
        raise SystemExit(1 if problems else 0)
    rows = {r["part_id"]: r for r in existing["parts"]} if existing else {}
    added = refreshed = 0
    for part in scene["parts"]:
        claim = claim_of(part, exporter)
        if part["id"] in rows:
            row = rows[part["id"]]
            if row["cad_claim"] != claim:
                row["cad_claim"] = claim
                refreshed += 1
            if row["status"] == "orphan":
                row["status"] = "unknown" if claim["is_default"] else "cad_claimed"
        else:
            rows[part["id"]] = new_row(part, claim)
            added += 1
    scene_ids = {p["id"] for p in scene["parts"]}
    for pid, row in rows.items():
        if pid not in scene_ids and row["status"] != "orphan":
            row["status"] = "orphan"
    doc = {
        "schema_version": 1,
        "scene": str(a.scene.relative_to(ROOT)) if a.scene.is_absolute() and ROOT in a.scene.parents else str(a.scene),
        "scene_sha256": sha(a.scene),
        "status": "draft: every row is the CAD claim or unknown until a person confirms or corrects it with evidence",
        "rules": {
            "statuses": list(STATUSES),
            "consumers": "use material/finish when status is confirmed or corrected; otherwise fall back to cad_claim and label it a claim; print the claim beside a correction",
            "render_appearance": "preset name for glTF and renders; null means the pipeline fallback (CAD colour, then a neutral material)",
        },
        "parts": sorted(rows.values(), key=lambda r: r["name"].lower()),
    }
    problems = validate(doc)
    if problems:
        raise SystemExit("not written: " + "; ".join(problems))
    a.out.write_text(json.dumps(doc, indent=2) + "\n", encoding="utf-8")
    counts = {}
    for r in doc["parts"]:
        counts[r["status"]] = counts.get(r["status"], 0) + 1
    print(f"{a.out.relative_to(ROOT)}: {len(doc['parts'])} parts, added {added}, claims refreshed {refreshed}, statuses {counts}")


if __name__ == "__main__":
    main()
