"""Where this project's scripts find the CAD scene.

The repository keeps one directory per Vault file under references/ (and one
per authored part under designs/). The scene the scripts and mechanical-docs
read, one scene.json with the STEP files beside it, is flattened from those
directories by mechanical-cad. It is derived, so it is not committed: it lives
in the ignored .cache/reference-scene/.

    python3 assembly/reference_scene.py --mechanical-cad /path/to/mechanical-cad    write it
    python3 assembly/reference_scene.py                                              is it current?

`make reference-scene MECHANICAL_CAD=/path/to/mechanical-cad` does the first.

A scene is handed out only when it was flattened from the tree as it stands:
the directories it is made from are hashed when it is written and again each
time it is asked for.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DIR = ROOT / ".cache" / "reference-scene"
SCENE = DIR / "scene.json"
MARK = DIR / "flattened-from.json"
INPUTS = ("references/parts", "references/assemblies", "designs/parts", "designs/assemblies")
# the files of a component directory that the flattened scene is made from
INPUT_FILES = ("part.step", "source.json", "assembly.json", "receipt.json", "parameters.json")
HOW = "write it with: make reference-scene MECHANICAL_CAD=/path/to/mechanical-cad"


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def inputs_sha256():
    """One hash over every file the scene is flattened from."""
    h = hashlib.sha256()
    for top in INPUTS:
        for p in sorted((ROOT / top).glob("*/*")) if (ROOT / top).is_dir() else []:
            if p.is_file() and p.name in INPUT_FILES:
                h.update(f"{p.relative_to(ROOT).as_posix()}\0{sha(p)}\n".encode())
    return h.hexdigest()


def path():
    """The current scene.json. Exits with what to do when there is none or it is stale."""
    if not SCENE.is_file() or not MARK.is_file():
        raise SystemExit(f"There is no flattened scene in {DIR.relative_to(ROOT)}; {HOW}")
    mark = json.loads(MARK.read_text(encoding="utf-8"))
    if mark.get("inputs_sha256") != inputs_sha256():
        raise SystemExit(f"references/ or designs/ changed since the scene in {DIR.relative_to(ROOT)} was flattened; {HOW}")
    if mark.get("scene_sha256") != sha(SCENE):
        raise SystemExit(f"{SCENE.relative_to(ROOT)} is not the file that was flattened; {HOW}")
    return SCENE


def load():
    return json.loads(path().read_text(encoding="utf-8"))


def exporter_part_ids():
    """{part key: the id the exporter gave the part}, from each part's source.json.

    A manual published before the project was converted names parts by the
    exporter's ids; this is the way back to them.
    """
    out = {}
    for src in sorted((ROOT / "references" / "parts").glob("*/source.json")):
        data = json.loads(src.read_text(encoding="utf-8"))
        former = (data.get("export") or {}).get("package_id")
        if former:
            out[data["key"]] = former
    return out


def write(mechanical_cad):
    mechanical_cad = Path(mechanical_cad).resolve()
    if not (mechanical_cad / "mechanical_cad" / "flatten.py").is_file():
        raise SystemExit("--mechanical-cad must name the mechanical-cad checkout")
    (ROOT / ".cache").mkdir(exist_ok=True)
    work = Path(tempfile.mkdtemp(prefix=".flattening-", dir=ROOT / ".cache"))
    try:
        before = inputs_sha256()
        env = dict(os.environ, PYTHONPATH=str(mechanical_cad), PYTHONDONTWRITEBYTECODE="1")
        proc = subprocess.run([sys.executable, "-B", "-m", "mechanical_cad", "flatten", str(ROOT), "--out", str(work / "scene")],
                              env=env, capture_output=True, text=True)
        if proc.returncode:
            raise SystemExit("mechanical-cad did not flatten the project:\n" + proc.stdout + proc.stderr)
        result = json.loads(proc.stdout[proc.stdout.index("{"):])
        version = subprocess.run(["git", "-C", str(mechanical_cad), "rev-parse", "HEAD"], capture_output=True, text=True)
        mark = {"schema_version": 1, "inputs_sha256": before, "scene_sha256": sha(work / "scene" / "scene.json"),
                "parts": result["parts"], "assemblies": result["assemblies"], "occurrences": result["occurrences"],
                "invisible_items_left_out": result.get("invisible_items_left_out", {}),
                "mechanical_cad_commit": version.stdout.strip() or None}
        (work / "scene" / MARK.name).write_text(json.dumps(mark, indent=2) + "\n", encoding="utf-8")
        if inputs_sha256() != before:
            raise SystemExit("references/ or designs/ changed while the scene was being flattened")
        if DIR.exists():
            shutil.rmtree(DIR)
        (work / "scene").rename(DIR)
        return mark
    finally:
        shutil.rmtree(work, ignore_errors=True)


if __name__ == "__main__":
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--mechanical-cad", type=Path, help="the mechanical-cad checkout; flatten the project with it")
    a = ap.parse_args()
    if a.mechanical_cad:
        print(json.dumps(write(a.mechanical_cad), indent=2))
    else:
        print(path().relative_to(ROOT))
