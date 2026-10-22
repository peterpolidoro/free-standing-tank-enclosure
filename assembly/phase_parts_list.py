"""Write the physical-verification parts list for a build phase.

Reads the accepted scene, `assembly/build-scope.json` and the procurement sheet and
writes `assembly/procurement/<phase>-parts.csv`: one row per part with the CAD count,
the count needed in this phase (deferred occurrences removed), the count that depends
on the conditional groups, where the part is used, identification leads, and blank
columns for the physical count. Nothing here is a purchase quantity.
"""
from __future__ import annotations

import csv
import json
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def main():
    scope = json.loads((ROOT / "assembly/build-scope.json").read_text(encoding="utf-8"))
    scene = json.loads((ROOT / scope["scene"]).read_text(encoding="utf-8-sig"))
    parts = {p["id"]: p for p in scene["parts"]}
    deferred = set(scope["deferred_occurrence_ids"])
    conditional = {g["id"] for g in scope["conditional_groups"]}
    occ = scene["occurrences"]
    unknown = [o for o in deferred if o not in {x["id"] for x in occ}]
    if unknown:
        raise SystemExit(f"deferred ids not in the scene: {unknown}")
    ident = {}
    for row in csv.DictReader(open(ROOT / "assembly/procurement/modeled-parts.csv", newline="", encoding="utf-8")):
        ident[row["part_id"]] = row
    cad, phase, cond, used = Counter(), Counter(), Counter(), defaultdict(set)
    for o in occ:
        pid = o["part_id"]
        cad[pid] += 1
        top = (o["parent_id"] or "root").split("/")[0]
        used[pid].add(top.split(":")[0] if top != "root" else "root")
        if o["id"] in deferred:
            continue
        if top in conditional:
            cond[pid] += 1
        else:
            phase[pid] += 1
    out = ROOT / "assembly/procurement" / f"{scope['phase']}-parts.csv"
    fields = ["part", "catalog_code_from_name_unverified", "supplier_part_number_iproperty", "cad_qty", f"{scope['phase']}_qty",
              "conditional_qty_tank_frames", "deferred_qty", "used_in", "compound_bodies", "counted_qty", "counted_by", "counted_date",
              "stock_location", "missing_or_damaged", "notes"]
    rows = []
    for pid in sorted(parts, key=lambda k: parts[k]["name"].lower()):
        r = ident.get(pid, {})
        rows.append({
            "part": parts[pid]["name"], "catalog_code_from_name_unverified": r.get("catalog_code_from_name_unverified", ""),
            "supplier_part_number_iproperty": r.get("supplier_part_number_iproperty", ""), "cad_qty": cad[pid],
            f"{scope['phase']}_qty": phase[pid], "conditional_qty_tank_frames": cond[pid], "deferred_qty": cad[pid] - phase[pid] - cond[pid],
            "used_in": "; ".join(sorted(used[pid])),
            "compound_bodies": r.get("visible_solids_per_occurrence", ""), "counted_qty": "", "counted_by": "", "counted_date": "",
            "stock_location": "", "missing_or_damaged": "",
            "notes": "deferred with the tanks" if phase[pid] == 0 and cond[pid] == 0 else ("only in the conditional tank support frames" if phase[pid] == 0 else ""),
        })
    with open(out, "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=fields, lineterminator="\n")
        w.writeheader()
        w.writerows(rows)
    totals = {"cad": sum(cad.values()), "phase": sum(phase.values()), "conditional": sum(cond.values()), "deferred": sum(cad.values()) - sum(phase.values()) - sum(cond.values())}
    print(out)
    print(json.dumps(totals))


if __name__ == "__main__":
    main()
