#set page(paper: "a4", margin: (x: 12mm, y: 12mm))
#set text(size: 10.5pt)
#show heading.where(level: 1): set text(size: 20pt)
#show heading.where(level: 2): it => { v(4pt); text(size: 15pt, it); v(2pt) }
#show figure: set block(breakable: true)
#let countbox = box(width: 16mm, height: 9mm, stroke: 1.2pt + black)
#let badge(n) = box(width: 7.5mm, height: 7.5mm, radius: 4mm, stroke: 1.5pt + black, align(center + horizon, text(weight: "bold", size: 10pt, str(n))))
#let sbadge(s) = box(height: 6.5mm, radius: 1mm, inset: (x: 1.5mm), stroke: (paint: black, thickness: 1pt, dash: "dashed"), align(center + horizon, text(weight: "bold", size: 8.5pt, s)))
#let cbadge(n) = box(width: 8mm, height: 8mm, radius: 4mm, fill: rgb("#d9480f"), stroke: 1.5pt + white, align(center + horizon, text(weight: "bold", size: 10pt, fill: white, str(n))))
= Free Standing Enclosure, phase 1 (no tanks, no backlight): DRAFT modular order
Scene #raw("free-standing-enclosure-991056"): Free Standing Enclosure (Vault file-version 991056) native snapshot. Document #raw("free-standing-enclosure-phase-1-draft"). Generated 2026-10-23T15:40:18Z.

#block(width: 100%, stroke: 1.5pt + black, inset: 8pt)[
  #text(weight: "bold", size: 12pt)[DRAFT]
  \ Review state: draft. This sequence has not been physically validated and the order is a draft to be corrected after the build.
  \ Build scope phase-1: Enclosure without tanks and backlight (decided by Peter, 2026-10-22; draft). 110 of 155 installed occurrences are in this build, 42 conditional (undecided), 3 deferred; CAD counts are unchanged and the deferred items stay in the model.
  \ Phase note: Phase 1 assembles the frame, casters, panels with handles, toggle clamps, lower supports, camera frame and top panel. Deferred items stay in the CAD scene and in the CAD counts; this file only scopes the build and its documentation.
  \ Backlight: no modeled part is identified as the backlight or light box; nothing further is excluded until Peter names the occurrences
  \ Deferred design: monitor supports and acrylic; bowls and bowl frame; tank frame changes.
  \ Geometry and hierarchy come from the CAD export named in the build record. Quantities are CAD instance counts, not purchase quantities, kits, stock or an approved bill of materials.
  \ Project note: The tank(s) and the lower light box are to be replaced in the modified build by two Alienware AW2725Q monitors under an acrylic panel and bowl frames (Peter, 2026-10-22; intent, not a designer confirmation; the light-box occurrences are not yet identified). CAD counts are unchanged.
  \ Subassembly pages and joint close-ups are inspection views of parts at their CAD positions; they are not assembly steps and imply no sequence, fasteners or tool access.
  \ Supplementary items (20 rows, 16 for the existing design, 4 for new design in the appendix only) are hardware not modelled in CAD: listed separately for review, never added to CAD quantities, unknown quantities left unknown; not an approved bill of materials.
  \ CAD ambiguity: 1 pair(s) of occurrences of the same part share one position (SHULZE 2W.353 TANK). All source instances are kept and counted; review the intended configuration before treating the count as stock.
  \ Approach arrows are unverified render hints; they do not prove an insertion path or tool access.
  \ Stock is unknown until counted and recorded (on\_hand\_each with counted\_by and counted\_date). The counted box is for a paper count only.
]

== Finished assembly
#figure(image("images/overview.png", width: 100%, height: 120mm, fit: "contain"), caption: [All parts at their CAD positions.])

#pagebreak(weak: true)
== Subassemblies, drawn apart
#text(size: 9pt)[exploded illustration: the top-level groups moved apart as rigid bodies by the recorded offsets; not an assembly step, no order, fastener or tool access implied. The numbers are the subassembly pages of this document, one callout per subassembly on one of its instances.]

#box(width: 186mm, height: 139.50mm)[
  #image("images/exploded.png", width: 186mm, height: 139.50mm, fit: "contain")
  #place(top + left, dx: 110.76mm, dy: 112.69mm)[#cbadge(1)]
  #place(top + left, dx: 108.53mm, dy: 67.95mm)[#cbadge(2)]
  #place(top + left, dx: 92.78mm, dy: 83.98mm)[#cbadge(3)]
  #place(top + left, dx: 89.00mm, dy: 99.79mm)[#cbadge(4)]
  #place(top + left, dx: 74.45mm, dy: 41.08mm)[#cbadge(5)]
  #place(top + left, dx: 99.29mm, dy: 44.93mm)[#cbadge(6)]
  #place(top + left, dx: 89.00mm, dy: 16.46mm)[#cbadge(7)]
]
#text(size: 8pt, fill: luma(90))[Illustration offsets only (recorded in manual.json); nothing here is an assembly order.]

