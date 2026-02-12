FORM Storage Class Relationships
================================

.. image:: /_static/images/storage-uml-diagram-top-row.svg
    :alt: Diagram decription
    :align: center
    :width: 90%

**Design Rationale**: Storage separates IStorage_File implementations from IStorage_Container: major technology and minor technology respectively. An IStorage_Container encapsulates how one data product
type is read and written to and from a file. Storage_Association was introduced to better model the lifetime of TTree and other associative container technologies that share a handle to a file when creating new containers during the event loop. A Storage_Associative_Container implements the other half of this pattern. It is an IStorage_Container that uses a parent Storage_Association to connect to a file.
ROOT_TTreeContainerImp, ROOT_TBranch_ContainerImp, and ROOT_TFileImp form a concrete example of how to use CERN’s ROOT library to implement FORM’s Storage interfaces.
