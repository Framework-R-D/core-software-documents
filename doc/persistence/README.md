# FORM Design Documentation Directory

This directory contains the Sphinx documentation for the project.

---

## Directory Structure

```
**persistence/**
├── FORM Requirement Doc.md
├── Makefile
├── README.md
└── **source**
```

- `FORM Requirement Doc.md`
  Provides general requirements for FORM.

- `Makefile`  
  Provides build commands for generating documentation.

- `source/`  
  Contains the Sphinx source files (reStructuredText or Markdown).

```
source/
├── conf.py
├── index.rst
├── docutils.conf
├── *.rst
├── refs.bib
├── appendix/
├── _diagrams/
└── _static/
```
### Key Files

- `conf.py`  
  The main Sphinx configuration file.  
  Defines project information, extensions, themes, and build options.

- `index.rst`  
  The main entry point of the documentation.  
  Contains the table of contents (`toctree`) and links to other pages.

- `docutils.conf`  
  Configuration file for Docutils (used internally by Sphinx).  
  It can define default build options, LaTeX settings, encoding, and other processing parameters.

- `*.rst` 
  Documentation source files written in reStructuredText.

- `ref.bib` 
  BibTeX database used for citations in the Sphinx documentation.

- `appendix/` 
  Appendix files in `.rst`. 

- `_diagrams/`  
  Optional directory for original diagram source files (`.drawio` and `*inkscape.svg`).
  Most diagrams use `.drawio` as the source format. However, `read-operation-inkscape.svg` and `read-operation-inkscape.svg` were created in Inkscape, so `*inkscape.svg` files are original editable sources rather than the corresponding `.drawio` files.

- `_static/`  
  Directory for custom static files (CSS, images, JavaScript).

---

## Building the Documentation

From the `persistence/` directory:
### Build HTML

```bash
make html
```
### Build PDF

```bash
make latexpdf
```

## Build Output

- `_build/`  
  Automatically generated output directory.

  - `_build/html` → HTML documentation  
  - `_build/latex` → LaTeX sources and PDF output  

⚠️ The `_build/` directory is auto-generated and should not be edited manually.

To clean up the `_build`, run:

```bash
make clean
```
