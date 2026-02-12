Architecture Overview
=====================

FORM employs a layered design with distinct responsibilities:

.. image:: /_static/images/form-architecture.svg
    :alt: Diagram decription
    :align: center
    :width: 60%

**mock_phlex Package** (Phlex Framework Domain):

-  Defines data product structure (product_base) containing metadata and payload pointers

-  Provides type registry (product_type_names) for runtime type resolution

-  Specifies persistence rules through configuration objects (parse_config, PersistenceItem)

-  Will be replaced by Phlex

**form Package** (Interface and Translation):

-  Presents primary API (form_interface) to phlex framework code for read/write operations

-  Translates phlex configuration into FORM-internal representations 

-  Resolves product types and performs configuration lookups

-  Supports both single-product and batch-product operations

**persistence Package** (Orchestration):

-  Coordinates multi-product, multi-file persistence workflows

-  Transforms logical product identifiers into physical addressing information

-  Manages index containers for efficient product retrieval

-  Delegates storage operations while maintaining technology independence

**core Package** (Addressing Primitives):

-  Provides immutable addressing descriptors (Placement, Token)

-  Encapsulates file names, container paths, and technology identifiers

-  Separates write-time addressing (Placement) from read-time addressing (Token with row IDs)

**storage Package** (Dispatching I/O)

-  Maps I/O requests in uniform format to technology-dependent implementations

-  Creates I/O links to files on demand at runtime

-  Links major technology and minor technology implementations

-  Dispatches configuration to implementation layers

**root_storage Package** (Example I/O Implementation)

-  Implements storage interfaces using TTree and TFile from the ROOT toolkit

-  Encapsulates all ROOT dependencies

-  Writes/reads data products to/from a TTree in a TFile per-TBranch