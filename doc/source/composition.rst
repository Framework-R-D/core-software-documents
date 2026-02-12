Composition
===========

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
