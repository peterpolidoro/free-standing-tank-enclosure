# Tank-enclosure project guidance

This repository owns CAD data and project configuration. Reusable tools belong
in `vault-cad-tools`. Read README.md, vault-project.toml, and .agents/PLANS.md.

Use the managed Guix environment on Linux. Use a separate checkout on each host;
on Windows run the tools through their locked Pixi environment.
never concurrently modify a working tree through the network share. Changes
remain uncommitted unless the user asks otherwise. No automatic pushes.

Preserve Vault-derived references. Author changes in designs/ and step/.
Record real source IDs and exporter evidence; never invent them to populate a
manifest. Credentials, downloaded native files, and machine-specific state stay
outside tracked files. Do not treat Git text merging as geometric merging.

Validate incoming STEP checksums before importing and check geometry with
FreeCAD. Validate publication in Inventor on Windows. Do not report round-trip
success based only on a syntactically plausible STEP header.

Use explicit Vault destinations for writes; generated reference STEP files and
Inventor originals are not publication targets for authored designs.
