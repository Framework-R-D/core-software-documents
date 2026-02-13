#!/usr/bin/env bash

# =================================================================================================
# Filename:  setup_sphinx_docs.sh
# About:     Setup a Conda virtual environment for Sphinx documentation (e.g., DUNE Phlex/FORM)
# Platform:  Tested on macOS
# Usage:     source setup_sphinx_docs.sh
# =================================================================================================

# =================================================================================================
# User's basic variables
# =================================================================================================

# Get directory of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Project root directory (one level up from tools/)
PROJECT_ROOT="$( cd "${SCRIPT_DIR}/.." && pwd )"

echo "Project root: ${PROJECT_ROOT}"
echo "Script: ${SCRIPT_DIR}"

PROJECT_NAME="SphinxDocs"
PROJECT_NAME_LOWER=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]')
ENV_NAME="${PROJECT_NAME_LOWER}-env"
PYTHON_VERSION="3.12.7"

echo "Project name:    $PROJECT_NAME"
echo "Env name:        $ENV_NAME"
echo "Python version:  $PYTHON_VERSION"


# =================================================================================================
# Conda virtual environment
# =================================================================================================

# Check if conda is installed
if ! command -v conda &>/dev/null; then
    echo "❌ conda command not found. Please install Miniconda or Anaconda first."
    return
fi

# Check if conda virtural environment exists
if conda info --envs | grep -qE "^${ENV_NAME}[[:space:]]"; then
  echo "✅ Environment '$ENV_NAME' already exists. Activating..."
else
  echo "🆕 Environment '$ENV_NAME' not found. Creating..."
  # usually the env folder can be found at: ~/miniconda3/envs/${ENV_NAME}
  
  # ---- Create with a python ----
  #conda create -y -n "$ENV_NAME" python="$PYTHON_VERSION"

  # ---- Create with environment.yml file ----
  conda env create -f "${SCRIPT_DIR}/environment.yml"
  
  # The following are needed to convert *.svg files into latex pdf
  # Note on MacOS, they are installed using Homebrew.
  brew install plantuml
  brew install cairo pkg-config
  
  # This ensures that conda can find cairo from OS system, not from Homebrew
  sudo mkdir -p /usr/local/lib
  sudo ln -s /opt/homebrew/opt/cairo/lib/libcairo.2.dylib /usr/local/lib/libcairo.2.dylib

  brew install librsvg
fi

conda activate "$ENV_NAME"
echo "✅ Environment '$ENV_NAME' is now active."

# set up python
unset PYTHONPATH
export PYTHONPATH="$(pwd)"

# Use pip to install a package
echo -e "To install a package, use \n  $ pip install -y numpy"

# Use pip to export installed packages
echo -e "To export installed packages, use \n $ pip freeze > requirements.txt"

# export current active environment
echo -e "To export the active environment, use \n  $ conda env export --no-builds > environment.yml"

# rebuid the same environment
echo -e "To rebuild the same environment, use \n  $ conda env create -f environment.yml"

# deactivate
echo -e "To deactivate an active environment, use \n  $ conda deactivate"

# delete an environment
echo -e "To remove an environment, use \n  $ conda remove -n env-name --all -y"

# =================================================================================================
# Project structure
# =================================================================================================
cd ${PROJECT_ROOT}

echo
echo "------------------------------------------------------------"
echo "Sphinx documentation environment setup complete."
echo "------------------------------------------------------------"
echo
echo "Current directory : ${PROJECT_ROOT}"
echo
echo "To build the Sphinx documentation:"
echo
echo "  1. Navigate to the documentation directory:"
echo "       cd doc"
echo
echo "  2. Build HTML documentation:"
echo "       make html"
echo
echo "  3. Build PDF documentation:"
echo "       make latexpdf"
echo
