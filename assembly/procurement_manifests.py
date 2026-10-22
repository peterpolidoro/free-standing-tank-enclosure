"""Convert the procurement sheets into mechanical-docs manifests.

`supplementary-bom.csv` + `joint-audit.json` -> `supplement.json` (schema 1, 23 fields
per row, decided with the documentation agent on 2026-10-22) and
`modeled-parts.csv` -> the optional stock extension of `inventory.json`.

Rules: blank cells are null, never 0; integers must be plain digits; booleans are
`yes`/`no`; `included_with` is blank, `part:<scene part id>` or `kit:<free text>`;
`attaches_to` comes from the joint audit's parent groups (assembly ids) plus, for
root-level joints, the occurrences of the joint's parts at the root. Every id is
checked against the scene. Nothing is guessed; a malformed cell is an error.
"""
from __future__ import annotations

import csv
import hashlib
import json
import re
from pathlib import Path

PROCUREMENT = Path(__file__).resolve().parent / "procurement"
SUPPLEMENT_CSV = PROCUREMENT / "supplementary-bom.csv"
MODELED_CSV = PROCUREMENT / "modeled-parts.csv"
JOINT_AUDIT = PROCUREMENT / "joint-audit.json"

ITEM_FIELDS = ("item_id", "joint_id", "scope", "item_kind", "status", "candidate_item_family", "quantity_basis",
               "confirmed_required_each", "on_hand_each", "counted_by", "counted_date", "stock_location", "on_order_each",
               "included_with", "intended_configuration_confirmed", "attaches_to", "specification", "supplier_part_number",
               "supplier_specification_verified", "unit_cost", "currency", "evidence", "next_check")
TEXT = ("item_id", "joint_id", "scope", "item_kind", "status", "candidate_item_family", "quantity_basis", "counted_by",
        "stock_location", "specification", "supplier_part_number", "currency", "evidence", "next_check")
INTS = ("confirmed_required_each", "on_hand_each", "on_order_each")
BOOLS = ("intended_configuration_confirmed", "supplier_specification_verified")


class SheetError(ValueError):
    pass


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def read_json(path):
    return json.loads(Path(path).read_text(encoding="utf-8-sig"))


def read_rows(path):
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def text(row, key, where):
    v = row.get(key)
    if v is None:
        raise SheetError(f"{where}: missing column {key!r}")
    v = v.strip()
    return v or None


def integer(row, key, where):
    v = text(row, key, where)
    if v is None:
        return None
    if not re.fullmatch(r"[0-9]+", v):
        raise SheetError(f"{where}.{key}: expected a plain integer or blank, got {v!r}")
    return int(v)


def boolean(row, key, where):
    v = text(row, key, where)
    if v is None or v.lower() not in ("yes", "no"):
        raise SheetError(f"{where}.{key}: expected yes or no, got {v!r}")
    return v.lower() == "yes"


def number(row, key, where):
    v = text(row, key, where)
    if v is None:
        return None
    try:
        n = float(v)
    except ValueError:
        raise SheetError(f"{where}.{key}: expected a number or blank, got {v!r}") from None
    if n < 0:
        raise SheetError(f"{where}.{key}: negative cost")
    return n


def iso_date(row, key, where):
    v = text(row, key, where)
    if v is not None and not re.fullmatch(r"\d{4}-\d{2}-\d{2}", v):
        raise SheetError(f"{where}.{key}: expected YYYY-MM-DD or blank, got {v!r}")
    return v


def included_with(row, where, part_ids):
    v = text(row, "included_with", where)
    if v is None:
        return None
    if v.startswith("part:"):
        pid = v[len("part:"):].strip()
        if pid not in part_ids:
            raise SheetError(f"{where}.included_with: {pid!r} is not a scene part id")
        return {"kind": "scene_part", "id": pid}
    if v.startswith("kit:"):
        name = v[len("kit:"):].strip()
        if not name:
            raise SheetError(f"{where}.included_with: kit name is empty")
        return {"kind": "kit", "name": name}
    raise SheetError(f"{where}.included_with: expected blank, 'part:<scene part id>' or 'kit:<name>', got {v!r}")


class SceneIds:
    def __init__(self, scene):
        self.assemblies = {a["id"] for a in scene["assemblies"]}
        self.occurrences = {o["id"]: o for o in scene["occurrences"]}
        self.parts = {p["id"] for p in scene["parts"]}
        self.root_occurrences = {o["id"]: o["part_id"] for o in scene["occurrences"] if o.get("parent_id") in (None, "root")}


def attaches_to(joint, ids: SceneIds, where):
    out = []
    for gid in joint.get("parent_group_ids") or []:
        if gid == "root":
            for oid, pid in ids.root_occurrences.items():
                if pid in (joint.get("part_ids") or []) and oid not in out:
                    out.append(oid)
            continue
        if gid not in ids.assemblies:
            raise SheetError(f"{where}: joint parent group {gid!r} is not a scene assembly id")
        if gid not in out:
            out.append(gid)
    return out


