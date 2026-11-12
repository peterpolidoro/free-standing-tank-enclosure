# Short forms of this project's commands. `make` alone lists them.

# The mechanical-cad checkout, whose commands the CAD targets run. It is looked for beside this
# repository. When it is somewhere else, say so once: in local.mk here, which Git ignores, with the line
#     MECHANICAL_CAD = /path/to/mechanical-cad
# or in the environment.
-include local.mk
MECHANICAL_CAD ?= ../mechanical-cad
MECHANICAL_CAD_MAKE = $(MAKE) --no-print-directory -C "$(MECHANICAL_CAD)" PROJECT="$(CURDIR)"

# Documentation site (GitHub Pages). The manual itself is produced by the mechanical-docs
# recipe in assembly/documentation-workflow.md and committed under docs/manual/.
GUIX_SHELL_SITE = guix shell --pure -m .guix/manifest-site.scm
SITE_DIR = site

.DEFAULT_GOAL := help
.PHONY: help mechanical-cad validate assemblies assembly reference-scene site site-serve site-pages \
        phase-parts-list draft-instructions materials-manifest

help:
	@echo "CAD, run by mechanical-cad ($(MECHANICAL_CAD)):"
	@echo "  make validate            check references/ and designs/ against the layout"
	@echo "  make assemblies          list the assemblies, and which are built"
	@echo "  make assembly            build the whole enclosure as one STEP file and one FreeCAD document"
	@echo "  make assembly KEY=K      build the assembly K of that list"
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

# What can be built: every assembly under references/assemblies/ and designs/assemblies/.
assemblies: mechanical-cad
	@$(MECHANICAL_CAD_MAKE) assemblies
	@echo "Build one: make assembly KEY=<key>   (make assembly alone builds the top-level one)"

# One STEP file and one FreeCAD document of an assembly, in the ignored .cache/assemblies/.
# They are for looking at; the part files and the manifests under references/ stay the source.
assembly: mechanical-cad
	@$(MECHANICAL_CAD_MAKE) assembly KEY="$(KEY)"

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
