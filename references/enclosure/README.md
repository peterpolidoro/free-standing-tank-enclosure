# Frozen enclosure reference

37 distinct STEP parts, 155 installed occurrences, 17 groups including the root.
Source: Vault root file-version 991056, master 988153, v5, primary state.
Accepted as open-source reference geometry after Linux/Windows checks; see
[validation](../../validation/2026-10-21-pilot-02-review.md).

- `assets/`: local-frame STEP geometry, protected by the project reference lock.
- `native-snapshot.json`: raw cm-based native instance/hierarchy, source and BOM data.
- `scene.json`: raw exporter scene, mm placements with native +Y up; supported directly
  by mechanical-docs at reviewed commit 27f9581.
- `inventory-raw.json`: original malformed inventory (OrderedDictionary string);
  preserved as evidence. Derive CAD counts from the validated scene instead.
- `export-receipt.json`: original hashes/sizes for the 40 exported payload/metadata
  files; this README is a Linux addition, outside that original receipt.

Raw JSON bytes (including BOM/CRLF) are preserved by `.gitattributes` so the
original receipt survives Git checkout. Do not edit reference files in place. Work under designs/ and export authored STEP
under step/. Preserve original header units (in/mm/cm); FreeCAD reads them into mm.
The existing earlier panel reference outside this directory remains unchanged.

From the project root, generate a disposable hierarchical FreeCAD reference:

```sh
guix shell --pure -m manifest.scm -- FreeCADCmd assembly/build_reference.py
```

Open `.cache/enclosure-reference.FCStd` in FreeCAD. The builder refuses to overwrite
an existing output; move it aside before regenerating. It recreates placements and
hierarchy, not native constraints, feature history or a reviewed assembly procedure.
Generated FCStd files stay outside Git; the STEP parts and scene are the baseline.
