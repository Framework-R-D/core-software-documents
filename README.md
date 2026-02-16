# core-software-documents

This repository contains the design documentation of FORM and supporting tools for the project.

The documentation is written using Sphinx and organized to support a structured
software architecture report, including system overview, architectural design,
and implementation considerations.

---

## Repository Structure

```
.
├── README.md  # Project overview (this file)
├── doc/       # Sphinx documentation source and build configuration
└── tools/     # Example environment setup and helper scripts for sphinx 
```

### `doc/`
Contains the Sphinx documentation project.

- `source/` – reStructuredText sources
- `Makefile` – build commands for documentation
- See `doc/README.md` for detailed instructions.

### `tools/`
Contains environment configuration and setup scripts.

- `environment.yml` – Conda environment specification
- `setup_sphinxdocs-env.sh` – environment setup script
- See `tools/README.md` for details.
