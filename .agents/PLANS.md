# Tank-enclosure pilot plan

## Objective

Use Git and open-source CAD tools to work with the specified Vault project, and
publish Linux-created STEP parts for Inventor teammates.

## Progress (2026-10-21)

- [x] Repository layout, STEP Git attributes, and project locator established.
- [x] Source/generated/authored ownership documented; initial lock file is empty.
- [ ] Resolve exact root assembly and dependency versions using authenticated Vault access.
- [ ] Qualify Windows exports and record source/output associations.
- [ ] Import a part and assembly, validate geometry in FreeCAD, and commit baseline.
- [ ] Agree on a destination for a new authored STEP, publish it, and validate in Inventor.
- [ ] Verify refresh and concurrent-change behavior before importing the whole project.

## Current evidence and dependencies

The Windows report is in the shared vault-cad-tools checkout. It identifies
Vault Professional, vault ID 28, REST v2, and installed STEP job handlers. These
are capability observations, not end-to-end workflow evidence.

The Linux development session could not resolve `svault5`, including an
unsandboxed read-only probe. Windows should export the served OpenAPI description
and resolve IDs; Linux may require a resolvable FQDN or network configuration.
The root path is known; no file IDs, dependencies, or publication destination
have been guessed. The tools pass 30 offline tests in Guix and locked Linux Pixi; the project status
command confirms the configured assembly and empty reference/publication records.
No live import or publication has been performed.
