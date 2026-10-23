"""Copy a built mechanical-docs manual into the tracked documentation/ directory.

Usage: python3 assembly/publish_manual.py --manual DIR [--appendix-pdf FILE] [--name manual]
       [--evidence-run NAME]

Copies index.html, images/, hotspots/, manual.json, manual.typ, the PDF, build-receipt.json
and check-report.json (not the check rasters) into docs/<name>/ (the MkDocs site, published on GitHub Pages), verifies every
copied file by hash, refuses a check report that did not pass, and writes SOURCE.json with
the build receipt's input hashes, PDF hashes, page counts and the evidence run. The
previous package is replaced atomically. The repository then carries the manual that
matches its committed sources; Peter commits.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import shutil
import tempfile
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DOCS = ROOT / "docs"


def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def copy_tree(src, dst):
    shutil.copytree(src, dst)
    for f in sorted(p for p in src.rglob("*") if p.is_file()):
        if sha(f) != sha(dst / f.relative_to(src)):
            raise SystemExit(f"copy verification failed: {f}")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--manual", required=True, type=Path, help="built compact manual directory")
    ap.add_argument("--appendix-pdf", type=Path, help="PDF of the appendix build (optional)")
    ap.add_argument("--name", default="manual")
    ap.add_argument("--evidence-run", default=None)
    a = ap.parse_args()
    src = a.manual.resolve()
    check = json.loads((src / "check-report.json").read_text(encoding="utf-8"))
    if not check.get("all_passed"):
        raise SystemExit("check-report.json: not all checks passed; refusing to publish")
    receipt = json.loads((src / "build-receipt.json").read_text(encoding="utf-8"))
    pdfs = sorted(src.glob("*.pdf"))
    if len(pdfs) != 1:
        raise SystemExit(f"expected one PDF in {src}, found {len(pdfs)}")
    DOCS.mkdir(exist_ok=True)
    dest = DOCS / a.name
    staging = Path(tempfile.mkdtemp(prefix=".publishing-", dir=DOCS))
    try:
        pkg = staging / a.name
        pkg.mkdir()
        for name in ("index.html", "manual.json", "manual.typ", "build-receipt.json", "check-report.json"):
            shutil.copyfile(src / name, pkg / name)
        for sub in ("images", "hotspots"):
            if (src / sub).is_dir():
                copy_tree(src / sub, pkg / sub)
        shutil.copyfile(pdfs[0], pkg / pdfs[0].name)
        files = {pdfs[0].name: sha(pdfs[0])}
        if a.appendix_pdf:
            target = pkg / (pdfs[0].stem + "-appendix.pdf")
            shutil.copyfile(a.appendix_pdf, target)
            files[target.name] = sha(a.appendix_pdf)
        source = {
            "schema_version": 1, "published_at": datetime.now(timezone.utc).isoformat(timespec="seconds"),
            "built_from": str(src), "evidence_run": a.evidence_run,
            "build_receipt": {k: receipt.get(k) for k in ("generated_at_utc", "input_hashes", "render_receipt", "meshes_receipt", "pdf", "groups", "joints", "supplement_rows")},
            "check_report": {"all_passed": check.get("all_passed"), "pdf_pages": check.get("pdf_pages"), "generated_at_utc": check.get("generated_at_utc")},
            "pdf_sha256": files,
            "image_count": len(list((pkg / "images").glob("*"))) if (pkg / "images").is_dir() else 0,
            "qualification": "draft documentation generated from the committed sources; not a physically validated procedure",
        }
        (pkg / "SOURCE.json").write_text(json.dumps(source, indent=2) + "\n", encoding="utf-8")
        if dest.exists():
            old = staging / "old"
            os.rename(dest, old)
        os.rename(pkg, dest)
    finally:
        shutil.rmtree(staging, ignore_errors=True)
    print(dest)
    print(json.dumps({"pdf_sha256": files, "pages": check.get("pdf_pages"), "images": source["image_count"]}))


if __name__ == "__main__":
    main()
