FORM Interface Design
=====================

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