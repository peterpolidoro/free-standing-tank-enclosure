# Assembly completeness and stock check

This is a draft audit of the accepted Vault 991056 snapshot and the requested
monitor/bowl changes. It is not yet an order list. A validated geometry export
proves what was exported; it does not prove that the design includes all assembly
hardware, that every modeled occurrence is needed, or that any stock is present.

## Working sheets

- `modeled-parts.csv`: 37 source part types and 155 CAD occurrences, keyed by
  source version and full scene identity. Count physical pieces against this
  sheet. Names and catalog codes copied from filenames are identification leads,
  not verified supplier specifications. Do not count one purchased item per solid.
- `supplementary-bom.csv`: 20 attachment/design reviews covering potentially
  missing hardware and new work. Rows currently identify item families/joints,
  not individual purchasable SKUs. Split confirmed families into separate bolt,
  nut, washer, bracket, etc. rows before assigning order quantities.
- `joint-audit.json`: source part/group links and the evidence behind those
  candidates. Related groups locate the components; they do not establish the
  attachment scheme. Source geometry remains untouched.

These sheets feed the documentation build. `../procurement_manifests.py` converts
`supplementary-bom.csv` into the renderer's `supplement.json` (23 fields per row,
every blank becomes null) and `modeled-parts.csv` into the inventory stock record,
each time `prepare_documentation.py` stages a build. Column rules: `item_kind` is
`family` or `sku`; `intended_configuration_confirmed` and
`supplier_specification_verified` are `yes`/`no`; `included_with` is blank,
`part:<scene part id>` or `kit:<name>`; `counted_by`/`counted_date` (YYYY-MM-DD)
go with any `on_hand_each` count; quantities are plain integers. A family row
cannot carry `confirmed_required_each` or `on_order_each`; split it into `sku` rows
first. The renderer never reads the CSVs and never adds these rows to CAD counts.

Blank quantities mean **unknown**, never zero. Use zero only after counting or
confirming that an item is not required. Record stock location, person and date.
Do not use `cad_occurrences` directly as an order quantity: confirm the intended
configuration and purchased-kit boundaries first. The renderer's CAD inventory
is separate from these procurement sheets; it currently requires each inventory
quantity to match the scene and cannot represent all non-geometric supplies.

## Highest-value checks

| Interface | Observed CAD contents | Check before buying |
| --- | --- | --- |
| Four casters | Each group has one compound caster and one plate | Caster-to-plate and plate-to-frame fasteners; what comes with the caster |
| Four side panels | Each group has one panel and two unthreaded-hole handles | Handle bolt/nut/washer stacks and actual panel thickness |
| Four clamp mounts | Each group has two compound toggle clamps and one mount | Clamp base screws and mount-to-extrusion attachment, distinct from factory clamp hardware |
| Extrusion joints | Several bracket/connector types are present | Exact series, kit contents, end machining, slot nuts, and joints missing a connector |
| Two support frames | Eight corners, eight vibration mounts and eight oversized washers total | Kit contents and missing retention hardware; intended number of support frames |
| Camera/spring mechanism | Two shoulder screws, four bearings, springs and several plates | Remaining plate fasteners, spacers/retainers and spring-end attachments |
| Monitor and bowl changes | Not part of the frozen enclosure scene | Complete design and interface specifications before deriving the new BOM |

The tank count specifically needs review: there are three CAD occurrences, but
the root `SHULZE 2W.353 TANK:1` and the occurrence inside `TANK SUPPORT FRAME:1`
use the same asset at essentially identical transforms (translation difference
below 0.000001 mm). This is a coincident-instance flag, not permission to delete
either native occurrence or assume a physical quantity of three. The lower
support frame has a third tank at a different height. Both upper instances are
visible and classified Normal in the snapshot. Ask for the intended native
configuration before setting required quantities.

`47065T242` has five visible solids per occurrence; `47065T245` also contains
hidden native bodies. Casters, clamps, bearings and other purchased parts are
compound models. Their internal hardware may already be supplied. Conversely,
no separate mounting screw in a group does not prove that the screw is absent
from its parent assembly, embedded kit, drawing, virtual BOM or package.

## Intended build changes (Peter, 2026-10-22)

The modified build replaces the tank(s) in the model and the light box shown on
the lower panel with two Alienware AW2725Q monitors under an acrylic panel and a
frame of about six vacuum-formed bowls per monitor (Lisanne supplies bowl details).
This is Peter's stated intent, not a designer confirmation. Consequences for these
sheets: the coincident-tank question no longer affects purchasing; tank rows are
not to be purchased; which modeled occurrences form the "light box" is not yet
identified among the 37 parts and must be confirmed before removing anything from
the required set. Monitor/bowl rows (SUP-017 to SUP-020) remain new-design
candidates until the design exists. Sam J ordered the original parts; they are at
his old desk, in the hall receiving area, and the monitors are in the room.

