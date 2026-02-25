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
release = "0.2"

# =================================================================================================
# General Configuration
# =================================================================================================

extensions = [
    # Allow referencing sections across document
    'sphinxcontrib.bibtex',
    'sphinx.ext.autosectionlabel',
    'sphinx_needs',
    'sphinxcontrib.plantuml',
    #'sphinxcontrib.cairosvgconverter',
    'sphinxcontrib.rsvgconverter',
]

bibtex_bibfiles = ['refs.bib']
bibtex_default_style = 'plain'

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
# Color setting
# =================================================================================================

# Global definition, use :green:`text` for example
rst_prolog = """
.. role:: green
.. role:: red
.. role:: blue
.. role:: yellow
"""

# =================================================================================================
# Figure setting
# =================================================================================================

numfig = True
numfig_format = {'figure': 'Fig. %s'}

# =================================================================================================
# Options for HTML Output
# =================================================================================================

html_theme = "alabaster"
html_static_path = ['_static']
html_css_files = ['css/custom.css']

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
    'figure_align': 'H',

    'preamble': r'''
    \usepackage{etoolbox}
    \usepackage{xcolor}
    
    \definecolor{mygreen}{rgb}{0.0, 0.4, 0.0}
    \definecolor{myred}{rgb}{0.8, 0.0, 0.0}
    \definecolor{myblue}{rgb}{0.0, 0.0, 0.8}
    \definecolor{myyellow}{rgb}{0.8, 0.6, 0.0}

    \renewcommand{\DUrole}[2]{%
        \ifstrequal{#1}{green}{\textcolor{mygreen}{#2}}{%
        \ifstrequal{#1}{red}{\textcolor{myred}{#2}}{%
        \ifstrequal{#1}{blue}{\textcolor{myblue}{#2}}{%
        \ifstrequal{#1}{yellow}{\textcolor{myyellow}{#2}}{#2}%
        }}}%
    }
    ''',
}
