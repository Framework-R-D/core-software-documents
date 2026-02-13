# Documentation Directory

This directory contains the Sphinx documentation for the project.

---

## Directory Structure

```
**doc/**
├── Makefile
├── README.md
└── **source**
```

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
└── _static/
```
### Key Files

- `conf.py`  
  The main Sphinx configuration file.  
  Defines project information, extensions, themes, and build options.

- `index.rst`  
  The main entry point of the documentation.  
  Contains the table of contents (`toctree`) and links to other pages.

- `*.rst` 
  Documentation source files written in reStructuredText.

- `docutils.conf`  
  Configuration file for Docutils (used internally by Sphinx).  
  It can define default build options, LaTeX settings, encoding, and other processing parameters.

- `_static/`  
  Optional directory for custom static files (CSS, images, JavaScript).

---

## Building the Documentation

From the `doc/` directory:
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