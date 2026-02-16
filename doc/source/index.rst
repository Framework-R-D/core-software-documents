FORM Prototype Design Overview
==============================

.. toctree::
   :maxdepth: 2

   introduction
   system-overview
   architecture
   detailed-design
   implementation-considerations

.. Appendix
   \theHsection: unique internal ID prefix for "appendix" to avoid link conflicts
   \addtocontents{toc} ... : increase label in toc with default (1.5/2.3em to 5.5em) to avoid overlap since title is changed to Appendix A/B ...
   \renewcommand{\thesubsection}{\Alph{subsection}.\arabic{subsection}}

.. raw:: latex

   \clearpage
   \setcounter{section}{0}
   \renewcommand{\thesection}{Appendix \Alph{section}}

   \makeatletter
   \addtocontents{toc}{\protect\patchcmd{\protect\l@section}{1.5em}{5.5em}{}{}}
   \addtocontents{toc}{\protect\patchcmd{\protect\l@section}{2.3em}{5.5em}{}{}}
   \renewcommand{\theHsection}{appendix.\thesection}
   \makeatother

.. toctree::
   :maxdepth: 1

   appendix/definitions
   appendix/quick-start

.. References: use \phantomsection to create dumpy anchor to fix TOC jump offset

.. raw:: latex

   \clearpage
   \phantomsection

.. toctree::
   :maxdepth: 1

   references
