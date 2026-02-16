Detailed Design
===============

Interface Hierarchy
-------------------

FORM employs a minimal inheritance hierarchy focused on abstraction of the persistence layer:

.. image:: /_static/images/persistence.svg
    :alt: Diagram description
    :align: center
    :width: 36%

**Design Rationale**: The single inheritance relationship isolates the persistence contract from its implementation, enabling alternative persistence strategies while maintaining a stable interface for the FORM layer.

The Storage layer has a more complex inheritance hierarchy with three layers of interfaces:

.. image:: /_static/images/storage-interface.svg
    :alt: Diagram description
    :align: center
    :width: 36%

**Design Rationale:** The Storage interface provides a single entry point for Placement to dispatch read- and write-related operations. FORM comes with a default Storage implementation that looks up files and
containers based on information in a placement and creates a file and/or container on demand when one is not found. In the default Storage implementation, all state is handled by file and container interfaces
after they are created.

.. image:: /_static/images/istorage-file-interface.svg
    :alt: Diagram description
    :align: center
    :width: 36%

**Design Rationale:** IStorage_File is a handle to a filesystem resource whose lifetime is managed by an IStorage implementation.

.. image:: /_static/images/storage-container-interface.svg
    :alt: Diagram description
    :align: center
    :width: 65%

**Design Rationale**: An IStorage_Container is a location where one data product can be written to an associated file. An IStorage_Container is associated with a file by an IStorage implementation. A
Storage_Associative_Container is an IStorage_Container that communicates with a parent IStorage_Container. The parent is expected to be a Storage_Association.


Configuration Classes (No Inheritance)
--------------------------------------

Configuration classes exist in two parallel hierarchies maintaining independence from the phlex framework:

**mock_phlex Configuration Domain:**

.. image:: /_static/images/config.svg
    :alt: Diagram decription
    :align: center
    :width: 90%

**FORM Configuration Domain:**

.. image:: /_static/images/form-config.svg
    :alt: Diagram decription
    :align: center
    :width: 90%

**Design Rationale**: Two parallel PersistenceItem types (structurally identical but in different namespaces) maintain a clear boundary between FORM and phlex. mock_phlex configuration can evolve independently of FORM internals. Translation occurs once at form_interface construction.


Storage Class Relationships
---------------------------

.. image:: /_static/images/storage-uml-diagram-top-row.svg
    :alt: Diagram decription
    :align: center
    :width: 90%

**Design Rationale**: Storage separates IStorage_File implementations from IStorage_Container: major technology and minor technology respectively. An IStorage_Container encapsulates how one data product type is read and written to and from a file. Storage_Association was introduced to better model the lifetime of TTree and other associative container technologies that share a handle to a file when creating new containers during the event loop. A Storage_Associative_Container implements the other half of this pattern. It is an IStorage_Container that uses a parent Storage_Association to connect to a file. ROOT_TTreeContainerImp, ROOT_TBranch_ContainerImp, and ROOT_TFileImp form a concrete example of how to use CERN’s ROOT library to implement FORM’s Storage interfaces.


Composition
-----------

The composition of FORM centers on a clear top-down flow from the phlex framework interface (form_interface) to technology-specific storage implementations. Each layer composes instances of the layer below it, translating high-level requests into progressively more concrete operations.

1. | **Interface to Persistence (form → persistence)**
    \ The form_interface class serves as the phlex’s entry point. It receives data products from Phlex (or mock_phlex) and interprets configuration objects to determine where and how each product should be persisted.
    | Internally, form_interface **owns an instance of Persistence** through the abstract interface IPersistence. This composition isolates phlex framework logic from persistence orchestration, allowing alternative persistence strategies without affecting the interface layer.

2. | **Persistence to Storage (persistence → storage)**
    \ The Persistence class orchestrates all write and read operations. It **uses an instance of IStorage** to delegate low-level I/O handling while remaining technology-agnostic.
    | Persistence is responsible for constructing addressing descriptors (Placement, Token) and managing index containers that connect logical product names and identifiers to their physical storage locations. Once the addressing is resolved, Persistence calls into Storage to perform actual I/O operations.

3. | **Storage to Technology Implementations (storage → root_storage and others)**
    \ The Storage class acts as a dispatcher and cache manager. It **composes collections of IStorage_File and IStorage_Container instances**, creating them on demand based on configuration provided by Persistence.
    | Storage separates file management (IStorage_File) from data container management (IStorage_Container).

   -  A Storage_Association manages the relationship between files and containers, ensuring that containers sharing a file handle remain synchronized.

   -  A Storage_Associative_Container references its parent association to access shared file handles during write and read operations.

4. **ROOT Storage Backend (root_storage)**
    \ The ROOT_Storage package provides a concrete implementation of the storage interfaces for ROOT I/O.

   -  ROOT_TFileImp implements IStorage_File, encapsulating ROOT’s TFile.

   -  | ROOT_TTree_ContainerImp and ROOT_TBranch_ContainerImp implement IStorage_Container, mapping FORM’s logical containers and columns to ROOT’s TTree and TBranch structures.
      | These components are instantiated and managed by Storage, but their lifetimes are tied to the file associations that own them.

5. **Core Addressing (core)**
    \ The core package provides lightweight, immutable classes (Placement, Token) used throughout Persistence and Storage. These classes are **value-type members**, not polymorphic objects, ensuring safe and predictable ownership semantics while clearly separating write-time and read-time addressing.

