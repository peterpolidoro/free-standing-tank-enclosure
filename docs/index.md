# Free Standing Tank Enclosure

Documentation for the modified free-standing enclosure designed by Sam Jager for the
Schulze lab at Janelia: a T-slot aluminium frame on casters with removable panels, a
camera frame with a spring-loaded roller mechanism, and, in the original design, tank
support frames with a light box. The modified build replaces the tanks and light box
with two monitors under acrylic and vacuum-formed bowls; that redesign comes after the
enclosure itself is assembled.

Everything here is **draft** until the physical build confirms it. CAD quantities are
instance counts in the model, not stock and not a purchase list.

## Read

- [The pictorial manual](manual/index.html): parts cards with pictures and paper count
  boxes, subassembly inspection views, joint close-ups with the hardware still to review,
  supplementary (non-CAD) items. Also as PDF: [compact](manual/free-standing-enclosure-991056-inventory.pdf)
  and [with technical appendix](manual/free-standing-enclosure-991056-inventory-appendix.pdf).
- [Phase 1 verification list](../assembly/procurement/phase-1-parts.csv): what to count
  before ordering, with the enclosure built first without tanks and backlight
  ([build scope](../assembly/build-scope.json)).
- [Stock and completeness audit](../assembly/procurement/README.md): modeled parts,
  candidate missing hardware, what the native Inventor BOM audit found.
- [Draft assembly order](../assembly/instructions.json): a modular proposal; the real
  order is recorded from the physical build.
- [How the documentation is built](../assembly/documentation-workflow.md) from the
  accepted CAD snapshot with the `mechanical-docs` pipeline.

## Source

- CAD: Vault root `Free Standing Enclosure.iam`, file-version 991056, exported as 37 STEP
  parts with 155 placements into [references/enclosure](../references/enclosure/README.md).
- Repository: [peterpolidoro/free-standing-tank-enclosure](https://github.com/peterpolidoro/free-standing-tank-enclosure).