#table(columns: (11mm, 1fr, 50mm, 20mm), stroke: 0.5pt + luma(140), align: (center + horizon, left + horizon, left + horizon, center + horizon),
  table.header([*\#*], [*Subassembly*], [*Instances*], [*Page*]),
  [#cbadge(1)], [*CASTER ASSEMBLY* (4 in this project) \ #text(size: 7.5pt, fill: luma(90))[callout on #raw("FREE STANDING FRAME:1/CASTER ASSEMBLY:2")]], [#text(size: 7.5pt)[#raw("FREE STANDING FRAME:1/CASTER ASSEMBLY:1"), #raw("FREE STANDING FRAME:1/CASTER ASSEMBLY:2"), #raw("FREE STANDING FRAME:1/CASTER ASSEMBLY:3"), #raw("FREE STANDING FRAME:1/CASTER ASSEMBLY:4")]], [#context link(<group-1>)[page #query(<group-1>).first().location().page()]],
  [#cbadge(2)], [*PANEL ASSEMBLY* (4 in this project) \ #text(size: 7.5pt, fill: luma(90))[callout on #raw("PANEL ASSEMBLY:3")]], [#text(size: 7.5pt)[#raw("PANEL ASSEMBLY:1"), #raw("PANEL ASSEMBLY:2"), #raw("PANEL ASSEMBLY:3"), #raw("PANEL ASSEMBLY:4")]], [#context link(<group-2>)[page #query(<group-2>).first().location().page()]],
  [#cbadge(3)], [*TOGGLE CLAMP ASSEMBLY* (4 in this project) \ #text(size: 7.5pt, fill: luma(90))[callout on #raw("TOGGLE CLAMP ASSEMBLY:4")]], [#text(size: 7.5pt)[#raw("TOGGLE CLAMP ASSEMBLY:1"), #raw("TOGGLE CLAMP ASSEMBLY:2"), #raw("TOGGLE CLAMP ASSEMBLY:3"), #raw("TOGGLE CLAMP ASSEMBLY:4")]], [#context link(<group-3>)[page #query(<group-3>).first().location().page()]],
  [#cbadge(4)], [*TANK SUPPORT FRAME* (2 in this project) \ #text(size: 7.5pt, fill: luma(90))[callout on #raw("TANK SUPPORT FRAME:1")]], [#text(size: 7.5pt)[#raw("TANK SUPPORT FRAME:1"), #raw("TANK SUPPORT FRAME:2")]], [#context link(<group-4>)[page #query(<group-4>).first().location().page()]],
  [#cbadge(5)], [*CAMERA FRAME* (1 in this project) \ #text(size: 7.5pt, fill: luma(90))[callout on #raw("CAMERA FRAME:1")]], [#text(size: 7.5pt)[#raw("CAMERA FRAME:1")]], [#context link(<group-5>)[page #query(<group-5>).first().location().page()]],
  [#cbadge(6)], [*FREE STANDING FRAME* (1 in this project) \ #text(size: 7.5pt, fill: luma(90))[callout on #raw("FREE STANDING FRAME:1")]], [#text(size: 7.5pt)[#raw("FREE STANDING FRAME:1")]], [#context link(<group-6>)[page #query(<group-6>).first().location().page()]],
  [#cbadge(7)], [*Parts directly under the root* \ #badge(34) ENCLOSURE TOP PANEL ×1 \ #badge(37) SHULZE 2W.353 TANK ×1], [#text(size: 7.5pt)[#raw("SHULZE 2W.353 TANK:1"), #raw("ENCLOSURE TOP PANEL:1")]], [see Parts],
)

#pagebreak(weak: true)
== Parts
#text(size: 9pt)[CAD qty is the number of instances of the part in the CAD model (reference-only geometry excluded). It is not a purchase quantity: purchased kits, pack sizes, spares and stock are not reconciled. The large number is the quantity for phase-1 (this build); conditional and deferred quantities are stated beside it. Write the quantity you count in the box.]

#grid(columns: (1fr, 1fr, 1fr), column-gutter: 4mm, row-gutter: 4mm,
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(1) #h(2pt) #text(weight: "bold", size: 9pt)[MCMASTER 5537T293 T-Slotted Framing]]
    #v(1pt)
    #image("images/part-data-common-mcmaster-mcmaster-5537t293-t-slotted-1c2935ff.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 80 × 32 × 28.4 mm \ Zinc · 9 bodies \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[2] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 2 \ CAD qty 2 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(2) #h(2pt) #text(weight: "bold", size: 9pt)[MCMASTER 5537T429 T-Slotted Framing]]
    #v(1pt)
    #image("images/part-data-common-mcmaster-mcmaster-5537t429-t-slotted-72ff3dc4.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 103 × 99.2 × 32 mm \ Zinc · 11 bodies \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[2] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 2 \ CAD qty 2 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(3) #h(2pt) #text(weight: "bold", size: 9pt)[SLLB Enclosure 15in 47065T808 T-Slotted Framing]]
    #v(1pt)
    #grid(columns: (2fr, 1fr), column-gutter: 1.5mm, image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-64014b81.png", width: 100%, height: 34mm, fit: "contain"), image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-64014b81-end.png", width: 100%, height: 34mm, fit: "contain"))
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 381 × 38.1 × 38.1 mm \ ALUMINUM, 6061-T651 \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[2] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 2 \ CAD qty 2 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(4) #h(2pt) #text(weight: "bold", size: 9pt)[SLLB Enclosure 22in 47065T808 T-Slotted Framing]]
    #v(1pt)
    #grid(columns: (2fr, 1fr), column-gutter: 1.5mm, image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-567ca529.png", width: 100%, height: 34mm, fit: "contain"), image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-567ca529-end.png", width: 100%, height: 34mm, fit: "contain"))
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 559 × 38.1 × 38.1 mm \ ALUMINUM, 6061-T651 \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[2] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 2 \ CAD qty 2 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(5) #h(2pt) #text(weight: "bold", size: 9pt)[SLLB Enclosure 41in 47065T808 T-Slotted Framing]]
    #v(1pt)
    #grid(columns: (2fr, 1fr), column-gutter: 1.5mm, image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-f37ea6b9.png", width: 100%, height: 34mm, fit: "contain"), image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-f37ea6b9-end.png", width: 100%, height: 34mm, fit: "contain"))
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 1032 × 38.1 × 38.1 mm \ ALUMINUM, 6061-T651 \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[2] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 2 \ CAD qty 2 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(6) #h(2pt) #text(weight: "bold", size: 9pt)[MCMASTER 3136N149 T-Slotted Framing]]
    #v(1pt)
    #image("images/part-data-common-mcmaster-mcmaster-3136n149-t-slotted-77d5b1ed.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 152 × 152 × 6.3 mm \ ALUMINUM, 6061-T651 \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[2] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 2 \ CAD qty 2 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(7) #h(2pt) #text(weight: "bold", size: 9pt)[MCMASTER 47065T27 T-Slotted Framing]]
    #v(1pt)
    #grid(columns: (2fr, 1fr), column-gutter: 1.5mm, image("images/part-data-common-mcmaster-mcmaster-47065t27-t-slotted-63467688.png", width: 100%, height: 34mm, fit: "contain"), image("images/part-data-common-mcmaster-mcmaster-47065t27-t-slotted-63467688-end.png", width: 100%, height: 34mm, fit: "contain"))
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 305 × 38.1 × 38.1 mm \ ALUMINUM, 6061-T651 \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[4] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 4 \ CAD qty 4 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(8) #h(2pt) #text(weight: "bold", size: 9pt)[MCMASTER 9293K121 Constant-Force Spring]]
    #v(1pt)
    #image("images/part-data-common-mcmaster-mcmaster-9293k121-constant-a4593b94.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 59.9 × 52.6 × 31.8 mm \ Generic \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[2] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 2 \ CAD qty 2 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(9) #h(2pt) #text(weight: "bold", size: 9pt)[MCMASTER 47065T845 Silver Corner Bracket]]
    #v(1pt)
    #image("images/part-data-common-mcmaster-mcmaster-47065t845-silver-c-e1e40dd2.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 38.1 × 38.1 × 33.3 mm \ ALUMINUM, 6061-T651 \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[4] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 4 \ CAD qty 4 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(10) #h(2pt) #text(weight: "bold", size: 9pt)[MCMASTER 5972K164 Ball Bearing]]
    #v(1pt)
    #image("images/part-data-common-mcmaster-mcmaster-5972k164-ball-bear-66eca704.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 22 × 22 × 6 mm \ P/N MCMASTER 5972K164\_Ball Bearing · Generic · 14 bodies \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[4] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 4 \ CAD qty 4 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(11) #h(2pt) #text(weight: "bold", size: 9pt)[MCMASTER 90265A164 18-8 Stainless Steel Shoulder Screw]]
    #v(1pt)
    #image("images/part-data-common-mcmaster-mcmaster-90265a164-18-8-sta-591781bf.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 45.3 × 16 × 16 mm \ P/N MCMASTER 90265A164\_18-8 Stainless Steel Shoulder Screw · Generic \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[2] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 2 \ CAD qty 2 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(12) #h(2pt) #text(weight: "bold", size: 9pt)[SPRING ROLLER]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-25d6cebc.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 48 × 48 × 34.3 mm (1.89 × 1.89 × 1.35 in) \ ABS, BLACK \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[2] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 2 \ CAD qty 2 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(13) #h(2pt) #text(weight: "bold", size: 9pt)[ROLLER MOUNT PLATE]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-6a8f878a.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 108 × 38.1 × 6.3 mm (4.25 × 1.5 × 0.25 in) \ ALUMINUM, 6061-T651 \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[2] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 2 \ CAD qty 2 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(14) #h(2pt) #text(weight: "bold", size: 9pt)[SPRING MOUNT PLATE]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-eb93feb5.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 60 × 38.1 × 6.3 mm (2.362 × 1.5 × 0.25 in) \ P/N SPRING MOUNT PLATE · ALUMINUM, 6061-T651 \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[2] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 2 \ CAD qty 2 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(15) #h(2pt) #text(weight: "bold", size: 9pt)[CAMERA MOUNT PLATE]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-94fc4c9b.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 102 × 88.9 × 6.3 mm (4 × 3.5 × 0.25 in) \ P/N CAMERA MOUNT PLATE · ALUMINUM, 6061-T651 \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[1] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 1 \ CAD qty 1 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(16) #h(2pt) #text(weight: "bold", size: 9pt)[CAMERA MOUNT PLATE - TELEDYNE KINETIX]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-b670923e.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 102 × 76.2 × 6.3 mm (4 × 3 × 0.25 in) \ ALUMINUM, 6061-T651 \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[1] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 1 \ CAD qty 1 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(17) #h(2pt) #text(weight: "bold", size: 9pt)[TSLOT EXTRUSION 1X40.5 copy]]
    #v(1pt)
    #grid(columns: (2fr, 1fr), column-gutter: 1.5mm, image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-72135c80.png", width: 100%, height: 34mm, fit: "contain"), image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-72135c80-end.png", width: 100%, height: 34mm, fit: "contain"))
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 1029 × 25.4 × 25.4 mm (40.5 × 1 × 1 in) \ Generic \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[0] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 0 \ CAD qty 8 each · conditional 8]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(18) #h(2pt) #text(weight: "bold", size: 9pt)[T SLOT CORNER 47065T242]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-6dff85d6.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 47.4 × 47.4 × 25.2 mm (1.868 × 1.868 × 0.992 in) \ P/N 47065T242\_T-Slotted Framing · Generic · 5 bodies \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[0] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 0 \ CAD qty 8 each · conditional 8]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(19) #h(2pt) #text(weight: "bold", size: 9pt)[MCMASTER 9378K24 Natural Rubber Vibration-Damping Sandwich Mount]]
    #v(1pt)
    #image("images/part-data-common-mcmaster-mcmaster-9378k24-natural-ru-fcf343fc.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 25.7 × 25.4 × 25.4 mm (1.013 × 1 × 1 in) \ P/N 9378K24\_Natural Rubber Vibration-Damping Sandwich Mount · Generic · 3 bodies \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[0] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 0 \ CAD qty 8 each · conditional 8]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(20) #h(2pt) #text(weight: "bold", size: 9pt)[MCMASTER 90313A107 18-8 Stainless Steel Oversized Washer]]
    #v(1pt)
    #image("images/part-data-common-mcmaster-mcmaster-90313a107-18-8-sta-34837649.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 25.4 × 25.4 × 1.3 mm (1 × 1 × 0.05 in) \ P/N 90313A107\_18-8 Stainless Steel Oversized Washer · STAINLESS STEEL, 18-8 \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[0] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 0 \ CAD qty 8 each · conditional 8]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(21) #h(2pt) #text(weight: "bold", size: 9pt)[TANK SUPPORT PLATFORM]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-a3951cbf.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 1080 × 1080 × 12.7 mm (42.5 × 42.5 × 0.5 in) \ P/N TANK SUPPORT PLATFORM · ACRYLIC, CLEAR \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[0] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 0 \ CAD qty 2 each · conditional 2]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(22) #h(2pt) #text(weight: "bold", size: 9pt)[TANK SUPPORT BRACKET]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-7481e885.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 114 × 63.5 × 6.3 mm (4.5 × 2.5 × 0.25 in) \ ALUMINUM, 6061-T651 \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[0] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 0 \ CAD qty 8 each · conditional 8]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(23) #h(2pt) #text(weight: "bold", size: 9pt)[SLLB Enclosure 44in 47065T808 T-Slotted Framing]]
    #v(1pt)
    #grid(columns: (2fr, 1fr), column-gutter: 1.5mm, image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-11d4d431.png", width: 100%, height: 34mm, fit: "contain"), image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-11d4d431-end.png", width: 100%, height: 34mm, fit: "contain"))
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 1118 × 38.1 × 38.1 mm \ P/N SLLB Enclosure 44in 47065T808\_T-Slotted Framing · Generic \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[11] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 11 \ CAD qty 11 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(24) #h(2pt) #text(weight: "bold", size: 9pt)[MCMASTER 47065T245]]
    #v(1pt)
    #image("images/part-data-common-mcmaster-mcmaster-47065t245-ipt-prim-89f50e74.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 41.1 × 41.1 × 41.1 mm \ P/N MCMASTER 47065T245 · Generic · 4 bodies \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[8] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 8 \ CAD qty 8 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(25) #h(2pt) #text(weight: "bold", size: 9pt)[SLLB Enclosure 96in 47065T808 T-Slotted Framing]]
    #v(1pt)
    #grid(columns: (2fr, 1fr), column-gutter: 1.5mm, image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-f6258a3b.png", width: 100%, height: 34mm, fit: "contain"), image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-f6258a3b-end.png", width: 100%, height: 34mm, fit: "contain"))
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 2438 × 38.1 × 38.1 mm \ Generic \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[4] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 4 \ CAD qty 4 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(26) #h(2pt) #text(weight: "bold", size: 9pt)[HOLKIE LEVELING CASTER]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-jayaraman-lab-flow-72f0778a.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 104 × 86.2 × 73.5 mm (4.094 × 3.395 × 2.893 in) \ P/N HOLKIE LEVELING CASTER · Generic · 10 bodies \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[4] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 4 \ CAD qty 4 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(27) #h(2pt) #text(weight: "bold", size: 9pt)[CASTER MOUNTING PLATE]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-jayaraman-lab-flow-db2a93e4.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 100 × 100 × 6.3 mm (3.953 × 3.953 × 0.25 in) \ ALUMINUM, 6061-T651 \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[4] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 4 \ CAD qty 4 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(28) #h(2pt) #text(weight: "bold", size: 9pt)[SLLB Enclosure 2.5in 47065T808 T-Slotted Framing]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-0debaac0.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 63.5 × 38.1 × 38.1 mm \ Generic \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[2] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 2 \ CAD qty 2 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(29) #h(2pt) #text(weight: "bold", size: 9pt)[47065T271 ALUMINUM T-SLOTTED FRAMING EXTRUSION]]
    #v(1pt)
    #image("images/part-data-common-mcmaster-47065t271-aluminum-t-slotte-56fa5cf0.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 114 × 114 × 6.3 mm \ Aluminum \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[8] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 8 \ CAD qty 8 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(30) #h(2pt) #text(weight: "bold", size: 9pt)[PANEL LOWER SUPPORT LEFT]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-08daa5a1.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 63.5 × 52.7 × 51.1 mm (2.5 × 2.075 × 2.01 in) \ Generic \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[4] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 4 \ CAD qty 4 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(31) #h(2pt) #text(weight: "bold", size: 9pt)[PANEL LOWER SUPPORT RIGHT]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-20c0f88f.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 63.5 × 52.7 × 51.1 mm (2.5 × 2.075 × 2.01 in) \ ABS, BLACK \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[4] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 4 \ CAD qty 4 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(32) #h(2pt) #text(weight: "bold", size: 9pt)[ENCLOSURE PANEL]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-e022258d.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 2438 × 1143 × 3.2 mm (96 × 45 × 0.125 in) \ ALUMINUM COMPOSITE MATERIAL \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[4] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 4 \ CAD qty 4 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(33) #h(2pt) #text(weight: "bold", size: 9pt)[MCMASTER 1950A67 Unthreaded-Hole Pull Handle]]
    #v(1pt)
    #image("images/part-data-common-mcmaster-mcmaster-1950a67-unthreaded-f36d1af7.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 170 × 51.1 × 31.2 mm (6.71 × 2.014 × 1.23 in) \ P/N MCMASTER\_1950A67\_Unthreaded-Hole Pull Handle · Generic \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[8] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 8 \ CAD qty 8 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(34) #h(2pt) #text(weight: "bold", size: 9pt)[ENCLOSURE TOP PANEL]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-389173d2.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 1194 × 1194 × 3.2 mm (47 × 47 × 0.125 in) \ P/N ENCLOSURE TOP PANEL · ALUMINUM COMPOSITE MATERIAL \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[1] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 1 \ CAD qty 1 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(35) #h(2pt) #text(weight: "bold", size: 9pt)[MCMASTER 5004A11 Compact Hold-Down Toggle Clamp]]
    #v(1pt)
    #image("images/part-data-common-mcmaster-mcmaster-5004a11-compact-ho-976424b5.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 56.5 × 35.7 × 28.4 mm (2.224 × 1.407 × 1.12 in) \ P/N 5004A11\_Compact Hold-Down Toggle Clamp · Generic · 20 bodies \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[8] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 8 \ CAD qty 8 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(36) #h(2pt) #text(weight: "bold", size: 9pt)[TOGGLE CLAMP MOUNT]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-4eb76845.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 76.2 × 30.5 × 30.5 mm (3 × 1.2 × 1.2 in) \ ABS, BLACK \ on hand unknown \ intended configuration confirmed: no]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[4] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 4 \ CAD qty 4 each]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
)
#text(size: 8pt, fill: luma(90))[The counted box is for a paper count only; recorded stock is on\_hand\_each in the project's manifests.]

== Deferred (not in this build)
#text(size: 9pt)[These parts stay in the CAD model and its counts but are not part of phase-1: Enclosure without tanks and backlight.]

#grid(columns: (1fr, 1fr, 1fr), column-gutter: 4mm, row-gutter: 4mm,
  block(width: 100%, height: 84mm, stroke: 1pt + black, inset: 4pt, clip: true, breakable: false)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #box(width: 100%, height: 13mm, clip: true)[#badge(37) #h(2pt) #text(weight: "bold", size: 9pt)[SHULZE 2W.353 TANK]]
    #v(1pt)
    #image("images/part-data-projects-projects-by-lab-schulze-lab-2w-353-00b2841c.png", width: 100%, height: 34mm, fit: "contain")
    #v(1pt)
    #box(width: 100%, height: 20mm, clip: true)[#text(size: 7.5pt, fill: luma(60))[overall 991 × 991 × 82.6 mm (39 × 39 × 3.25 in) \ Acrylic, Clear \ on hand unknown \ intended configuration confirmed: no \ #text(weight: "bold", fill: rgb("#b4400a"))[⚠ 1 coincident instance pair(s) in CAD: review before counting as stock]]]
    #v(1fr)
    #line(length: 100%, stroke: 0.4pt + luma(150))
    #grid(columns: (1fr, auto), column-gutter: 2mm, align: (left + horizon, right + horizon),
      [#text(size: 17pt, weight: "bold")[0] #h(2pt) #text(size: 6.5pt, fill: luma(60))[this build 0 \ CAD qty 3 each · deferred 3]],
      stack(dir: ltr, spacing: 2pt, align(horizon, text(size: 6.5pt, fill: luma(60))[counted]), countbox))
  ],
)

#pagebreak(weak: true)
== Verification checklist: phase-1
#text(size: 8.5pt)[Enclosure without tanks and backlight (draft, decided by Peter, 2026-10-22). Tick what you have for this build; quantities are CAD instance counts for the phase, not purchase quantities. Deferred parts are listed last for completeness.]

#set text(size: 7pt)
#table(columns: (6mm, 9mm, 1fr, 11mm, 11mm, 13mm, 16mm, 15mm, 17mm, 13mm), stroke: 0.4pt + luma(140), inset: 2pt, align: (center + horizon, center + horizon, left + horizon, center + horizon, center + horizon, center + horizon, left + horizon, left + horizon, left + horizon, center + horizon),
  table.header([*\#*], [], [*Part*], [*this build*], [*cond.*], [*counted*], [*by*], [*date*], [*location*], [*missing*]),
  [1], [#image("images/part-data-common-mcmaster-mcmaster-5537t293-t-slotted-1c2935ff.png", width: 8mm, height: 5mm, fit: "contain")], [MCMASTER 5537T293 T-Slotted Framing #text(fill: luma(110))[(CAD 2)]], [*2*], [—], [], [], [], [], [],
  [2], [#image("images/part-data-common-mcmaster-mcmaster-5537t429-t-slotted-72ff3dc4.png", width: 8mm, height: 5mm, fit: "contain")], [MCMASTER 5537T429 T-Slotted Framing #text(fill: luma(110))[(CAD 2)]], [*2*], [—], [], [], [], [], [],
  [3], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-64014b81.png", width: 8mm, height: 5mm, fit: "contain")], [SLLB Enclosure 15in 47065T808 T-Slotted Framing #text(fill: luma(110))[(CAD 2)]], [*2*], [—], [], [], [], [], [],
  [4], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-567ca529.png", width: 8mm, height: 5mm, fit: "contain")], [SLLB Enclosure 22in 47065T808 T-Slotted Framing #text(fill: luma(110))[(CAD 2)]], [*2*], [—], [], [], [], [], [],
  [5], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-f37ea6b9.png", width: 8mm, height: 5mm, fit: "contain")], [SLLB Enclosure 41in 47065T808 T-Slotted Framing #text(fill: luma(110))[(CAD 2)]], [*2*], [—], [], [], [], [], [],
  [6], [#image("images/part-data-common-mcmaster-mcmaster-3136n149-t-slotted-77d5b1ed.png", width: 8mm, height: 5mm, fit: "contain")], [MCMASTER 3136N149 T-Slotted Framing #text(fill: luma(110))[(CAD 2)]], [*2*], [—], [], [], [], [], [],
  [7], [#image("images/part-data-common-mcmaster-mcmaster-47065t27-t-slotted-63467688.png", width: 8mm, height: 5mm, fit: "contain")], [MCMASTER 47065T27 T-Slotted Framing #text(fill: luma(110))[(CAD 4)]], [*4*], [—], [], [], [], [], [],
  [8], [#image("images/part-data-common-mcmaster-mcmaster-9293k121-constant-a4593b94.png", width: 8mm, height: 5mm, fit: "contain")], [MCMASTER 9293K121 Constant-Force Spring #text(fill: luma(110))[(CAD 2)]], [*2*], [—], [], [], [], [], [],
  [9], [#image("images/part-data-common-mcmaster-mcmaster-47065t845-silver-c-e1e40dd2.png", width: 8mm, height: 5mm, fit: "contain")], [MCMASTER 47065T845 Silver Corner Bracket #text(fill: luma(110))[(CAD 4)]], [*4*], [—], [], [], [], [], [],
  [10], [#image("images/part-data-common-mcmaster-mcmaster-5972k164-ball-bear-66eca704.png", width: 8mm, height: 5mm, fit: "contain")], [MCMASTER 5972K164 Ball Bearing #text(fill: luma(110))[(CAD 4)]], [*4*], [—], [], [], [], [], [],
  [11], [#image("images/part-data-common-mcmaster-mcmaster-90265a164-18-8-sta-591781bf.png", width: 8mm, height: 5mm, fit: "contain")], [MCMASTER 90265A164 18-8 Stainless Steel Shoulder Screw #text(fill: luma(110))[(CAD 2)]], [*2*], [—], [], [], [], [], [],
  [12], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-25d6cebc.png", width: 8mm, height: 5mm, fit: "contain")], [SPRING ROLLER #text(fill: luma(110))[(CAD 2)]], [*2*], [—], [], [], [], [], [],
  [13], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-6a8f878a.png", width: 8mm, height: 5mm, fit: "contain")], [ROLLER MOUNT PLATE #text(fill: luma(110))[(CAD 2)]], [*2*], [—], [], [], [], [], [],
  [14], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-eb93feb5.png", width: 8mm, height: 5mm, fit: "contain")], [SPRING MOUNT PLATE #text(fill: luma(110))[(CAD 2)]], [*2*], [—], [], [], [], [], [],
  [15], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-94fc4c9b.png", width: 8mm, height: 5mm, fit: "contain")], [CAMERA MOUNT PLATE #text(fill: luma(110))[(CAD 1)]], [*1*], [—], [], [], [], [], [],
  [16], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-b670923e.png", width: 8mm, height: 5mm, fit: "contain")], [CAMERA MOUNT PLATE - TELEDYNE KINETIX #text(fill: luma(110))[(CAD 1)]], [*1*], [—], [], [], [], [], [],
  [17], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-72135c80.png", width: 8mm, height: 5mm, fit: "contain")], [TSLOT EXTRUSION 1X40.5 copy #text(fill: luma(110))[(CAD 8)]], [*0*], [8], [], [], [], [], [],
  [18], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-6dff85d6.png", width: 8mm, height: 5mm, fit: "contain")], [T SLOT CORNER 47065T242 #text(fill: luma(110))[(CAD 8)]], [*0*], [8], [], [], [], [], [],
  [19], [#image("images/part-data-common-mcmaster-mcmaster-9378k24-natural-ru-fcf343fc.png", width: 8mm, height: 5mm, fit: "contain")], [MCMASTER 9378K24 Natural Rubber Vibration-Damping Sandwich Mount #text(fill: luma(110))[(CAD 8)]], [*0*], [8], [], [], [], [], [],
  [20], [#image("images/part-data-common-mcmaster-mcmaster-90313a107-18-8-sta-34837649.png", width: 8mm, height: 5mm, fit: "contain")], [MCMASTER 90313A107 18-8 Stainless Steel Oversized Washer #text(fill: luma(110))[(CAD 8)]], [*0*], [8], [], [], [], [], [],
  [21], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-a3951cbf.png", width: 8mm, height: 5mm, fit: "contain")], [TANK SUPPORT PLATFORM #text(fill: luma(110))[(CAD 2)]], [*0*], [2], [], [], [], [], [],
  [22], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-7481e885.png", width: 8mm, height: 5mm, fit: "contain")], [TANK SUPPORT BRACKET #text(fill: luma(110))[(CAD 8)]], [*0*], [8], [], [], [], [], [],
  [23], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-11d4d431.png", width: 8mm, height: 5mm, fit: "contain")], [SLLB Enclosure 44in 47065T808 T-Slotted Framing #text(fill: luma(110))[(CAD 11)]], [*11*], [—], [], [], [], [], [],
  [24], [#image("images/part-data-common-mcmaster-mcmaster-47065t245-ipt-prim-89f50e74.png", width: 8mm, height: 5mm, fit: "contain")], [MCMASTER 47065T245 #text(fill: luma(110))[(CAD 8)]], [*8*], [—], [], [], [], [], [],
  [25], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-f6258a3b.png", width: 8mm, height: 5mm, fit: "contain")], [SLLB Enclosure 96in 47065T808 T-Slotted Framing #text(fill: luma(110))[(CAD 4)]], [*4*], [—], [], [], [], [], [],
  [26], [#image("images/part-data-projects-projects-by-lab-jayaraman-lab-flow-72f0778a.png", width: 8mm, height: 5mm, fit: "contain")], [HOLKIE LEVELING CASTER #text(fill: luma(110))[(CAD 4)]], [*4*], [—], [], [], [], [], [],
  [27], [#image("images/part-data-projects-projects-by-lab-jayaraman-lab-flow-db2a93e4.png", width: 8mm, height: 5mm, fit: "contain")], [CASTER MOUNTING PLATE #text(fill: luma(110))[(CAD 4)]], [*4*], [—], [], [], [], [], [],
  [28], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-0debaac0.png", width: 8mm, height: 5mm, fit: "contain")], [SLLB Enclosure 2.5in 47065T808 T-Slotted Framing #text(fill: luma(110))[(CAD 2)]], [*2*], [—], [], [], [], [], [],
  [29], [#image("images/part-data-common-mcmaster-47065t271-aluminum-t-slotte-56fa5cf0.png", width: 8mm, height: 5mm, fit: "contain")], [47065T271 ALUMINUM T-SLOTTED FRAMING EXTRUSION #text(fill: luma(110))[(CAD 8)]], [*8*], [—], [], [], [], [], [],
  [30], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-08daa5a1.png", width: 8mm, height: 5mm, fit: "contain")], [PANEL LOWER SUPPORT LEFT #text(fill: luma(110))[(CAD 4)]], [*4*], [—], [], [], [], [], [],
  [31], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-20c0f88f.png", width: 8mm, height: 5mm, fit: "contain")], [PANEL LOWER SUPPORT RIGHT #text(fill: luma(110))[(CAD 4)]], [*4*], [—], [], [], [], [], [],
  [32], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-e022258d.png", width: 8mm, height: 5mm, fit: "contain")], [ENCLOSURE PANEL #text(fill: luma(110))[(CAD 4)]], [*4*], [—], [], [], [], [], [],
  [33], [#image("images/part-data-common-mcmaster-mcmaster-1950a67-unthreaded-f36d1af7.png", width: 8mm, height: 5mm, fit: "contain")], [MCMASTER 1950A67 Unthreaded-Hole Pull Handle #text(fill: luma(110))[(CAD 8)]], [*8*], [—], [], [], [], [], [],
  [34], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-389173d2.png", width: 8mm, height: 5mm, fit: "contain")], [ENCLOSURE TOP PANEL #text(fill: luma(110))[(CAD 1)]], [*1*], [—], [], [], [], [], [],
  [35], [#image("images/part-data-common-mcmaster-mcmaster-5004a11-compact-ho-976424b5.png", width: 8mm, height: 5mm, fit: "contain")], [MCMASTER 5004A11 Compact Hold-Down Toggle Clamp #text(fill: luma(110))[(CAD 8)]], [*8*], [—], [], [], [], [], [],
  [36], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-4eb76845.png", width: 8mm, height: 5mm, fit: "contain")], [TOGGLE CLAMP MOUNT #text(fill: luma(110))[(CAD 4)]], [*4*], [—], [], [], [], [], [],
  [37], [#image("images/part-data-projects-projects-by-lab-schulze-lab-2w-353-00b2841c.png", width: 8mm, height: 5mm, fit: "contain")], [SHULZE 2W.353 TANK #text(fill: luma(110))[(CAD 3)]], [#text(fill: luma(120))[deferred]], [—], [], [], [], [], [],
)
#set text(size: 10.5pt)

#pagebreak(weak: true)
== Supplementary items (not modelled in CAD)
#text(size: 9pt)[Supplementary items are hardware, consumables or purchased items that are not modelled in CAD. They are listed for review and are never added to CAD quantities; an unknown quantity stays unknown. This is not an approved bill of materials. Status: draft: rows converted from the project procurement sheet; candidate item families, not an approved BOM; quantities unknown unless stated; never added to CAD counts.]

#set text(size: 8pt)
#table(columns: (9mm, 1fr, 24mm, 25mm, 30mm, 25mm, 12mm, 17mm), stroke: 0.5pt + luma(140), align: left + top,
  table.header([*\#*], [*Item*], [*Kind, status*], [*Required*], [*Stock*], [*Included with*], [*Config. confirmed*], [*counted*]),
  [#sbadge[S1]], [*Caster-to-mounting-plate fastening* \ #raw("SUP-001") \ joint #raw("caster_to_plate") \ attaches to: CASTER ASSEMBLY:1, CASTER ASSEMBLY:2, CASTER ASSEMBLY:3, CASTER ASSEMBLY:4], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: 4 caster assemblies; attachment points per caster unverified], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
  [#sbadge[S2]], [*Caster-plate-to-frame fastening* \ #raw("SUP-002") \ joint #raw("caster_plate_to_frame") \ attaches to: FREE STANDING FRAME:1, CASTER ASSEMBLY:1, CASTER ASSEMBLY:2, CASTER ASSEMBLY:3, CASTER ASSEMBLY:4], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: 4 plates; frame attachments per plate unverified], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
  [#sbadge[S3]], [*Pull-handle-to-panel fastening* \ #raw("SUP-003") \ joint #raw("handle_to_panel") \ attaches to: PANEL ASSEMBLY:1, PANEL ASSEMBLY:2, PANEL ASSEMBLY:3, PANEL ASSEMBLY:4], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: 8 handles on 4 panels; fastening points per handle unverified], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
  [#sbadge[S4]], [*Toggle-clamp-to-mount fastening* \ #raw("SUP-004") \ joint #raw("clamp_to_mount") \ attaches to: TOGGLE CLAMP ASSEMBLY:1, TOGGLE CLAMP ASSEMBLY:2, TOGGLE CLAMP ASSEMBLY:3, TOGGLE CLAMP ASSEMBLY:4], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: 8 clamps on 4 mounts; points per clamp unverified], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
  [#sbadge[S5]], [*Toggle-clamp-mount-to-frame fastening* \ #raw("SUP-005") \ joint #raw("clamp_mount_to_frame") \ attaches to: TOGGLE CLAMP ASSEMBLY:1, TOGGLE CLAMP ASSEMBLY:2, TOGGLE CLAMP ASSEMBLY:3, TOGGLE CLAMP ASSEMBLY:4], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: 4 mounts; points per mount unverified], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
  [#sbadge[S6]], [*Panel-lower-support fastening* \ #raw("SUP-006") \ joint #raw("lower_support_to_frame") \ attaches to: FREE STANDING FRAME:1], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: 4 left + 4 right supports; points per support unverified], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
  [#sbadge[S7]], [*Main-frame connector hardware and joint completeness* \ #raw("SUP-007") \ joint #raw("main_frame_joints") \ attaches to: FREE STANDING FRAME:1], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: 11 long rails + 4 columns + 2 short rails; joint count requires review], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
  [#sbadge[S8]], [*Camera-frame connector and bracket hardware* \ #raw("SUP-008") \ joint #raw("camera_frame_joints") \ attaches to: CAMERA FRAME:1], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: 4 named 47065T845 brackets plus other connector/sliding parts], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
  [#sbadge[S9]], [*Tank-support-frame corner hardware* \ #raw("SUP-009") \ joint #raw("support_frame_corners") \ attaches to: TANK SUPPORT FRAME:1, TANK SUPPORT FRAME:2], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: 8 modeled corner connectors across 2 support frames], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
  [#sbadge[S10]], [*Tank-support-bracket attachment hardware* \ #raw("SUP-010") \ joint #raw("support_brackets") \ attaches to: TANK SUPPORT FRAME:1, TANK SUPPORT FRAME:2], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: 8 brackets across 2 support frames], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
  [#sbadge[S11]], [*Vibration-mount retention hardware* \ #raw("SUP-011") \ joint #raw("vibration_mounts") \ attaches to: TANK SUPPORT FRAME:1, TANK SUPPORT FRAME:2], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: 8 mounts + 8 oversized washers modeled], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
  [#sbadge[S12]], [*Camera, spring and roller plate attachment hardware* \ #raw("SUP-012") \ joint #raw("camera_plates") \ attaches to: CAMERA FRAME:1], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: 2 roller plates + 2 spring plates + 2 different camera plates], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
  [#sbadge[S13]], [*Spring end and roller/bearing retention hardware* \ #raw("SUP-013") \ joint #raw("spring_roller") \ attaches to: CAMERA FRAME:1], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: 2 springs + 2 rollers + 4 bearings + 2 shoulder screws modeled], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
  [#sbadge[S14]], [*Camera-to-mount attachment* \ #raw("SUP-014") \ joint #raw("camera_attachment") \ attaches to: CAMERA FRAME:1], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: Camera plate variants present; actual camera selection unconfirmed], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
  [#sbadge[S15]], [*Top-panel retention and edge/support interface* \ #raw("SUP-015") \ joint #raw("top_panel") \ attaches to: ENCLOSURE TOP PANEL:1], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: 1 enclosure top panel], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
  [#sbadge[S16]], [*Removable-panel retention interface* \ #raw("SUP-016") \ joint #raw("panel_retention") \ attaches to: FREE STANDING FRAME:1, PANEL ASSEMBLY:1, PANEL ASSEMBLY:2, PANEL ASSEMBLY:3, PANEL ASSEMBLY:4, TOGGLE CLAMP ASSEMBLY:1, TOGGLE CLAMP ASSEMBLY:2, TOGGLE CLAMP ASSEMBLY:3, TOGGLE CLAMP ASSEMBLY:4], [item family, no SKU \ candidate, requires review], [required unknown (family, not specified); basis: 4 panels, 8 lower supports, 8 toggle clamps], [on hand unknown], [—], [no], [#box(width: 14mm, height: 8mm, stroke: 1pt + black)],
)
#set text(size: 10.5pt)
#text(size: 8pt, fill: luma(90))[4 new-design row(s) are in the appendix (not printed in this compact document).]

#pagebreak(weak: true)
== Subassembly 1: CASTER ASSEMBLY (4 in this project) <group-1>
#text(size: 8pt, fill: luma(90))[shown: #raw("FREE STANDING FRAME:1/CASTER ASSEMBLY:1") under #raw("FREE STANDING FRAME:1") · other instances: #raw("FREE STANDING FRAME:1/CASTER ASSEMBLY:2"), #raw("FREE STANDING FRAME:1/CASTER ASSEMBLY:3"), #raw("FREE STANDING FRAME:1/CASTER ASSEMBLY:4") · definition from the exporter's document]

#text(size: 9pt)[inspection view: occurrences at their CAD poses; not an assembly step; no sequence, fasteners or tool access implied.]

#figure(image("images/group-free-standing-frame-1-caster-assembly-1-0f4aa3c4.png", width: 100%), caption: [Subassembly 1: CASTER ASSEMBLY, instance #raw("FREE STANDING FRAME:1/CASTER ASSEMBLY:1"), parts at their CAD positions (inspection view).])

#table(columns: (auto, 22mm, 1fr, 22mm, 24mm), align: (center + horizon, center + horizon, left + horizon, center + horizon, center + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Part*], [*Per subassembly*], [*For all 4*]),
  [#badge(26)], [#image("images/part-data-projects-projects-by-lab-jayaraman-lab-flow-72f0778a.png", width: 20mm, height: 14mm, fit: "contain")], [HOLKIE LEVELING CASTER], [#text(size: 14pt, weight: "bold")[×1]], [#text(size: 14pt, weight: "bold")[×4]],
  [#badge(27)], [#image("images/part-data-projects-projects-by-lab-jayaraman-lab-flow-db2a93e4.png", width: 20mm, height: 14mm, fit: "contain")], [CASTER MOUNTING PLATE], [#text(size: 14pt, weight: "bold")[×1]], [#text(size: 14pt, weight: "bold")[×4]],
)
#text(size: 8pt, fill: luma(90))[4 identical instances of this subassembly in the CAD model; the last column is the CAD count for all 4 (an instance count, not a purchase quantity).]
#text(size: 8pt, fill: luma(90))[2 occurrence(s) in the shown instance; ids in manual.json.]

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S1] Caster-to-mounting-plate fastening · candidate, requires review · required unknown (family, not specified); basis: 4 caster assemblies; attachment points per caster unverified · joint #raw("caster_to_plate")
- #sbadge[S2] Caster-plate-to-frame fastening · candidate, requires review · required unknown (family, not specified); basis: 4 plates; frame attachments per plate unverified · joint #raw("caster_plate_to_frame")

#pagebreak(weak: true)
== Subassembly 2: PANEL ASSEMBLY (4 in this project) <group-2>
#text(size: 8pt, fill: luma(90))[shown: #raw("PANEL ASSEMBLY:1") under #raw("root") · other instances: #raw("PANEL ASSEMBLY:2"), #raw("PANEL ASSEMBLY:3"), #raw("PANEL ASSEMBLY:4") · definition from the exporter's document]

#text(size: 9pt)[inspection view: occurrences at their CAD poses; not an assembly step; no sequence, fasteners or tool access implied.]

#figure(image("images/group-panel-assembly-1-2d4465d7.png", width: 100%), caption: [Subassembly 2: PANEL ASSEMBLY, instance #raw("PANEL ASSEMBLY:1"), parts at their CAD positions (inspection view).])

#table(columns: (auto, 22mm, 1fr, 22mm, 24mm), align: (center + horizon, center + horizon, left + horizon, center + horizon, center + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Part*], [*Per subassembly*], [*For all 4*]),
  [#badge(32)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-e022258d.png", width: 20mm, height: 14mm, fit: "contain")], [ENCLOSURE PANEL], [#text(size: 14pt, weight: "bold")[×1]], [#text(size: 14pt, weight: "bold")[×4]],
  [#badge(33)], [#image("images/part-data-common-mcmaster-mcmaster-1950a67-unthreaded-f36d1af7.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 1950A67 Unthreaded-Hole Pull Handle], [#text(size: 14pt, weight: "bold")[×2]], [#text(size: 14pt, weight: "bold")[×8]],
)
#text(size: 8pt, fill: luma(90))[4 identical instances of this subassembly in the CAD model; the last column is the CAD count for all 4 (an instance count, not a purchase quantity).]
#text(size: 8pt, fill: luma(90))[3 occurrence(s) in the shown instance; ids in manual.json.]

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S3] Pull-handle-to-panel fastening · candidate, requires review · required unknown (family, not specified); basis: 8 handles on 4 panels; fastening points per handle unverified · joint #raw("handle_to_panel")
- #sbadge[S16] Removable-panel retention interface · candidate, requires review · required unknown (family, not specified); basis: 4 panels, 8 lower supports, 8 toggle clamps · joint #raw("panel_retention")

#pagebreak(weak: true)
== Subassembly 3: TOGGLE CLAMP ASSEMBLY (4 in this project) <group-3>
#text(size: 8pt, fill: luma(90))[shown: #raw("TOGGLE CLAMP ASSEMBLY:1") under #raw("root") · other instances: #raw("TOGGLE CLAMP ASSEMBLY:2"), #raw("TOGGLE CLAMP ASSEMBLY:3"), #raw("TOGGLE CLAMP ASSEMBLY:4") · definition from the exporter's document]

#text(size: 9pt)[inspection view: occurrences at their CAD poses; not an assembly step; no sequence, fasteners or tool access implied.]

#figure(image("images/group-toggle-clamp-assembly-1-133f2199.png", width: 100%), caption: [Subassembly 3: TOGGLE CLAMP ASSEMBLY, instance #raw("TOGGLE CLAMP ASSEMBLY:1"), parts at their CAD positions (inspection view).])

#table(columns: (auto, 22mm, 1fr, 22mm, 24mm), align: (center + horizon, center + horizon, left + horizon, center + horizon, center + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Part*], [*Per subassembly*], [*For all 4*]),
  [#badge(35)], [#image("images/part-data-common-mcmaster-mcmaster-5004a11-compact-ho-976424b5.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 5004A11 Compact Hold-Down Toggle Clamp], [#text(size: 14pt, weight: "bold")[×2]], [#text(size: 14pt, weight: "bold")[×8]],
  [#badge(36)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-4eb76845.png", width: 20mm, height: 14mm, fit: "contain")], [TOGGLE CLAMP MOUNT], [#text(size: 14pt, weight: "bold")[×1]], [#text(size: 14pt, weight: "bold")[×4]],
)
#text(size: 8pt, fill: luma(90))[4 identical instances of this subassembly in the CAD model; the last column is the CAD count for all 4 (an instance count, not a purchase quantity).]
#text(size: 8pt, fill: luma(90))[3 occurrence(s) in the shown instance; ids in manual.json.]

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S4] Toggle-clamp-to-mount fastening · candidate, requires review · required unknown (family, not specified); basis: 8 clamps on 4 mounts; points per clamp unverified · joint #raw("clamp_to_mount")
- #sbadge[S5] Toggle-clamp-mount-to-frame fastening · candidate, requires review · required unknown (family, not specified); basis: 4 mounts; points per mount unverified · joint #raw("clamp_mount_to_frame")
- #sbadge[S16] Removable-panel retention interface · candidate, requires review · required unknown (family, not specified); basis: 4 panels, 8 lower supports, 8 toggle clamps · joint #raw("panel_retention")

#pagebreak(weak: true)
== Subassembly 4: TANK SUPPORT FRAME (2 in this project) <group-4>
#text(size: 8pt, fill: luma(90))[shown: #raw("TANK SUPPORT FRAME:1") under #raw("root") · other instance: #raw("TANK SUPPORT FRAME:2") · definition from the exporter's document]

#text(size: 9pt)[inspection view: occurrences at their CAD poses; not an assembly step; no sequence, fasteners or tool access implied.]

#figure(image("images/group-tank-support-frame-1-524083a4.png", width: 100%), caption: [Subassembly 4: TANK SUPPORT FRAME, instance #raw("TANK SUPPORT FRAME:1"), parts at their CAD positions (inspection view).])

#table(columns: (auto, 22mm, 1fr, 22mm, 24mm), align: (center + horizon, center + horizon, left + horizon, center + horizon, center + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Part*], [*Per subassembly*], [*For all 2*]),
  [#badge(17)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-72135c80.png", width: 20mm, height: 14mm, fit: "contain")], [TSLOT EXTRUSION 1X40.5 copy], [#text(size: 14pt, weight: "bold")[×4]], [#text(size: 14pt, weight: "bold")[×8]],
  [#badge(18)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-6dff85d6.png", width: 20mm, height: 14mm, fit: "contain")], [T SLOT CORNER 47065T242], [#text(size: 14pt, weight: "bold")[×4]], [#text(size: 14pt, weight: "bold")[×8]],
  [#badge(19)], [#image("images/part-data-common-mcmaster-mcmaster-9378k24-natural-ru-fcf343fc.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 9378K24 Natural Rubber Vibration-Damping Sandwich Mount], [#text(size: 14pt, weight: "bold")[×4]], [#text(size: 14pt, weight: "bold")[×8]],
  [#badge(20)], [#image("images/part-data-common-mcmaster-mcmaster-90313a107-18-8-sta-34837649.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 90313A107 18-8 Stainless Steel Oversized Washer], [#text(size: 14pt, weight: "bold")[×4]], [#text(size: 14pt, weight: "bold")[×8]],
  [#badge(21)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-a3951cbf.png", width: 20mm, height: 14mm, fit: "contain")], [TANK SUPPORT PLATFORM], [#text(size: 14pt, weight: "bold")[×1]], [#text(size: 14pt, weight: "bold")[×2]],
  [#badge(22)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-7481e885.png", width: 20mm, height: 14mm, fit: "contain")], [TANK SUPPORT BRACKET], [#text(size: 14pt, weight: "bold")[×4]], [#text(size: 14pt, weight: "bold")[×8]],
  [#badge(37)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-2w-353-00b2841c.png", width: 20mm, height: 14mm, fit: "contain")], [SHULZE 2W.353 TANK], [#text(size: 14pt, weight: "bold")[×1]], [#text(size: 14pt, weight: "bold")[×2]],
)
#text(size: 8pt, fill: luma(90))[2 identical instances of this subassembly in the CAD model; the last column is the CAD count for all 2 (an instance count, not a purchase quantity).]
#text(size: 8pt, fill: luma(90))[22 occurrence(s) in the shown instance; ids in manual.json.]

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S9] Tank-support-frame corner hardware · candidate, requires review · required unknown (family, not specified); basis: 8 modeled corner connectors across 2 support frames · joint #raw("support_frame_corners")
- #sbadge[S10] Tank-support-bracket attachment hardware · candidate, requires review · required unknown (family, not specified); basis: 8 brackets across 2 support frames · joint #raw("support_brackets")
- #sbadge[S11] Vibration-mount retention hardware · candidate, requires review · required unknown (family, not specified); basis: 8 mounts + 8 oversized washers modeled · joint #raw("vibration_mounts")

#pagebreak(weak: true)
== Subassembly 5: CAMERA FRAME (1 in this project) <group-5>
#text(size: 8pt, fill: luma(90))[shown: #raw("CAMERA FRAME:1") under #raw("root") · definition from the exporter's document · flexible assembly: positions may differ per instance; 32 position(s) overridden against the definition]

#text(size: 9pt)[inspection view: occurrences at their CAD poses; not an assembly step; no sequence, fasteners or tool access implied.]

#figure(image("images/group-camera-frame-1-05712af3.png", width: 100%), caption: [Subassembly 5: CAMERA FRAME, instance #raw("CAMERA FRAME:1"), parts at their CAD positions (inspection view).])

#table(columns: (auto, 22mm, 1fr, 22mm), align: (center + horizon, center + horizon, left + horizon, center + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Part*], [*In this subassembly*]),
  [#badge(1)], [#image("images/part-data-common-mcmaster-mcmaster-5537t293-t-slotted-1c2935ff.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 5537T293 T-Slotted Framing], [#text(size: 14pt, weight: "bold")[×2]],
  [#badge(2)], [#image("images/part-data-common-mcmaster-mcmaster-5537t429-t-slotted-72ff3dc4.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 5537T429 T-Slotted Framing], [#text(size: 14pt, weight: "bold")[×2]],
  [#badge(3)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-64014b81.png", width: 20mm, height: 14mm, fit: "contain")], [SLLB Enclosure 15in 47065T808 T-Slotted Framing], [#text(size: 14pt, weight: "bold")[×2]],
  [#badge(4)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-567ca529.png", width: 20mm, height: 14mm, fit: "contain")], [SLLB Enclosure 22in 47065T808 T-Slotted Framing], [#text(size: 14pt, weight: "bold")[×2]],
  [#badge(5)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-f37ea6b9.png", width: 20mm, height: 14mm, fit: "contain")], [SLLB Enclosure 41in 47065T808 T-Slotted Framing], [#text(size: 14pt, weight: "bold")[×2]],
  [#badge(6)], [#image("images/part-data-common-mcmaster-mcmaster-3136n149-t-slotted-77d5b1ed.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 3136N149 T-Slotted Framing], [#text(size: 14pt, weight: "bold")[×2]],
  [#badge(7)], [#image("images/part-data-common-mcmaster-mcmaster-47065t27-t-slotted-63467688.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 47065T27 T-Slotted Framing], [#text(size: 14pt, weight: "bold")[×4]],
  [#badge(8)], [#image("images/part-data-common-mcmaster-mcmaster-9293k121-constant-a4593b94.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 9293K121 Constant-Force Spring], [#text(size: 14pt, weight: "bold")[×2]],
  [#badge(9)], [#image("images/part-data-common-mcmaster-mcmaster-47065t845-silver-c-e1e40dd2.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 47065T845 Silver Corner Bracket], [#text(size: 14pt, weight: "bold")[×4]],
  [#badge(10)], [#image("images/part-data-common-mcmaster-mcmaster-5972k164-ball-bear-66eca704.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 5972K164 Ball Bearing], [#text(size: 14pt, weight: "bold")[×4]],
  [#badge(11)], [#image("images/part-data-common-mcmaster-mcmaster-90265a164-18-8-sta-591781bf.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 90265A164 18-8 Stainless Steel Shoulder Screw], [#text(size: 14pt, weight: "bold")[×2]],
  [#badge(12)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-25d6cebc.png", width: 20mm, height: 14mm, fit: "contain")], [SPRING ROLLER], [#text(size: 14pt, weight: "bold")[×2]],
  [#badge(13)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-6a8f878a.png", width: 20mm, height: 14mm, fit: "contain")], [ROLLER MOUNT PLATE], [#text(size: 14pt, weight: "bold")[×2]],
  [#badge(14)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-eb93feb5.png", width: 20mm, height: 14mm, fit: "contain")], [SPRING MOUNT PLATE], [#text(size: 14pt, weight: "bold")[×2]],
  [#badge(15)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-94fc4c9b.png", width: 20mm, height: 14mm, fit: "contain")], [CAMERA MOUNT PLATE], [#text(size: 14pt, weight: "bold")[×1]],
  [#badge(16)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-b670923e.png", width: 20mm, height: 14mm, fit: "contain")], [CAMERA MOUNT PLATE - TELEDYNE KINETIX], [#text(size: 14pt, weight: "bold")[×1]],
)
#text(size: 8pt, fill: luma(90))[36 occurrence(s) in the shown instance; ids in manual.json.]

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S8] Camera-frame connector and bracket hardware · candidate, requires review · required unknown (family, not specified); basis: 4 named 47065T845 brackets plus other connector/sliding parts · joint #raw("camera_frame_joints")
- #sbadge[S12] Camera, spring and roller plate attachment hardware · candidate, requires review · required unknown (family, not specified); basis: 2 roller plates + 2 spring plates + 2 different camera plates · joint #raw("camera_plates")
- #sbadge[S13] Spring end and roller/bearing retention hardware · candidate, requires review · required unknown (family, not specified); basis: 2 springs + 2 rollers + 4 bearings + 2 shoulder screws modeled · joint #raw("spring_roller")
- #sbadge[S14] Camera-to-mount attachment · candidate, requires review · required unknown (family, not specified); basis: Camera plate variants present; actual camera selection unconfirmed · joint #raw("camera_attachment")

#pagebreak(weak: true)
== Subassembly 6: FREE STANDING FRAME (1 in this project) <group-6>
#text(size: 8pt, fill: luma(90))[shown: #raw("FREE STANDING FRAME:1") under #raw("root") · definition from the exporter's document · flexible assembly: positions may differ per instance; 12 position(s) overridden against the definition]

#text(size: 9pt)[inspection view: occurrences at their CAD poses; not an assembly step; no sequence, fasteners or tool access implied.]

#figure(image("images/group-free-standing-frame-1-887affd3.png", width: 100%), caption: [Subassembly 6: FREE STANDING FRAME, instance #raw("FREE STANDING FRAME:1"), parts at their CAD positions (inspection view).])

#table(columns: (auto, 22mm, 1fr, 22mm), align: (center + horizon, center + horizon, left + horizon, center + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Part*], [*In this subassembly*]),
  [#badge(23)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-11d4d431.png", width: 20mm, height: 14mm, fit: "contain")], [SLLB Enclosure 44in 47065T808 T-Slotted Framing], [#text(size: 14pt, weight: "bold")[×11]],
  [#badge(24)], [#image("images/part-data-common-mcmaster-mcmaster-47065t245-ipt-prim-89f50e74.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 47065T245], [#text(size: 14pt, weight: "bold")[×8]],
  [#badge(25)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-f6258a3b.png", width: 20mm, height: 14mm, fit: "contain")], [SLLB Enclosure 96in 47065T808 T-Slotted Framing], [#text(size: 14pt, weight: "bold")[×4]],
  [#badge(26)], [#image("images/part-data-projects-projects-by-lab-jayaraman-lab-flow-72f0778a.png", width: 20mm, height: 14mm, fit: "contain")], [HOLKIE LEVELING CASTER], [#text(size: 14pt, weight: "bold")[×4]],
  [#badge(27)], [#image("images/part-data-projects-projects-by-lab-jayaraman-lab-flow-db2a93e4.png", width: 20mm, height: 14mm, fit: "contain")], [CASTER MOUNTING PLATE], [#text(size: 14pt, weight: "bold")[×4]],
  [#badge(28)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-0debaac0.png", width: 20mm, height: 14mm, fit: "contain")], [SLLB Enclosure 2.5in 47065T808 T-Slotted Framing], [#text(size: 14pt, weight: "bold")[×2]],
  [#badge(29)], [#image("images/part-data-common-mcmaster-47065t271-aluminum-t-slotte-56fa5cf0.png", width: 20mm, height: 14mm, fit: "contain")], [47065T271 ALUMINUM T-SLOTTED FRAMING EXTRUSION], [#text(size: 14pt, weight: "bold")[×8]],
  [#badge(30)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-08daa5a1.png", width: 20mm, height: 14mm, fit: "contain")], [PANEL LOWER SUPPORT LEFT], [#text(size: 14pt, weight: "bold")[×4]],
  [#badge(31)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-20c0f88f.png", width: 20mm, height: 14mm, fit: "contain")], [PANEL LOWER SUPPORT RIGHT], [#text(size: 14pt, weight: "bold")[×4]],
)
#text(size: 8pt, fill: luma(90))[49 occurrence(s) in the shown instance; ids in manual.json.]

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S1] Caster-to-mounting-plate fastening · candidate, requires review · required unknown (family, not specified); basis: 4 caster assemblies; attachment points per caster unverified · joint #raw("caster_to_plate")
- #sbadge[S2] Caster-plate-to-frame fastening · candidate, requires review · required unknown (family, not specified); basis: 4 plates; frame attachments per plate unverified · joint #raw("caster_plate_to_frame")
- #sbadge[S6] Panel-lower-support fastening · candidate, requires review · required unknown (family, not specified); basis: 4 left + 4 right supports; points per support unverified · joint #raw("lower_support_to_frame")
- #sbadge[S7] Main-frame connector hardware and joint completeness · candidate, requires review · required unknown (family, not specified); basis: 11 long rails + 4 columns + 2 short rails; joint count requires review · joint #raw("main_frame_joints")
- #sbadge[S16] Removable-panel retention interface · candidate, requires review · required unknown (family, not specified); basis: 4 panels, 8 lower supports, 8 toggle clamps · joint #raw("panel_retention")

#pagebreak(weak: true)
== Joint 1: caster\_to\_plate
#text(size: 8pt, fill: luma(90))[context #raw("FREE STANDING FRAME:1/CASTER ASSEMBLY:1") (faded, 0 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-caster-to-plate-4da81a1b.png", width: 100%), caption: [Joint 1: caster\_to\_plate, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(26)], [#image("images/part-data-projects-projects-by-lab-jayaraman-lab-flow-72f0778a.png", width: 20mm, height: 14mm, fit: "contain")], [HOLKIE LEVELING CASTER \ #text(size: 7.5pt, fill: luma(90))[#raw("FREE STANDING FRAME:1/CASTER ASSEMBLY:1/HOLKIE LEVELING CASTER:1")]],
  [#badge(27)], [#image("images/part-data-projects-projects-by-lab-jayaraman-lab-flow-db2a93e4.png", width: 20mm, height: 14mm, fit: "contain")], [CASTER MOUNTING PLATE \ #text(size: 7.5pt, fill: luma(90))[#raw("FREE STANDING FRAME:1/CASTER ASSEMBLY:1/CASTER MOUNTING PLATE:1")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S1] Caster-to-mounting-plate fastening · candidate, requires review · required unknown (family, not specified); basis: 4 caster assemblies; attachment points per caster unverified · joint #raw("caster_to_plate")

#pagebreak(weak: true)
== Joint 2: caster\_plate\_to\_frame
#text(size: 8pt, fill: luma(90))[context #raw("FREE STANDING FRAME:1") (faded, 48 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-caster-plate-to-frame-b5403f0f.png", width: 100%), caption: [Joint 2: caster\_plate\_to\_frame, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(27)], [#image("images/part-data-projects-projects-by-lab-jayaraman-lab-flow-db2a93e4.png", width: 20mm, height: 14mm, fit: "contain")], [CASTER MOUNTING PLATE \ #text(size: 7.5pt, fill: luma(90))[#raw("FREE STANDING FRAME:1/CASTER ASSEMBLY:1/CASTER MOUNTING PLATE:1")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S2] Caster-plate-to-frame fastening · candidate, requires review · required unknown (family, not specified); basis: 4 plates; frame attachments per plate unverified · joint #raw("caster_plate_to_frame")

#pagebreak(weak: true)
== Joint 3: handle\_to\_panel
#text(size: 8pt, fill: luma(90))[context #raw("PANEL ASSEMBLY:1") (faded, 2 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-handle-to-panel-7eb6b2a9.png", width: 100%), caption: [Joint 3: handle\_to\_panel, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(33)], [#image("images/part-data-common-mcmaster-mcmaster-1950a67-unthreaded-f36d1af7.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 1950A67 Unthreaded-Hole Pull Handle \ #text(size: 7.5pt, fill: luma(90))[#raw("PANEL ASSEMBLY:1/MCMASTER_1950A67_Unthreaded-Hole Pull Handle:1")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S3] Pull-handle-to-panel fastening · candidate, requires review · required unknown (family, not specified); basis: 8 handles on 4 panels; fastening points per handle unverified · joint #raw("handle_to_panel")

#pagebreak(weak: true)
== Joint 4: clamp\_to\_mount
#text(size: 8pt, fill: luma(90))[context #raw("TOGGLE CLAMP ASSEMBLY:1") (faded, 1 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-clamp-to-mount-80584ace.png", width: 100%), caption: [Joint 4: clamp\_to\_mount, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(35)], [#image("images/part-data-common-mcmaster-mcmaster-5004a11-compact-ho-976424b5.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 5004A11 Compact Hold-Down Toggle Clamp \ #text(size: 7.5pt, fill: luma(90))[#raw("TOGGLE CLAMP ASSEMBLY:1/MCMASTER 5004A11_Compact Hold-Down Toggle Clamp:1")]],
  [#badge(36)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-4eb76845.png", width: 20mm, height: 14mm, fit: "contain")], [TOGGLE CLAMP MOUNT \ #text(size: 7.5pt, fill: luma(90))[#raw("TOGGLE CLAMP ASSEMBLY:1/TOGGLE CLAMP MOUNT:1")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S4] Toggle-clamp-to-mount fastening · candidate, requires review · required unknown (family, not specified); basis: 8 clamps on 4 mounts; points per clamp unverified · joint #raw("clamp_to_mount")

#pagebreak(weak: true)
== Joint 5: clamp\_mount\_to\_frame
#text(size: 8pt, fill: luma(90))[context #raw("FREE STANDING FRAME:1") (faded, 49 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-clamp-mount-to-frame-d49eee17.png", width: 100%), caption: [Joint 5: clamp\_mount\_to\_frame, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(36)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-4eb76845.png", width: 20mm, height: 14mm, fit: "contain")], [TOGGLE CLAMP MOUNT \ #text(size: 7.5pt, fill: luma(90))[#raw("TOGGLE CLAMP ASSEMBLY:1/TOGGLE CLAMP MOUNT:1")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S5] Toggle-clamp-mount-to-frame fastening · candidate, requires review · required unknown (family, not specified); basis: 4 mounts; points per mount unverified · joint #raw("clamp_mount_to_frame")

#pagebreak(weak: true)
== Joint 6: lower\_support\_to\_frame
#text(size: 8pt, fill: luma(90))[context #raw("FREE STANDING FRAME:1") (faded, 48 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-lower-support-to-frame-f99a8bd8.png", width: 100%), caption: [Joint 6: lower\_support\_to\_frame, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(30)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-08daa5a1.png", width: 20mm, height: 14mm, fit: "contain")], [PANEL LOWER SUPPORT LEFT \ #text(size: 7.5pt, fill: luma(90))[#raw("FREE STANDING FRAME:1/PANEL LOWER SUPPORT LEFT:1")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S6] Panel-lower-support fastening · candidate, requires review · required unknown (family, not specified); basis: 4 left + 4 right supports; points per support unverified · joint #raw("lower_support_to_frame")

#pagebreak(weak: true)
== Joint 7: main\_frame\_joints
#text(size: 8pt, fill: luma(90))[context #raw("FREE STANDING FRAME:1") (faded, 48 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-main-frame-joints-33ab23f4.png", width: 100%), caption: [Joint 7: main\_frame\_joints, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(24)], [#image("images/part-data-common-mcmaster-mcmaster-47065t245-ipt-prim-89f50e74.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 47065T245 \ #text(size: 7.5pt, fill: luma(90))[#raw("FREE STANDING FRAME:1/MCMASTER 47065T245:1")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S7] Main-frame connector hardware and joint completeness · candidate, requires review · required unknown (family, not specified); basis: 11 long rails + 4 columns + 2 short rails; joint count requires review · joint #raw("main_frame_joints")

#pagebreak(weak: true)
== Joint 8: camera\_frame\_joints
#text(size: 8pt, fill: luma(90))[context #raw("CAMERA FRAME:1") (faded, 35 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-camera-frame-joints-7c74766b.png", width: 100%), caption: [Joint 8: camera\_frame\_joints, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(9)], [#image("images/part-data-common-mcmaster-mcmaster-47065t845-silver-c-e1e40dd2.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 47065T845 Silver Corner Bracket \ #text(size: 7.5pt, fill: luma(90))[#raw("CAMERA FRAME:1/MCMASTER 47065T845_Silver Corner Bracket:1")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S8] Camera-frame connector and bracket hardware · candidate, requires review · required unknown (family, not specified); basis: 4 named 47065T845 brackets plus other connector/sliding parts · joint #raw("camera_frame_joints")

#pagebreak(weak: true)
== Joint 9: support\_frame\_corners
#text(size: 8pt, fill: luma(90))[context #raw("TANK SUPPORT FRAME:1") (faded, 21 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-support-frame-corners-b1810765.png", width: 100%), caption: [Joint 9: support\_frame\_corners, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(18)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-6dff85d6.png", width: 20mm, height: 14mm, fit: "contain")], [T SLOT CORNER 47065T242 \ #text(size: 7.5pt, fill: luma(90))[#raw("TANK SUPPORT FRAME:1/T SLOT CORNER 47065T242:1")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S9] Tank-support-frame corner hardware · candidate, requires review · required unknown (family, not specified); basis: 8 modeled corner connectors across 2 support frames · joint #raw("support_frame_corners")

#pagebreak(weak: true)
== Joint 10: support\_brackets
#text(size: 8pt, fill: luma(90))[context #raw("TANK SUPPORT FRAME:1") (faded, 21 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-support-brackets-9a12767f.png", width: 100%), caption: [Joint 10: support\_brackets, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(22)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-7481e885.png", width: 20mm, height: 14mm, fit: "contain")], [TANK SUPPORT BRACKET \ #text(size: 7.5pt, fill: luma(90))[#raw("TANK SUPPORT FRAME:1/TANK SUPPORT BRACKET:1")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S10] Tank-support-bracket attachment hardware · candidate, requires review · required unknown (family, not specified); basis: 8 brackets across 2 support frames · joint #raw("support_brackets")

#pagebreak(weak: true)
== Joint 11: vibration\_mounts
#text(size: 8pt, fill: luma(90))[context #raw("TANK SUPPORT FRAME:1") (faded, 20 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-vibration-mounts-d531e499.png", width: 100%), caption: [Joint 11: vibration\_mounts, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(19)], [#image("images/part-data-common-mcmaster-mcmaster-9378k24-natural-ru-fcf343fc.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 9378K24 Natural Rubber Vibration-Damping Sandwich Mount \ #text(size: 7.5pt, fill: luma(90))[#raw("TANK SUPPORT FRAME:1/MCMASTER 9378K24_Natural Rubber Vibration-Damping Sandwich Mount:1")]],
  [#badge(20)], [#image("images/part-data-common-mcmaster-mcmaster-90313a107-18-8-sta-34837649.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 90313A107 18-8 Stainless Steel Oversized Washer \ #text(size: 7.5pt, fill: luma(90))[#raw("TANK SUPPORT FRAME:1/MCMASTER 90313A107_18-8 Stainless Steel Oversized Washer:4")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S11] Vibration-mount retention hardware · candidate, requires review · required unknown (family, not specified); basis: 8 mounts + 8 oversized washers modeled · joint #raw("vibration_mounts")

#pagebreak(weak: true)
== Joint 12: camera\_plates
#text(size: 8pt, fill: luma(90))[context #raw("CAMERA FRAME:1") (faded, 34 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-camera-plates-b342e7ec.png", width: 100%), caption: [Joint 12: camera\_plates, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(15)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-94fc4c9b.png", width: 20mm, height: 14mm, fit: "contain")], [CAMERA MOUNT PLATE \ #text(size: 7.5pt, fill: luma(90))[#raw("CAMERA FRAME:1/CAMERA MOUNT PLATE:1")]],
  [#badge(16)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-b670923e.png", width: 20mm, height: 14mm, fit: "contain")], [CAMERA MOUNT PLATE - TELEDYNE KINETIX \ #text(size: 7.5pt, fill: luma(90))[#raw("CAMERA FRAME:1/CAMERA MOUNT PLATE - TELEDYNE KINETIX:1")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S12] Camera, spring and roller plate attachment hardware · candidate, requires review · required unknown (family, not specified); basis: 2 roller plates + 2 spring plates + 2 different camera plates · joint #raw("camera_plates")

#pagebreak(weak: true)
== Joint 13: spring\_roller
#text(size: 8pt, fill: luma(90))[context #raw("CAMERA FRAME:1") (faded, 31 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-spring-roller-de2a1790.png", width: 100%), caption: [Joint 13: spring\_roller, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(12)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-25d6cebc.png", width: 20mm, height: 14mm, fit: "contain")], [SPRING ROLLER \ #text(size: 7.5pt, fill: luma(90))[#raw("CAMERA FRAME:1/SPRING ROLLER:1")]],
  [#badge(10)], [#image("images/part-data-common-mcmaster-mcmaster-5972k164-ball-bear-66eca704.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 5972K164 Ball Bearing \ #text(size: 7.5pt, fill: luma(90))[#raw("CAMERA FRAME:1/MCMASTER 5972K164_Ball Bearing:2")]],
  [#badge(11)], [#image("images/part-data-common-mcmaster-mcmaster-90265a164-18-8-sta-591781bf.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 90265A164 18-8 Stainless Steel Shoulder Screw \ #text(size: 7.5pt, fill: luma(90))[#raw("CAMERA FRAME:1/MCMASTER 90265A164_18-8 Stainless Steel Shoulder Screw:1")]],
  [#badge(8)], [#image("images/part-data-common-mcmaster-mcmaster-9293k121-constant-a4593b94.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 9293K121 Constant-Force Spring \ #text(size: 7.5pt, fill: luma(90))[#raw("CAMERA FRAME:1/MCMASTER 9293K121_Constant-Force Spring:1")]],
  [#badge(10)], [#image("images/part-data-common-mcmaster-mcmaster-5972k164-ball-bear-66eca704.png", width: 20mm, height: 14mm, fit: "contain")], [MCMASTER 5972K164 Ball Bearing \ #text(size: 7.5pt, fill: luma(90))[#raw("CAMERA FRAME:1/MCMASTER 5972K164_Ball Bearing:1")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S13] Spring end and roller/bearing retention hardware · candidate, requires review · required unknown (family, not specified); basis: 2 springs + 2 rollers + 4 bearings + 2 shoulder screws modeled · joint #raw("spring_roller")

#pagebreak(weak: true)
== Joint 14: camera\_attachment
#text(size: 8pt, fill: luma(90))[context #raw("CAMERA FRAME:1") (faded, 34 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-camera-attachment-00846eca.png", width: 100%), caption: [Joint 14: camera\_attachment, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(15)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-94fc4c9b.png", width: 20mm, height: 14mm, fit: "contain")], [CAMERA MOUNT PLATE \ #text(size: 7.5pt, fill: luma(90))[#raw("CAMERA FRAME:1/CAMERA MOUNT PLATE:1")]],
  [#badge(16)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-b670923e.png", width: 20mm, height: 14mm, fit: "contain")], [CAMERA MOUNT PLATE - TELEDYNE KINETIX \ #text(size: 7.5pt, fill: luma(90))[#raw("CAMERA FRAME:1/CAMERA MOUNT PLATE - TELEDYNE KINETIX:1")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S14] Camera-to-mount attachment · candidate, requires review · required unknown (family, not specified); basis: Camera plate variants present; actual camera selection unconfirmed · joint #raw("camera_attachment")

#pagebreak(weak: true)
== Joint 15: top\_panel
#text(size: 8pt, fill: luma(90))[context #raw("root") (faded, 154 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-top-panel-c690cb86.png", width: 100%), caption: [Joint 15: top\_panel, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(34)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-389173d2.png", width: 20mm, height: 14mm, fit: "contain")], [ENCLOSURE TOP PANEL \ #text(size: 7.5pt, fill: luma(90))[#raw("ENCLOSURE TOP PANEL:1")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S15] Top-panel retention and edge/support interface · candidate, requires review · required unknown (family, not specified); basis: 1 enclosure top panel · joint #raw("top_panel")

#pagebreak(weak: true)
== Joint 16: panel\_retention
#text(size: 8pt, fill: luma(90))[context #raw("FREE STANDING FRAME:1") (faded, 47 other occurrence(s))]

#text(size: 9pt)[inspection view, not a step: the joint's occurrences at their CAD poses with the rest of the context subdued; no fastener, sequence or tool access implied.]

#figure(image("images/joint-panel-retention-b0e31116.png", width: 100%), caption: [Joint 16: panel\_retention, occurrences at their CAD positions (inspection view, not a step).])

#table(columns: (auto, 22mm, 1fr), align: (center + horizon, center + horizon, left + horizon), stroke: 0.5pt + luma(140),
  table.header([*\#*], [*Picture*], [*Occurrence in this joint*]),
  [#badge(30)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-08daa5a1.png", width: 20mm, height: 14mm, fit: "contain")], [PANEL LOWER SUPPORT LEFT \ #text(size: 7.5pt, fill: luma(90))[#raw("FREE STANDING FRAME:1/PANEL LOWER SUPPORT LEFT:1")]],
  [#badge(31)], [#image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-20c0f88f.png", width: 20mm, height: 14mm, fit: "contain")], [PANEL LOWER SUPPORT RIGHT \ #text(size: 7.5pt, fill: luma(90))[#raw("FREE STANDING FRAME:1/PANEL LOWER SUPPORT RIGHT:2")]],
)

#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[Hardware to review at this joint (not an approved BOM)]
- #sbadge[S16] Removable-panel retention interface · candidate, requires review · required unknown (family, not specified); basis: 4 panels, 8 lower supports, 8 toggle clamps · joint #raw("panel_retention")

#pagebreak()
== Step 1
#text(size: 8pt, fill: luma(90))[\[bottom-frame\]]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(28) #h(2pt) #text(size: 16pt, weight: "bold")[×2] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-0debaac0.png", width: 26mm, height: 20mm, fit: "contain") \
    #badge(23) #h(2pt) #text(size: 16pt, weight: "bold")[×3] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-11d4d431.png", width: 26mm, height: 20mm, fit: "contain") \
    #badge(24) #h(2pt) #text(size: 16pt, weight: "bold")[×4] \
    #image("images/part-data-common-mcmaster-mcmaster-47065t245-ipt-prim-89f50e74.png", width: 26mm, height: 20mm, fit: "contain") \
  ],
  figure(image("images/step-01-bottom-frame.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[Lay out the bottom frame: lower rails and corner connectors. Order among rails is free; square the frame before tightening. Hardware: see joints main\_frame\_joints.]

#pagebreak()
== Step 2
#text(size: 8pt, fill: luma(90))[\[casters\] after bottom-frame]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(27) #h(2pt) #text(size: 16pt, weight: "bold")[×4] \
    #image("images/part-data-projects-projects-by-lab-jayaraman-lab-flow-db2a93e4.png", width: 26mm, height: 20mm, fit: "contain") \
    #badge(26) #h(2pt) #text(size: 16pt, weight: "bold")[×4] \
    #image("images/part-data-projects-projects-by-lab-jayaraman-lab-flow-72f0778a.png", width: 26mm, height: 20mm, fit: "contain") \
  ],
  figure(image("images/step-02-casters.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[Bolt each caster to its mounting plate and attach the four plates under the bottom frame corners (joints caster\_to\_plate, caster\_plate\_to\_frame). Hardware unverified.]

#pagebreak()
== Step 3
#text(size: 8pt, fill: luma(90))[\[columns\] after casters]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(25) #h(2pt) #text(size: 16pt, weight: "bold")[×4] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-f6258a3b.png", width: 26mm, height: 20mm, fit: "contain") \
  ],
  figure(image("images/step-03-columns.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[Stand the four 96 in columns on the bottom frame corners.]

#pagebreak()
== Step 4
#text(size: 8pt, fill: luma(90))[\[middle-rails\] after columns]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(23) #h(2pt) #text(size: 16pt, weight: "bold")[×4] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-11d4d431.png", width: 26mm, height: 20mm, fit: "contain") \
    #badge(29) #h(2pt) #text(size: 16pt, weight: "bold")[×8] \
    #image("images/part-data-common-mcmaster-47065t271-aluminum-t-slotte-56fa5cf0.png", width: 26mm, height: 20mm, fit: "contain") \
  ],
  figure(image("images/step-04-middle-rails.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[Add the mid-height rails and extrusions between the columns.]

#pagebreak()
== Step 5
#text(size: 8pt, fill: luma(90))[\[top-frame\] after middle-rails]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(23) #h(2pt) #text(size: 16pt, weight: "bold")[×4] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-11d4d431.png", width: 26mm, height: 20mm, fit: "contain") \
    #badge(24) #h(2pt) #text(size: 16pt, weight: "bold")[×4] \
    #image("images/part-data-common-mcmaster-mcmaster-47065t245-ipt-prim-89f50e74.png", width: 26mm, height: 20mm, fit: "contain") \
  ],
  figure(image("images/step-05-top-frame.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[Close the top frame: upper rails and corner connectors.]

#pagebreak()
== Step 6
#text(size: 8pt, fill: luma(90))[\[lower-supports\] after top-frame]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(30) #h(2pt) #text(size: 16pt, weight: "bold")[×4] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-08daa5a1.png", width: 26mm, height: 20mm, fit: "contain") \
    #badge(31) #h(2pt) #text(size: 16pt, weight: "bold")[×4] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-20c0f88f.png", width: 26mm, height: 20mm, fit: "contain") \
  ],
  figure(image("images/step-06-lower-supports.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[Fit the eight panel lower supports (left and right) to the frame (joint lower\_support\_to\_frame).]

#pagebreak()
== Step 7
#text(size: 8pt, fill: luma(90))[\[toggle-clamps\] after lower-supports]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(35) #h(2pt) #text(size: 16pt, weight: "bold")[×8] \
    #image("images/part-data-common-mcmaster-mcmaster-5004a11-compact-ho-976424b5.png", width: 26mm, height: 20mm, fit: "contain") \
    #badge(36) #h(2pt) #text(size: 16pt, weight: "bold")[×4] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-4eb76845.png", width: 26mm, height: 20mm, fit: "contain") \
  ],
  figure(image("images/step-07-toggle-clamps.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[Assemble the four toggle-clamp mounts (two clamps each) and attach them to the columns (joints clamp\_to\_mount, clamp\_mount\_to\_frame).]

#pagebreak()
== Step 8
#text(size: 8pt, fill: luma(90))[\[camera-frame-structure\] after toggle-clamps]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(6) #h(2pt) #text(size: 12pt, weight: "bold")[×2] \
    #image("images/part-data-common-mcmaster-mcmaster-3136n149-t-slotted-77d5b1ed.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(7) #h(2pt) #text(size: 12pt, weight: "bold")[×4] \
    #image("images/part-data-common-mcmaster-mcmaster-47065t27-t-slotted-63467688.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(9) #h(2pt) #text(size: 12pt, weight: "bold")[×4] \
    #image("images/part-data-common-mcmaster-mcmaster-47065t845-silver-c-e1e40dd2.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(1) #h(2pt) #text(size: 12pt, weight: "bold")[×2] \
    #image("images/part-data-common-mcmaster-mcmaster-5537t293-t-slotted-1c2935ff.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(2) #h(2pt) #text(size: 12pt, weight: "bold")[×2] \
    #image("images/part-data-common-mcmaster-mcmaster-5537t429-t-slotted-72ff3dc4.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(3) #h(2pt) #text(size: 12pt, weight: "bold")[×2] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-64014b81.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(4) #h(2pt) #text(size: 12pt, weight: "bold")[×2] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-567ca529.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(5) #h(2pt) #text(size: 12pt, weight: "bold")[×2] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-f37ea6b9.png", width: 16mm, height: 12mm, fit: "contain") \
  ],
  figure(image("images/step-08-camera-frame-structure.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[Assemble the camera frame extrusions and corner brackets (joint camera\_frame\_joints).]

#pagebreak()
== Step 9
#text(size: 8pt, fill: luma(90))[\[camera-frame-mechanism\] after camera-frame-structure]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(10) #h(2pt) #text(size: 12pt, weight: "bold")[×4] \
    #image("images/part-data-common-mcmaster-mcmaster-5972k164-ball-bear-66eca704.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(11) #h(2pt) #text(size: 12pt, weight: "bold")[×2] \
    #image("images/part-data-common-mcmaster-mcmaster-90265a164-18-8-sta-591781bf.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(8) #h(2pt) #text(size: 12pt, weight: "bold")[×2] \
    #image("images/part-data-common-mcmaster-mcmaster-9293k121-constant-a4593b94.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(13) #h(2pt) #text(size: 12pt, weight: "bold")[×2] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-6a8f878a.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(14) #h(2pt) #text(size: 12pt, weight: "bold")[×2] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-eb93feb5.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(12) #h(2pt) #text(size: 12pt, weight: "bold")[×2] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-25d6cebc.png", width: 16mm, height: 12mm, fit: "contain") \
  ],
  figure(image("images/step-09-camera-frame-mechanism.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[Fit the roller and spring mechanism: roller plates, spring plates, rollers, bearings, shoulder screws, springs (joint spring\_roller).]

#pagebreak()
== Step 10
#text(size: 8pt, fill: luma(90))[\[camera-plates\] after camera-frame-mechanism]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(15) #h(2pt) #text(size: 16pt, weight: "bold")[×1] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-94fc4c9b.png", width: 26mm, height: 20mm, fit: "contain") \
    #badge(16) #h(2pt) #text(size: 16pt, weight: "bold")[×1] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-b670923e.png", width: 26mm, height: 20mm, fit: "contain") \
  ],
  figure(image("images/step-10-camera-plates.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[Fit the camera mount plates (joints camera\_plates, camera\_attachment). The camera itself is not in CAD.]

#pagebreak()
== Step 11
#text(size: 8pt, fill: luma(90))[\[panel-1\] after camera-plates]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(32) #h(2pt) #text(size: 16pt, weight: "bold")[×1] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-e022258d.png", width: 26mm, height: 20mm, fit: "contain") \
    #badge(33) #h(2pt) #text(size: 16pt, weight: "bold")[×2] \
    #image("images/part-data-common-mcmaster-mcmaster-1950a67-unthreaded-f36d1af7.png", width: 26mm, height: 20mm, fit: "contain") \
  ],
  figure(image("images/step-11-panel-1.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[Fit two pull handles to panel 1 (joint handle\_to\_panel) and hang the panel on its lower supports and toggle clamps (joint panel\_retention).]

#pagebreak()
== Step 12
#text(size: 8pt, fill: luma(90))[\[panel-2\] after panel-1]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(32) #h(2pt) #text(size: 16pt, weight: "bold")[×1] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-e022258d.png", width: 26mm, height: 20mm, fit: "contain") \
    #badge(33) #h(2pt) #text(size: 16pt, weight: "bold")[×2] \
    #image("images/part-data-common-mcmaster-mcmaster-1950a67-unthreaded-f36d1af7.png", width: 26mm, height: 20mm, fit: "contain") \
  ],
  figure(image("images/step-12-panel-2.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[Fit two pull handles to panel 2 (joint handle\_to\_panel) and hang the panel on its lower supports and toggle clamps (joint panel\_retention).]

#pagebreak()
== Step 13
#text(size: 8pt, fill: luma(90))[\[panel-3\] after panel-2]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(32) #h(2pt) #text(size: 16pt, weight: "bold")[×1] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-e022258d.png", width: 26mm, height: 20mm, fit: "contain") \
    #badge(33) #h(2pt) #text(size: 16pt, weight: "bold")[×2] \
    #image("images/part-data-common-mcmaster-mcmaster-1950a67-unthreaded-f36d1af7.png", width: 26mm, height: 20mm, fit: "contain") \
  ],
  figure(image("images/step-13-panel-3.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[Fit two pull handles to panel 3 (joint handle\_to\_panel) and hang the panel on its lower supports and toggle clamps (joint panel\_retention).]

#pagebreak()
== Step 14
#text(size: 8pt, fill: luma(90))[\[panel-4\] after panel-3]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(32) #h(2pt) #text(size: 16pt, weight: "bold")[×1] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-e022258d.png", width: 26mm, height: 20mm, fit: "contain") \
    #badge(33) #h(2pt) #text(size: 16pt, weight: "bold")[×2] \
    #image("images/part-data-common-mcmaster-mcmaster-1950a67-unthreaded-f36d1af7.png", width: 26mm, height: 20mm, fit: "contain") \
  ],
  figure(image("images/step-14-panel-4.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[Fit two pull handles to panel 4 (joint handle\_to\_panel) and hang the panel on its lower supports and toggle clamps (joint panel\_retention).]

#pagebreak()
== Step 15
#text(size: 8pt, fill: luma(90))[\[top-panel\] after panel-4]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(34) #h(2pt) #text(size: 16pt, weight: "bold")[×1] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-389173d2.png", width: 26mm, height: 20mm, fit: "contain") \
  ],
  figure(image("images/step-15-top-panel.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[Place the top panel (joint top\_panel: nothing in CAD retains it).]

#pagebreak()
== Step 16
#text(size: 8pt, fill: luma(90))[\[conditional-tank-support-frame-1\] after top-panel]
#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[CONDITIONAL: install in phase 1 only if it cannot be installed after the frame and panels are assembled; otherwise defer with the tanks]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(20) #h(2pt) #text(size: 12pt, weight: "bold")[×4] \
    #image("images/part-data-common-mcmaster-mcmaster-90313a107-18-8-sta-34837649.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(19) #h(2pt) #text(size: 12pt, weight: "bold")[×4] \
    #image("images/part-data-common-mcmaster-mcmaster-9378k24-natural-ru-fcf343fc.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(18) #h(2pt) #text(size: 12pt, weight: "bold")[×4] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-6dff85d6.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(22) #h(2pt) #text(size: 12pt, weight: "bold")[×4] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-7481e885.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(21) #h(2pt) #text(size: 12pt, weight: "bold")[×1] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-a3951cbf.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(17) #h(2pt) #text(size: 12pt, weight: "bold")[×4] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-72135c80.png", width: 16mm, height: 12mm, fit: "contain") \
  ],
  figure(image("images/step-16-conditional-tank-support-frame-1.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[CONDITIONAL (build-scope.json): TANK SUPPORT FRAME:1, the tank support frame. Install now only if it cannot be installed after the panels; otherwise defer with the tanks. Joints support\_frame\_corners, support\_brackets, vibration\_mounts.]

#pagebreak()
== Step 17
#text(size: 8pt, fill: luma(90))[\[conditional-tank-support-frame-2\] after conditional-tank-support-frame-1]
#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[CONDITIONAL: install in phase 1 only if it cannot be installed after the frame and panels are assembled; otherwise defer with the tanks]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(20) #h(2pt) #text(size: 12pt, weight: "bold")[×4] \
    #image("images/part-data-common-mcmaster-mcmaster-90313a107-18-8-sta-34837649.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(19) #h(2pt) #text(size: 12pt, weight: "bold")[×4] \
    #image("images/part-data-common-mcmaster-mcmaster-9378k24-natural-ru-fcf343fc.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(18) #h(2pt) #text(size: 12pt, weight: "bold")[×4] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-6dff85d6.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(22) #h(2pt) #text(size: 12pt, weight: "bold")[×4] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-7481e885.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(21) #h(2pt) #text(size: 12pt, weight: "bold")[×1] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-a3951cbf.png", width: 16mm, height: 12mm, fit: "contain") \
    #badge(17) #h(2pt) #text(size: 12pt, weight: "bold")[×4] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-enclos-72135c80.png", width: 16mm, height: 12mm, fit: "contain") \
  ],
  figure(image("images/step-17-conditional-tank-support-frame-2.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[CONDITIONAL (build-scope.json): TANK SUPPORT FRAME:2, the tank support frame. Install now only if it cannot be installed after the panels; otherwise defer with the tanks. Joints support\_frame\_corners, support\_brackets, vibration\_mounts.]

#pagebreak()
= Deferred steps (not in this build)
#text(size: 9pt)[These steps place items outside phase-1; they are shown seated on the finished build for completeness and are not part of the build sequence above.]

== Step 18
#text(size: 8pt, fill: luma(90))[\[deferred-tanks\] after conditional-tank-support-frame-2]
#text(size: 9pt, weight: "bold", fill: rgb("#b4400a"))[DEFERRED: not in this build]

#grid(columns: (34mm, 1fr), column-gutter: 6mm, row-gutter: 4mm,
  block(stroke: (paint: luma(120), dash: "dashed"), inset: 5pt, width: 100%)[
    #set par(spacing: 0pt); #set block(spacing: 0pt)
    #text(size: 7.5pt, fill: luma(80))[PARTS NEEDED] \
    #badge(37) #h(2pt) #text(size: 16pt, weight: "bold")[×3] \
    #image("images/part-data-projects-projects-by-lab-schulze-lab-2w-353-00b2841c.png", width: 26mm, height: 20mm, fit: "contain") \
  ],
  figure(image("images/step-18-deferred-tanks.png", width: 100%), caption: [Place as shown.]),
)

#text(size: 12pt)[DEFERRED (build-scope.json): the tanks are not part of phase 1 and are listed here only because every CAD occurrence must appear once. They are to be replaced by monitors and bowls.]

#pagebreak(weak: true)
== Build record
#set text(size: 8pt)
#table(columns: (30%, 1fr), stroke: 0.4pt + luma(160), align: left + horizon,
  [generated], [2026-10-23T15:40:18Z],
  [scene], [free-standing-enclosure-991056: Free Standing Enclosure (Vault file-version 991056) native snapshot (37 parts, 155 occurrences, 17 assemblies)],
  [source kind], [autodesk-inventor-vault-snapshot],
  [source root\_version\_id], [991056],
  [source exporter], [windows/Export-PartAssets.ps1 on Inventor 2025.3],
  [source qualification], [geometry/hierarchy snapshot; not a reviewed assembly procedure or stock inventory],
  [source occurrence\_id\_scope], [snapshot-scoped occurrence paths (Inventor occurrence names); stable only within this snapshot],
  [scene.json], [`ac203e5656abdeeadbadf5f047e31f244e01f8938001c5747a44808ffc4ed070`],
  [instructions.json], [`9de40bb2e8925e5f456645efd9c465bfc3576103fd1ac0d4f3bf45e6d5c6d3f5`],
  [inventory.json], [`0eed5897bb238c1334e92e19927db8573480f3c7d4778099fa02b09e605298de`],
  [supplement.json], [`c9950ec3f72db98f8d3563adaec0fb48ba50fce689fbb905dbe050ce0e4081ba`],
  [build-scope.json], [`b835cb40d41f9b05eadb57ca58dfdaf7ae0a05deddb1c951bcc009325f2d4911`],
  [assets], [37 STEP files; hashes in manual.json],
  [FreeCAD], [1.1.3; deflection 0.05 mm / 10.0°, budget 50000 triangles per part; meshes.json #raw("91c004502b7a089aac81b6d07810e5eae461b3174bfaaca41c468ba3a5a6f414")],
  [Blender], [4.5.14 LTS, engine CYCLES, denoiser OPENIMAGEDENOISE, samples 64, long side 1600 px; line art on up to 600000 visible triangles; settings #raw("94534a5410b48956efa4f48c2626ab3b0f08ae3cb5c1c6c6495fc0dc789e620b")],
  [reused views], [68 of 86 images copied from an earlier run with the same inputs, meshes and engine (build/enclosure-snapshot-991056/renders10/render-receipt.json); per-view record in manual.json],
  [render warning], [step-07-toggle-clamps: 909744 visible triangles exceed lines.max\_triangles (600000); rendered without line art],
  [render warning], [step-08-camera-frame-structure: 1180312 visible triangles exceed lines.max\_triangles (600000); rendered without line art],
  [render warning], [step-09-camera-frame-mechanism: 1379408 visible triangles exceed lines.max\_triangles (600000); rendered without line art],
  [render warning], [step-10-camera-plates: 1382084 visible triangles exceed lines.max\_triangles (600000); rendered without line art],
  [render warning], [step-11-panel-1: 1473284 visible triangles exceed lines.max\_triangles (600000); rendered without line art],
  [render warning], [step-12-panel-2: 1564484 visible triangles exceed lines.max\_triangles (600000); rendered without line art],
  [render warning], [step-13-panel-3: 1655684 visible triangles exceed lines.max\_triangles (600000); rendered without line art],
  [render warning], [step-14-panel-4: 1746884 visible triangles exceed lines.max\_triangles (600000); rendered without line art],
  [render warning], [step-15-top-panel: 1749932 visible triangles exceed lines.max\_triangles (600000); rendered without line art],
  [render warning], [step-16-conditional-tank-support-frame-1: 2092304 visible triangles exceed lines.max\_triangles (600000); rendered without line art],
  [render warning], [step-17-conditional-tank-support-frame-2: 2434676 visible triangles exceed lines.max\_triangles (600000); rendered without line art],
  [render warning], [step-18-deferred-tanks: 2436488 visible triangles exceed lines.max\_triangles (600000); rendered without line art],
  [images], [86 renders; hashes in manual.json],
  [supplement.json], [20 row(s): 16 existing design, 4 new design; never added to CAD quantities],
  [generator], [python 3.12.12; platform Linux-6.12.113+deb13-amd64-x86\_64-with-glibc2.41; package mechanical-docs],
)
Review state draft; physical assembly not validated.
