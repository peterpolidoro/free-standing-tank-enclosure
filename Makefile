# Documentation site (GitHub Pages). The manual itself is produced by the mechanical-docs
# recipe in assembly/documentation-workflow.md and committed under docs/manual/.
GUIX_SHELL_SITE = guix shell --pure -m .guix/manifest-site.scm
SITE_DIR = site

.PHONY: site site-serve site-pages phase-parts-list draft-instructions materials-manifest

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
