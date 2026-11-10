# Authored STEP deliverables

Files here are Linux-authored deliverables intended for publication to Vault through
the Windows adapter. Publication requests are prepared only from committed files.

| File | Source | SHA-256 | Purpose |
| --- | --- | --- | --- |
| `AW2725Q-nominal-envelope.step` | `designs/reference-models/alienware-aw2725q/` (FreeCAD, mm) | `f7edc118fc0f21d6607f39b5e02069d8796b27b485732f46ad1663b868562ad3` | First live publication pilot payload chosen by Peter (2026-10-22): a nominal monitor envelope, not a production part |

Destination for the pilot (Peter, 2026-10-22): the project's existing Vault folder
`$/DATA/PROJECTS/_PROJECTS BY LAB/SCHULZE (LAB)/ENCLOSURE` (folder id 953863).

Published on 2026-10-22: request `e1caf6c0-5802-49a2-9bc8-831912ddf81c` added the
file as Vault master 994251, version 994252, with `if_exists: fail`. Windows
verified it by an exact-byte re-download and Linux recorded it in
`vault-lock.json` under `publications`. It is the only file this project has
written to Vault.

Under the layout proposal in `mechanical-cad/docs/layout-proposal.md` this
directory is retired: the STEP beside its program under `designs/` becomes the
deliverable.
