# Sphinx Documentation Environment Setup

This directory contains an example setup for creating a **Conda virtual environment** for building the project's Sphinx documentation.

It installs Sphinx and all required Python packages needed to build:

- HTML documentation
- LaTeX/PDF documentation

---
## Directory Structure

**tools/**
├── environment.yml
├── README.md
└── setup_sphinxdocs-env.sh

- `environment.yml`  
    Defines the Conda environment and required packages.
- `setup_sphinxdocs-env.sh`  
    Script that creates and activates the documentation environment.

## Requirements

- Conda (Miniconda or Anaconda)
- macOS or Linux (script tested on macOS)
## Setup Instructions

From the **main repository root directory**, run:

    `source tools/setup_sphinxdocs-env.sh`

or **tools** directory, run:

    `source setup_sphinxdocs-env.sh``

The setup script performs the following steps automatically:
 
 **Check whether the Conda virtual environment already exists**

   - **If YES**  
     The script activates the existing environment.

   - **If NO**  
     The script will:
     - Create the Conda virtual environment using `environment.yml`
     - Install Sphinx and all required dependencies
     - Activate the newly created environment

This ensures that:

- The environment is created only once
- Dependencies remain consistent
- The documentation build process is reproducible