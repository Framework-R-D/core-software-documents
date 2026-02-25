System Overview
===============


Architecture Overview
---------------------

FORM employs a layered design with distinct responsibilities:

.. image:: /_static/images/form-architecture.*
    :alt: Diagram decription
    :align: center
    :width: 50%

**mock_phlex Package** (Phlex Framework Domain):

-  Defines data product structure (:green:`product_base`) containing metadata and payload pointers

-  Provides type registry (:green:`product_type_names`) for runtime type resolution

-  Specifies persistence rules through configuration objects (:green:`parse_config`, :green:`PersistenceItem`)

-  Will be replaced by Phlex

**form Package** (Interface and Translation):

-  Presents primary API (:green:`form_interface`) to phlex framework code for read/write operations

-  Translates phlex configuration into FORM-internal representations 

-  Resolves product types and performs configuration lookups

-  Supports both single-product and batch-product operations

**persistence Package** (Orchestration):

-  Coordinates multi-product, multi-file persistence workflows

-  Transforms logical product identifiers into physical addressing information

-  Manages index containers for efficient product retrieval

-  Delegates storage operations while maintaining technology independence

**core Package** (Addressing Primitives):

-  Provides immutable addressing descriptors (:green:`Placement`, :green:`Token`)

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


FORM Philosophy
---------------

FORM is designed around three core principles:

Clean Abstraction Boundaries
  FORM maintains distinct responsibilities across layers—interface translation, persistence navigation, addressing, and I/O operations. Each layer operates through well-defined contracts, allowing independent evolution and testing of components.

Technology Neutrality
  FORM's interface and orchestration logic remain independent of specific storage technologies. Configuration specifies technology choices, and FORM routes operations accordingly without exposing technology-specific details to phlex code.

Configuration-Driven Approach
  Users specify which data products are persisted, where they are stored, and which technologies are used through configuration objects rather than hardcoded logic. This declarative model separates I/O specification from algorithm implementation, enabling persistence strategies to evolve without modifying physics code.


Key Design Decisions
--------------------

Addressing Abstraction
  Placement and Token objects encapsulate physical addressing details, decoupling logical product names from storage locations and allowing flexible organization strategies.

Multi-product Operation Support
  The interface supports writing multiple related products in a single transaction, reducing overhead for workflows where products are naturally grouped (e.g., by event or processing segment).

Multi-file Operation Support
  The interface supports seamlessly writing each data product to multiple different files. The same product can be written with either the same technology or different technologies. The user only has to request multiple files in the configuration. A single write command from the interface will then write each data product to as many files as are configured.

Technology-agnostic Interface
  Phlex can leverage different I/O technologies through FORM with a single interface. FORM manages the lifetimes of I/O and file handles and dispatches read and write operations in a uniform way. Technology-specific I/O implementations only have to implement FORM’s storage interface.


Minimal Working Example
-----------------------

To illustrate the overall workflow and core abstractions of the system,
a minimal working example is provided. This example demonstrates the
end-to-end interaction between configuration, composition, and execution.

The complete Quick Start example is included in :ref:`Appendix B Quick Start <appendix-b-quick-start>`.