## Native BOM audit (2026-10-22)

Windows audited the native Inventor BOM of the same snapshot read-only (shared
evidence run `vault-cad-exchange/evidence/2026-10-22-windows-native-bom-audit-01/`;
all 44 inputs re-hashed unchanged, nothing saved, no Vault write). What it changes
about how to use these sheets:

- The root parts-only BOM lists exactly the 37 exported parts with the same
  quantities as `cad_occurrences` (155 in total). Nothing in the native model is
  hidden from this sheet: no virtual components, no suppressed, excluded,
  reference or phantom items; every BOM structure is Normal; every quantity is an
  Each count (no length-based extrusion quantities).
- No drawing, presentation or parts list exists in Vault for any version of the
  44 source files; the only attachments are hidden DWF visualizations. Where a
  `next_check` says "drawing", read vendor product documentation, not a Vault
  drawing. Sixteen other assemblies in other projects reuse these parts.
- No part is marked Purchased or Inseparable, and the design-tracking Vendor
  iProperty names the in-house shop on fabricated and purchased parts alike. The
  new `supplier_part_number_iproperty` column (custom PartNo, present on 13
  McMaster parts) and the filename code are identification leads; neither is a
  verified supplier specification.
- Eight compound parts (toggle clamp 20 bodies, bearing 14, 5537T429 11, HOLKIE
  caster 10, 5537T293 9, 47065T242 5, 47065T245 4 of which 3 hidden, sandwich
  mount 3) have only generic body names. Whether those bodies model supplied
  hardware is undecidable from CAD; vendor documentation or the physical kit decides.
- Joint coverage (recorded per joint in `joint-audit.json` under `native_audit`):
  `handle_to_panel` and `top_panel` have no hardware in any native source
  (category d). Caster, clamp, lower-support, main-frame and panel-retention
  joints contain only compound purchased models and no hardware row (e). The
  support-frame and camera-frame joints have exported hardware rows, eight
  oversized washers and two shoulder screws, that the BOM cannot assign to one
  joint (a2); map them physically before buying anything additional.
- Coincident tank: both upper placements are Normal, visible, enabled, not
  reference, constrained (three constraints each); the parts-only quantity is 3.
  The tank part has one Vault version (2025-10, Samuel Jager); the support frame
  has three (2026-08-24 to 09-02, same author). CAD cannot decide redundant versus
  intentional. Ask the designer before setting a required quantity.

## Review each connection

1. Identify both connected components and the actual assembly variant. Review
   native structured/parts-only BOMs, virtual components, drawings and supplier
   installation information alongside the STEP views.
2. Locate each attachment and determine the joining method. Check hole/thread,
   slot series, mating material and thickness, insert/captive-nut requirements,
   length/engagement, head/tool access and washer/nut/retention stack. Record
   drawing or measurement evidence; do not infer thread/length from a render.
3. Check whether the supplier kit or an existing fabricated subassembly already
   includes each item. Use `included_with` to prevent double-counting. Count
   hardware actually present in bags/assembled pieces, not just boxes on order.
4. Confirm quantity per joint and number of selected joints. Record required
   quantity separately from CAD occurrences, stock, orders and deliberate spares.
5. For each verified SKU, compute `max(0, required - usable_on_hand - confirmed_on_order)`
   in consistent units. Keep pack size and any spares as explicit separate
   decisions. Unknown inputs mean an unknown shortage, not a zero-cost order.

## Physical inventory pass

Start with the ordered items at Sam's former desk and the receiving-area items,
then the monitors already in the room. Group parts by subassembly, count and
label bags, and record any supplier packing lists or part numbers. Include usable
hardware already installed in subassemblies and avoid counting it again as loose
stock. Record missing, damaged, unidentified and on-order items separately.
Have the pictorial CAD inventory and these sheets available together; they answer
different questions. A physical count remains necessary even after the native
BOM audit.

Model a missing bracket or hardware when its geometry affects fit, access,
clearance or assembly instructions. Simple specified fasteners/consumables can
remain in a supplementary BOM when that records the assembly adequately. Final
design changes and records still follow the project's Inventor/Vault requirement.
No parts were ordered by this audit. The manager requires approval if the supply
purchase total exceeds $1,000; gather the specified shortlist and prices first.
