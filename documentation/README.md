# Generated documentation

Built manuals for this project, copied here by `assembly/publish_manual.py` from a
verified mechanical-docs build so the repository carries the documentation that matches
its committed sources. Each package holds `index.html` with its `images/`, the PDF(s),
`manual.json`, the Typst source, the build receipt, the check report and `SOURCE.json`
(input hashes, PDF hashes, page counts, evidence run). Open `index.html` locally or print
the PDF. Everything is draft until the physical build confirms it.

| Package | Content | Status |
| --- | --- | --- |
| `enclosure/` | Pictorial parts inventory with CAD quantities and paper count boxes, six subassembly inspection views, sixteen joint close-ups with "hardware to review" lists, supplementary (non-CAD) items, project note; compact PDF 36 pages, appendix PDF 53 pages | draft, 2026-10-22; phase-1 build scope and draft steps are being added |

Sources: `references/enclosure/` (accepted CAD snapshot), `assembly/render.json`,
`assembly/instructions.json`, `assembly/build-scope.json`, `assembly/procurement/`,
`assembly/project-notes.json`; recipe in `assembly/documentation-workflow.md`.
