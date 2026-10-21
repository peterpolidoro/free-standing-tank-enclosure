# Visual assembly manual

Peter's requested deliverable (2026-10-21): a LEGO-style, primarily visual manual
that lets Peter or a mechanical technician identify and inventory the parts, then
assemble the enclosure in a feasible order without avoidable interference or
disassembly. Produce a web version and a printable PDF from the same instruction
source. Minimal prose, part images, numerals, arrows and clear symbols should make
the instructions useful even when the reader cannot read the accompanying text.

This file records requirements and the proposed interface. No instruction renderer,
verified assembly sequence, website or PDF manual has been implemented yet.

## Inputs to preserve during CAD exchange

The manual needs part identities and assembly structure in addition to geometry:

- One geometry asset per distinct part configuration/model state, with units,
  source version, checksum and a declared local coordinate frame. Several bodies
  may belong to one part; a solid count is not a parts inventory.
- A separate occurrence record for every installed instance, with a persistent
  identity where available, its part key, parent subassembly and rigid transform.
  Define matrix ordering, handedness, units and whether transforms are relative
  to the parent or assembly root. Preserve mirrored/configured variants explicitly.
- Keep original Inventor/Vault identifiers separate from manual part labels.
  Filenames, labels and occurrence paths can change; flag ambiguous remapping on
  refresh rather than silently assigning old instructions to a different part.
- Distinguish installed quantities, purchased assemblies/kits, their constituent
  parts, reference-only components, suppressed components, consumables and spares.
  Reconcile these against the native BOM and a physical inventory. Do not count
  both a purchased kit and all its contents as separate purchases.
- Record hardware dimensions/part numbers and relevant material/finish where
  needed to distinguish similar-looking pieces. Model omissions such as fasteners,
  ties or adhesive still need explicit manual/inventory entries when required.

Per-part STEP plus an assembly manifest is the proposed representation, not an
existing exporter contract. A structured full-assembly STEP can be an initial
input if identity and placements survive validation. Do not infer a trustworthy
BOM by counting solids in a flattened STEP. The current 503-native-SurfaceBodies
versus 479-STEP-solids discrepancy remains unresolved, so the existing enclosure
export cannot yet establish a complete inventory.

## What a technician should receive

1. An overview of the finished assembly, its orientation and major subassemblies.
2. A visual inventory: clear thumbnail, stable part label, required quantity,
   identifying dimensions where needed, and a place to record the quantity found.
   Uncounted stock remains unknown; required quantity never means it is on hand.
   Include tools and unmodeled supplies. Web checkboxes/counts must also have a
   usable printed counterpart.
3. Small numbered assembly steps. Each shows the parts/tools needed, quantities,
   insertion or rotation arrows, the partially completed assembly and the expected
   result. Keep prior parts subdued and new parts prominent; reinforce color with
   outlines, patterns or symbols so monochrome printing still works.
4. Close-ups where fasteners, orientation, captive hardware or connector access
   cannot be seen in the main view. Prefer consistent cameras; explicitly show
   required view changes and subassembly rotations.
5. Checkpoints for orientation, alignment, fastener completion and the finished
   state. Use short exact labels where a pictogram cannot communicate a critical
   dimension or action reliably; avoid making prose a prerequisite for routine steps.
6. A separate monitor removal/reinstallation sequence once its mount exists,
   since easy removal is an explicit design requirement.

## Sequence authoring and verification

Use an explicit, reviewed sequence with prerequisites. A step identifies its
occurrences, action, starting/ending state, required tools, camera and any temporary
exploded placement or approach motion. Rendering offsets must not change the
canonical assembled model. Separate temporary fixtures from permanently installed
parts. Subassemblies need a clear boundary and an unambiguous insertion step.

Check for cycles, missing prerequisites, duplicate instance installation, omitted
parts and quantity mismatches. At each step check access for the part, hands and
tools, not just final-state overlap. For example, if the frame uses captive slot
hardware, it may need to be inserted before an end is closed. The enclosure may
need assembly inside the room; confirm what can pass through access routes before
choosing off-site subassemblies. Avoid treating those examples as an approved order.

CAD collision and clearance checks can help assess specified insertion paths.
A collision-free final position, exploded illustration, sampled motion or nominal
bounding box alone does not prove assembly feasibility. Record the checked path,
geometry, clearance assumptions and limitations. Account for access, tolerances,
support during assembly, cables and any required flexing separately.

Use explicit review states: draft, CAD-reviewed, and physically build-validated.
Peter/technician should walk through a real build, record corrections and confirm
that the sequence avoids unnecessary removal/rework before it is called validated.
The current native assembly/export completeness work is still a prerequisite for
claiming that the full manual or BOM covers every component.

## Proposed open-source implementation

- FreeCAD/Open CASCADE: read STEP, preserve/resolve component mappings, inspect
  geometry and tessellate to a renderer-friendly mesh format with units and IDs.
- Blender Python: render orthographic part thumbnails and step images with clean
  backgrounds, consistent views, outlines and highlighted new components. Feed
  Blender derived meshes; do not assume it imports STEP directly.
- Static HTML/CSS: assemble the visual inventory and steps. Produce a PDF using
  an open-source print renderer after checking its pagination and image/font
  behavior. Keep PDF and web step order/content identical; interactive 3D is an
  optional enhancement, not necessary to follow the printed instructions.

Start with a small real subassembly and a few steps. Compare the printed pages
with the web output and perform a hands-on walkthrough before expanding. This
prototype should expose the data/export needs before a general tool is built.

## Repository and release boundaries

Project-specific inventory, step sequence, camera definitions, illustrations'
source configuration and validation records belong under this project's
`assembly/`. Preserve the original CAD files and source references.

A reusable, Autodesk-independent renderer may warrant its own repository, such
as `assembly-manual-tools`; that is a proposal, and no new repository exists from
this task. Vault-specific extraction stays in `vault-cad-tools`. Another agent
can develop the documentation tools in its own checkout against a small fixture
while the Windows agent qualifies CAD export and native updates.

Version the compact source data and build scripts. Derive meshes and high-resolution
renders instead of duplicating every assembly state as another CAD file. Keep
large generated output in the shared evidence area or an explicitly published
release, with source hashes and tool versions. A manual release must identify its
exact assembly revision and instruction revision; invalidate affected images and
steps when source parts or placements change. No automatic publication is set up.

The manager's brief requires Inventor design work and final records in Vault.
Generating documentation from validated STEP with open-source tools complements
that requirement. Track documentation/tooling effort against the project's
approximately 100-hour planning estimate and discuss forecast overruns with Jon.
