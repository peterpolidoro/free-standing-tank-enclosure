# Short forms of this project's commands. `make` alone lists them.

# The mechanical-cad checkout, whose commands the CAD targets run. It is looked for beside this
# repository. When it is somewhere else, say so once: in local.mk here, which Git ignores, with the line
#     MECHANICAL_CAD = /path/to/mechanical-cad
# or in the environment.
-include local.mk
MECHANICAL_CAD ?= ../mechanical-cad
MECHANICAL_CAD_MAKE = $(MAKE) --no-print-directory -C "$(MECHANICAL_CAD)" PROJECT="$(CURDIR)"
# The assembly mirrored from Vault: what `make assembly` and `make open` build when no KEY is given. It is named
# because designs/assemblies/ holds assemblies of its own that nothing places.
ROOT_ASSEMBLY = free-standing-enclosure

# Documentation site (GitHub Pages). The manual itself is produced by the mechanical-docs
# recipe in assembly/documentation-workflow.md and committed under docs/manual/.
GUIX_SHELL_SITE = guix shell --pure -m .guix/manifest-site.scm
SITE_DIR = site

.DEFAULT_GOAL := help
.PHONY: help mechanical-cad validate check part fit cut print print-check assemblies assembly open picture reference-scene site site-serve site-pages \
        phase-parts-list draft-instructions materials-manifest

help:
	@echo "CAD, run by mechanical-cad ($(MECHANICAL_CAD)):"
	@echo "  make validate            check references/ and designs/ against the layout"
	@echo "  make part KEY=K          build the authored part K from its program or its FreeCAD document"
	@echo "  make check               evaluate the checks of every authored part"
	@echo "  make fit KEY=K SUBJECT='NAME[,NAME]'   do those children of the assembly K fit among the rest"
	@echo "  make assemblies          list the assemblies, and which are built"
	@echo "  make assembly            build the whole enclosure as one STEP file and one FreeCAD document"
	@echo "  make assembly KEY=K      build the assembly K of that list"
	@echo "  make open                build the whole enclosure if need be, then open it in the FreeCAD window"
	@echo "  make open KEY=K          the same for the assembly K"
	@echo "  make picture KEY=K       pictures of a part, or of a built assembly, into .cache/pictures/"
	@echo "                           [VIEWS=iso,below,+x] [UP=+Y]: where the camera stands, which axis is up"
	@echo "  make cut KEY=K           the drawing to cut a plate from sheet, into .cache/cut/, checked against the solid"
	@echo "  make print KEY=K         the mesh to print a part from, into .cache/print/, checked and shown to a slicer"
	@echo "  make print-check KEY=K   will the part print as it lies: the plate, overhangs, material that starts in mid-air"
	@echo "  make reference-scene     flatten the scene the manual and the scripts under assembly/ read"
	@echo "Documentation site:"
	@echo "  make site                build it into $(SITE_DIR)/"
	@echo "  make site-serve          serve it locally"
	@echo "  make site-pages          regenerate its pages from the published manual package"
	@echo "Project data, from the CAD snapshot:"
	@echo "  make phase-parts-list    make draft-instructions    make materials-manifest"
	@echo "Built assemblies and the scene are under .cache/, which Git ignores."

# The CAD targets need the mechanical-cad checkout.
mechanical-cad:
	@test -f "$(MECHANICAL_CAD)/Makefile" || { \
	  echo "There is no mechanical-cad checkout with a Makefile at $(MECHANICAL_CAD)."; \
	  echo "Say where it is: put the line  MECHANICAL_CAD = /path/to/mechanical-cad  in local.mk here (Git ignores it)."; \
	  exit 2; }

validate: mechanical-cad
	@$(MECHANICAL_CAD_MAKE) validate

# An authored part under designs/parts/, from its program or its FreeCAD document; then its checks.
# mechanical-cad's docs/adding-a-part.md walks through adding one.
part: mechanical-cad
	@$(MECHANICAL_CAD_MAKE) part KEY="$(KEY)"

check: mechanical-cad
	@$(MECHANICAL_CAD_MAKE) check

fit: mechanical-cad
	@$(MECHANICAL_CAD_MAKE) fit KEY="$(KEY)" SUBJECT="$(SUBJECT)" CLEARANCE="$(CLEARANCE)"

# Files to make an authored part from, derived and ignored: a drawing for a plate cut from sheet, a mesh for a
# printed part. Each is checked against the part's solid.
cut: mechanical-cad
	@$(MECHANICAL_CAD_MAKE) cut KEY="$(KEY)"

print: mechanical-cad
	@$(MECHANICAL_CAD_MAKE) print KEY="$(KEY)" DEFLECTION="$(DEFLECTION)"

print-check: mechanical-cad
	@$(MECHANICAL_CAD_MAKE) print-check KEY="$(KEY)" UP="$(UP)" ANGLE="$(ANGLE)" STEP="$(STEP)"

# What can be built: every assembly under references/assemblies/ and designs/assemblies/.
assemblies: mechanical-cad
	@$(MECHANICAL_CAD_MAKE) assemblies
	@echo "Build one: make assembly KEY=<key>   (make assembly alone builds the top-level one)"

# One STEP file and one FreeCAD document of an assembly, in the ignored .cache/assemblies/.
# They are for looking at; the part files and the manifests under references/ stay the source.
assembly: mechanical-cad
	@$(MECHANICAL_CAD_MAKE) assembly KEY="$(or $(KEY),$(ROOT_ASSEMBLY))"

# The same, then the FreeCAD document opened in the FreeCAD window, which guix shell provides.
# The command returns when the window is closed.
open: mechanical-cad
	@$(MECHANICAL_CAD_MAKE) open KEY="$(or $(KEY),$(ROOT_ASSEMBLY))"

# Pictures without a window, for a person or an agent to look at: of a part from its part.step, of an
# assembly from the file `make assembly` built.
picture: mechanical-cad
	@$(MECHANICAL_CAD_MAKE) picture KEY="$(KEY)" VIEWS="$(VIEWS)" UP="$(UP)"

# The scene the scripts below and the manual read, flattened from references/ into the ignored
# .cache/reference-scene/.
reference-scene: mechanical-cad
	guix shell --pure -m manifest.scm -- python3 -B assembly/reference_scene.py --mechanical-cad "$(MECHANICAL_CAD)"

site:
	$(GUIX_SHELL_SITE) -- mkdocs build --strict --site-dir "$(SITE_DIR)"

site-serve:
	$(GUIX_SHELL_SITE) -- mkdocs serve

# Regenerate the site pages from the published manual package (publish_manual.py does this too).
site-pages:
	python3 assembly/site_pages.py

# Project data derived from the accepted CAD snapshot and assembly/build-scope.json.
phase-parts-list:
	guix shell --pure -m manifest.scm -- python3 assembly/phase_parts_list.py

draft-instructions:
	guix shell --pure -m manifest.scm -- python3 assembly/draft_instructions.py

# Curated materials file beside the STEP references: refreshes CAD claims, keeps curated rows.
materials-manifest:
	python3 assembly/materials_manifest.py
