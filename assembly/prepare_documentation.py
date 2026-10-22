"""Stage this project's immutable CAD and authored manual inputs for mechanical-docs.

Run from the managed project environment with --tools /path/to/mechanical-docs.
Only a fresh directory below .cache/ may be created. Existing outputs are refused
so counted stock/instructions are never silently regenerated over user work.
"""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path, PurePosixPath
import shutil
import subprocess
import sys
import tempfile

sys.path.insert(0, str(Path(__file__).resolve().parent))
import procurement_manifests as pm  # noqa: E402

ROOT = Path(__file__).resolve().parents[1]


def read(path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def inside(base, relative):
    rel = PurePosixPath(relative)
    if rel.is_absolute() or ".." in rel.parts or "\\" in relative or ":" in relative:
        raise ValueError(f"Expected a contained relative path: {relative}")
    p = base / relative
    if not p.resolve().is_relative_to(base.resolve()):
        raise ValueError(f"Path escapes its root: {relative}")
    if any((base.joinpath(*rel.parts[:i])).is_symlink() for i in range(1, len(rel.parts) + 1)):
        raise ValueError(f"Symlink input/output is not supported: {relative}")
    return p


def git_revision(repo):
    return subprocess.check_output(["git", "-C", str(repo), "rev-parse", "HEAD"], text=True).strip()


def prepare(tools, output=None):
    cfg = read(ROOT / "assembly/documentation.json")
    if cfg.get("schema_version") != 1:
        raise ValueError("Unsupported documentation recipe version")
    source = inside(ROOT, cfg["snapshot"])
    dest = inside(ROOT, output or cfg["output"])
    if not dest.resolve().is_relative_to((ROOT / ".cache").resolve()) or dest == ROOT / ".cache":
        raise ValueError("Output must be a new directory below this project's .cache/")
    if dest.exists():
        raise FileExistsError(f"Refusing existing output {dest}; choose a new --output .cache/... path")
    if sha(source / "scene.json") != cfg["scene_sha256"]:
        raise ValueError("Snapshot differs from the reviewed scene pinned in assembly/documentation.json")
    if sha(source / "export-receipt.json") != cfg["export_receipt_sha256"]:
        raise ValueError("Snapshot receipt differs from the reviewed receipt")
    receipt = read(source / "export-receipt.json")
    files = receipt["files"]
    if receipt.get("status") not in (None, "complete"):
        raise ValueError("Snapshot export is not complete")
    for rel, record in files.items():
        p = inside(source, rel)
        if not p.is_file() or sha(p) != record["sha256"] or p.stat().st_size != record["bytes"]:
            raise ValueError(f"Snapshot payload mismatch: {rel}")
    for required in ("scene.json", "native-snapshot.json", "inventory-raw.json"):
        if required not in files:
            raise ValueError(f"Missing required snapshot payload: {required}")
    tools = tools.resolve()
    if not (tools / "mechanical_docs/manifest.py").is_file():
        raise ValueError("--tools must name the mechanical-docs checkout")
    sys.path.insert(0, str(tools))
    from mechanical_docs.manifest import inventory_template, load_project, load_scene
    from mechanical_docs.render_settings import load_settings
    # The common validator checks geometry references, hierarchy and identities.
    sc = load_scene(source / "scene.json")
    for p in sc.parts.values():
        if p.asset.path not in files:
            raise ValueError(f"Part is not covered by the export receipt: {p.asset.path}")
    authored = {name: ROOT / "assembly" / name for name in ("inventory.json", "instructions.json", "render.json")}
    dest.parent.mkdir(parents=True, exist_ok=True)
    staging = Path(tempfile.mkdtemp(prefix=".preparing-manual-", dir=dest.parent))
    try:
        for rel in files:
            target = staging / rel
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(source / rel, target)  # independent bytes; no hardlinks to references
        shutil.copyfile(source / "export-receipt.json", staging / "export-receipt.json")
        for name, p in authored.items():
            if p.exists():
                inside(ROOT, str(p.relative_to(ROOT)))
                shutil.copyfile(p, staging / name)
        sheets = {"supplementary-bom.csv": pm.SUPPLEMENT_CSV, "modeled-parts.csv": pm.MODELED_CSV, "joint-audit.json": pm.JOINT_AUDIT}
        raw_scene = read(source / "scene.json")
        if not authored["inventory.json"].exists():
            # CAD counts from the scene plus the stock record from the procurement sheet (unknown = null, never 0)
            inventory = pm.extend_inventory(inventory_template(sc), pm.stock_extension(pm.read_rows(pm.MODELED_CSV)), raw_scene)
            (staging / "inventory.json").write_text(json.dumps(inventory, indent=2) + "\n")
        # supplementary (non-geometric) items: converted from the procurement sheet every time, never hand-edited here
        supplement = pm.build_supplement(raw_scene, pm.read_rows(pm.SUPPLEMENT_CSV), read(pm.JOINT_AUDIT))
        (staging / "supplement.json").write_text(json.dumps(supplement, indent=2, ensure_ascii=False) + "\n")
        project = load_project(staging)
        settings, _ = load_settings(staging)
        for rel, record in files.items():
            if sha(staging / rel) != record["sha256"]:
                raise ValueError(f"Copied payload failed verification: {rel}")
        record = {
            "schema_version": 1,
            "source_scene_sha256": cfg["scene_sha256"],
            "source_receipt_sha256": sha(source / "export-receipt.json"),
            "recipe_sha256": sha(ROOT / "assembly/documentation.json"),
            "mechanical_docs_commit": git_revision(tools),
            "mechanical_docs_dirty": bool(subprocess.check_output(["git", "-C", str(tools), "status", "--porcelain"], text=True).strip()),
            "authored_inputs": {n: sha(p) for n, p in authored.items() if p.exists()},
            "inventory_generated": not authored["inventory.json"].exists(),
            "procurement_sheets": {n: sha(p) for n, p in sheets.items()},
            "supplement_rows": len(supplement["items"]),
            "stock_counts_recorded": sum(1 for it in project.inventory.items if getattr(it, "on_hand_each", None) is not None) if project.inventory else 0,
            "joint_views": len(settings.get("joint_views") or []),
            "inspection_groups": len(settings.get("inspection_groups") or []),
            "counts": {"parts": len(sc.parts), "assemblies": len(sc.assemblies), "occurrences": len(sc.occurrences)},
            "has_instructions": project.instructions is not None,
            "render_engine": settings["engine"],
            "lines_max_triangles": settings["lines"]["max_triangles"],
            "input_hashes": project.input_hashes(),
            "qualification": cfg["qualification"],
        }
        (staging / "preparation-receipt.json").write_text(json.dumps(record, indent=2) + "\n")
        if dest.exists():
            raise FileExistsError(f"Output appeared while preparing: {dest}")
        staging.rename(dest)
        return dest, record
    finally:
        if staging.exists():
            shutil.rmtree(staging)


if __name__ == "__main__":
    p = argparse.ArgumentParser(__doc__)
    p.add_argument("--tools", required=True, type=Path, help="mechanical-docs checkout")
    p.add_argument("--output", help="new project-relative directory below .cache/")
    args = p.parse_args()
    dest, receipt = prepare(args.tools, args.output)
    print(dest)
    print(json.dumps({k: receipt[k] for k in ("counts", "has_instructions", "inventory_generated", "render_engine", "lines_max_triangles")}))
