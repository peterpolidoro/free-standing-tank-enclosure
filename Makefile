# Documentation site (GitHub Pages). The manual itself is produced by the mechanical-docs
# recipe in assembly/documentation-workflow.md and committed under docs/manual/.
GUIX_SHELL_SITE = guix shell --pure -m .guix/manifest-site.scm
SITE_DIR = site

.PHONY: site site-serve phase-parts-list draft-instructions

site:
	$(GUIX_SHELL_SITE) -- mkdocs build --strict --site-dir "$(SITE_DIR)"

site-serve:
	$(GUIX_SHELL_SITE) -- mkdocs serve

# Project data derived from the accepted CAD snapshot and assembly/build-scope.json.
phase-parts-list:
	guix shell --pure -m manifest.scm -- python3 assembly/phase_parts_list.py

draft-instructions:
	guix shell --pure -m manifest.scm -- python3 assembly/draft_instructions.py
