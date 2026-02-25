Detailed Design
===============

Interface Hierarchy
-------------------

FORM employs a minimal inheritance hierarchy focused on abstraction of the persistence layer:

.. image:: /_static/images/persistence.*
    :alt: Diagram description
    :align: center
    :width: 33%
    :height: 9cm

**Design Rationale**: The single inheritance relationship isolates the persistence contract from its implementation, enabling alternative persistence strategies while maintaining a stable interface for the FORM layer.

The :green:`Storage` layer has a more complex inheritance hierarchy with three layers of interfaces:

.. image:: /_static/images/storage-interface.*
    :alt: Diagram description
    :align: center
    :width: 30%
    :height: 8cm

**Design Rationale:** The :green:`Storage` interface provides a single entry point for :green:`Placement` to dispatch read- and write-related operations. FORM comes with a default :green:`Storage` implementation that looks up files and containers based on information in a placement and creates a file and/or container on demand when one is not found. In the default :green:`Storage` implementation, all state is handled by file and container interfaces
after they are created.

.. image:: /_static/images/istorage-file-interface.*
    :alt: Diagram description
    :align: center
    :width: 4cm
    :height: 8cm

**Design Rationale:** :green:`IStorage_File` is a handle to a filesystem resource whose lifetime is managed by an :green:`IStorage` implementation.

.. image:: /_static/images/storage-container-interface.*
    :alt: Diagram description
    :align: center
    :width: 65%

**Design Rationale**: An :green:`IStorage_Container` is a location where one data product can be written to an associated file. An :green:`IStorage_Container` is associated with a file by an IStorage implementation. A
:green:`Storage_Associative_Container` is an :green:`IStorage_Container` that communicates with a parent :green:`IStorage_Container`. The parent is expected to be a :green:`Storage_Association`.


Configuration Classes (No Inheritance)
--------------------------------------

Configuration classes exist in two parallel hierarchies maintaining independence from the phlex framework:

**mock_phlex Configuration Domain:**

.. image:: /_static/images/config.*
    :alt: Diagram decription
    :align: center
    :width: 90%

**FORM Configuration Domain:**

.. image:: /_static/images/form-config.*
    :alt: Diagram decription
    :align: center
    :width: 90%

**Design Rationale**: Two parallel PersistenceItem types (structurally identical but in different namespaces) maintain a clear boundary between FORM and phlex. mock_phlex configuration can evolve independently of FORM internals. Translation occurs once at :green:`form_interface` construction.


Storage Class Relationships
---------------------------

.. image:: /_static/images/storage-uml-diagram-top-row.*
    :alt: Diagram decription
    :align: center
    :width: 90%

**Design Rationale**: Storage separates :green:`IStorage_File` implementations from :green:`IStorage_Container`: major technology and minor technology respectively. An :green:`IStorage_Container` encapsulates how one data product type is read and written to and from a file. :green:`Storage_Association` was introduced to better model the lifetime of TTree and other associative container technologies that share a handle to a file when creating new containers during the event loop. A :green:`Storage_Associative_Container` implements the other half of this pattern. It is an :green:`IStorage_Container` that uses a parent :green:`Storage_Association` to connect to a file. :green:`ROOT_TTreeContainerImp`, :green:`ROOT_TBranch_ContainerImp`, and :green:`ROOT_TFileImp` form a concrete example of how to use CERN’s ROOT library to implement FORM’s :green:`Storage` interfaces.


Composition
-----------

The composition of FORM centers on a clear top-down flow from the phlex framework interface (:green:`form_interface`) to technology-specific storage implementations. Each layer composes instances of the layer below it, translating high-level requests into progressively more concrete operations.

1. | **Interface to Persistence (form → persistence)**
    \ The :green:`form_interface` class serves as the phlex’s entry point. It receives data products from Phlex (or mock_phlex) and interprets configuration objects to determine where and how each product should be persisted.
    | Internally, :green:`form_interface` **owns an instance of :green:`Persistence`** through the abstract interface :green:`IPersistence`. This composition isolates phlex framework logic from persistence orchestration, allowing alternative persistence strategies without affecting the interface layer.

2. | **Persistence to Storage (persistence → storage)**
    \ The :green:`Persistence` class orchestrates all write and read operations. It **uses an instance of :green:`IStorage`** to delegate low-level I/O handling while remaining technology-agnostic.
    | :green:`Persistence` is responsible for constructing addressing descriptors (:green:`Placement`, :green:`Token`) and managing index containers that connect logical product names and identifiers to their physical storage locations. Once the addressing is resolved, :green:`Persistence` calls into :green:`Storage` to perform actual I/O operations.

3. | **Storage to Technology Implementations (storage → root_storage and others)**
    \ The :green:`Storage` class acts as a dispatcher and cache manager. It **composes collections of :green:`IStorage_File` and :green:`IStorage_Container` instances**, creating them on demand based on configuration provided by Persistence.
    | :green:`Storage` separates file management (:green:`IStorage_File`) from data container management (:green:`IStorage_Container`).

   -  A :green:`Storage_Association` manages the relationship between files and containers, ensuring that containers sharing a file handle remain synchronized.

   -  A :green:`Storage_Associative_Container` references its parent association to access shared file handles during write and read operations.

4. **ROOT Storage Backend (root_storage)**
    \ The :green:`ROOT_Storage` package provides a concrete implementation of the storage interfaces for ROOT I/O.

   -  :green:`ROOT_TFileImp` implements :green:`IStorage_File`, encapsulating ROOT’s TFile.

   -  | :green:`ROOT_TTree_ContainerImp` and :green:`ROOT_TBranch_ContainerImp` implement :green:`IStorage_Container`, mapping FORM’s logical containers and columns to ROOT’s TTree and TBranch structures.
      | These components are instantiated and managed by Storage, but their lifetimes are tied to the file associations that own them.

5. **Core Addressing (core)**
    \ The core package provides lightweight, immutable classes (:green:`Placement`, :green:`Token`) used throughout :green:`Persistence` and :green:`Storage`. These classes are **value-type members**, not polymorphic objects, ensuring safe and predictable ownership semantics while clearly separating write-time and read-time addressing.