def build_supplement(scene, rows, joint_audit, csv_path=SUPPLEMENT_CSV, audit_path=JOINT_AUDIT):
    ids = SceneIds(scene)
    joints = {j["id"]: j for j in joint_audit["joints"]}
    items, seen = [], set()
    for n, row in enumerate(rows, start=2):
        where = f"supplementary-bom.csv row {n}"
        item = {}
        for k in TEXT:
            item[k] = text(row, k, where)
        for k in INTS:
            item[k] = integer(row, k, where)
        for k in BOOLS:
            item[k] = boolean(row, k, where)
        item["counted_date"] = iso_date(row, "counted_date", where)
        item["unit_cost"] = number(row, "unit_cost", where)
        item["included_with"] = included_with(row, where, ids.parts)
        if item["item_id"] is None or item["item_id"] in seen:
            raise SheetError(f"{where}: missing or duplicate item_id")
        for key, allowed in (("scope", ("existing", "new_design")), ("item_kind", ("family", "sku")),
                             ("status", ("candidate_requires_review", "not_required", "covered", "specified"))):
            if item[key] not in allowed:
                raise SheetError(f"{where}.{key}: expected one of {allowed}, got {item[key]!r}")
        if item["item_kind"] == "family" and (item["confirmed_required_each"] is not None or item["on_order_each"] is not None):
            raise SheetError(f"{where}: a family row cannot carry confirmed_required_each or on_order_each; split it into sku rows")
        if item["status"] == "covered" and item["included_with"] is None:
            raise SheetError(f"{where}: status covered needs included_with")
        if item["status"] == "specified" and (item["item_kind"] != "sku" or item["supplier_part_number"] is None or not item["supplier_specification_verified"]):
            raise SheetError(f"{where}: status specified needs item_kind sku, a supplier_part_number and supplier_specification_verified yes")
        if (item["on_hand_each"] is None) != (item["counted_by"] is None and item["counted_date"] is None):
            raise SheetError(f"{where}: counted_by and counted_date go with an on_hand_each count and only then")
        seen.add(item["item_id"])
        joint = joints.get(item["joint_id"])
        if joint is None:
            raise SheetError(f"{where}: joint_id {item['joint_id']!r} is not in joint-audit.json")
        item["attaches_to"] = attaches_to(joint, ids, where)
        items.append({k: item[k] for k in ITEM_FIELDS})
    native = joint_audit.get("native_audit") or {}
    return {
        "schema_version": 1,
        "scene": "scene.json",
        "status": "draft: rows converted from the project procurement sheet; candidate item families, not an approved BOM; "
                  "quantities unknown unless stated; never added to CAD counts",
        "source": {"kind": "project-csv", "csv": "assembly/procurement/supplementary-bom.csv", "csv_sha256": sha(csv_path),
                   "joint_audit": "assembly/procurement/joint-audit.json", "joint_audit_sha256": sha(audit_path),
                   "native_bom_audit_run": native.get("evidence_run") or "none"},
        "items": items,
    }


def stock_extension(rows, where_prefix="modeled-parts.csv"):
    """part_id -> stock record fields for inventory items (all optional fields explicit)."""
    out = {}
    for n, row in enumerate(rows, start=2):
        where = f"{where_prefix} row {n}"
        pid = text(row, "part_id", where)
        if pid is None or pid in out:
            raise SheetError(f"{where}: missing or duplicate part_id")
        out[pid] = {
            "on_hand_each": integer(row, "on_hand_each", where),
            "counted_by": text(row, "counted_by", where),
            "counted_date": iso_date(row, "counted_date", where),
            "stock_location": text(row, "stock_location", where),
            "intended_configuration_confirmed": boolean(row, "intended_configuration_confirmed", where),
        }
    return out


def extend_inventory(inventory, stock, scene):
    ids = SceneIds(scene)
    unknown = set(stock) - ids.parts
    if unknown:
        raise SheetError(f"modeled-parts.csv names parts not in the scene: {sorted(unknown)[:3]}")
    for item in inventory["items"]:
        rec = stock.get(item["part_id"])
        if rec is None:
            raise SheetError(f"modeled-parts.csv has no row for scene part {item['part_id']!r}")
        item.update(rec)
    inventory["status"] = inventory.get("status", "") + "; stock record from assembly/procurement/modeled-parts.csv (unknown = null, never 0)"
    return inventory


def write_json(path, data):
    path = Path(path)
    if path.exists():
        raise FileExistsError(f"Refusing to overwrite {path}")
    path.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser(description="Write supplement.json (and optionally an inventory with stock record) from the procurement sheets")
    ap.add_argument("--scene", required=True, type=Path)
    ap.add_argument("--output", required=True, type=Path, help="new directory")
    ap.add_argument("--inventory", type=Path, help="existing inventory.json (CAD counts) to extend with the stock record")
    a = ap.parse_args()
    scene = read_json(a.scene)
    a.output.mkdir(parents=True, exist_ok=False)
    write_json(a.output / "supplement.json", build_supplement(scene, read_rows(SUPPLEMENT_CSV), read_json(JOINT_AUDIT)))
    if a.inventory:
        inv = extend_inventory(read_json(a.inventory), stock_extension(read_rows(MODELED_CSV)), scene)
        write_json(a.output / "inventory.json", inv)
    print(a.output)
