# Minimal makefile for Sphinx documentation

# Variables (can be overridden from environment or command line)
SPHINXBUILD ?= sphinx-build
SPHINXOPTS  ?=
SOURCEDIR   = source
BUILDDIR    = _build

# Default targets
.PHONY: help html latexpdf clean

# Build HTML documentation
html:
	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS)

# Build PDF (LaTeX) documentation
latexpdf:
	@$(SPHINXBUILD) -M latexpdf "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS)

# Show help
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS)

# Clean build directory
clean:
	@echo "Removing $(BUILDDIR) directory..."
	@rm -rf $(BUILDDIR)

# Catch-all target: route unknown targets to Sphinx
%:
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS)
