# Authored STEP deliverables

Files here are Linux-authored deliverables intended for publication to Vault through
the Windows adapter. Publication requests are prepared only from committed files.

| File | Source | SHA-256 | Purpose |
| --- | --- | --- | --- |
| `AW2725Q-nominal-envelope.step` | `designs/reference-models/alienware-aw2725q/` (FreeCAD, mm) | `f7edc118fc0f21d6607f39b5e02069d8796b27b485732f46ad1663b868562ad3` | First live publication pilot payload chosen by Peter (2026-10-22): a nominal monitor envelope, not a production part |

Destination for the pilot (Peter, 2026-10-22): the project's existing Vault folder
`$/DATA/PROJECTS/_PROJECTS BY LAB/SCHULZE (LAB)/ENCLOSURE` (folder id 953863 per the
Windows read-only dry run; it holds no STEP file today). Any filename is acceptable;
the request uses the file's own name with `if_exists: fail`. The live add stays
refused on Windows until the planner/result fixes M1-M3/P1 from the Linux review are
in and the pilot sequence (snapshot, plan, add, exact-byte re-download, result,
Linux ingest) is run once against this single file.
