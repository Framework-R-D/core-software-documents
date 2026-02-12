# Configuration file for the Sphinx documentation builder.
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# =================================================================================================
# Project Information
# =================================================================================================

project = 'FORM'
author = 'TODO Author'
copyright = 'TODO'

# Version
version = "0"
release = "0.1"

# =================================================================================================
# General Configuration
# =================================================================================================

extensions = [
    # Allow referencing sections across document
    'sphinx.ext.autosectionlabel',
    'sphinx_needs',
    'sphinxcontrib.plantuml',
    #'sphinxcontrib.cairosvgconverter',
    'sphinxcontrib.rsvgconverter',
]

#sphinx_latex_svg_conversion = True
svg2pdfconverter_converter = 'inkscape'
svg2pdfconverter_inkscape_args = [
    '--export-text-to-path=false',
    '--export-dpi=300',
]

plantuml = 'plantuml'

#plantuml_output_format = 'png'

# Make section labels unique across documents
autosectionlabel_prefix_document = True

templates_path = ['_templates']

exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

# =================================================================================================
# Options for HTML Output
# =================================================================================================

html_theme = "alabaster"
html_static_path = ['_static']

# =================================================================================================
# Options for LaTex (PDF) Output
# =================================================================================================

latex_documents = [
    (
        "index",                             # root document
        "form-design.tex",                   # output file
        "FORM Prototype Design Overview",    # title
        author,
        #"manual",                            # IMPORTANT: prevents book/chapter structure
        "howto",                             # article structure with section as high-level
    ),
]

latex_elements = {
    'papersize': 'letterpaper',
    'pointsize': '11pt',
}
