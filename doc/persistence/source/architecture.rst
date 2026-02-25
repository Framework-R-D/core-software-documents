Architecture
=============

Data Flow
---------

Write Operations
  Phlex creates :green:`product_base` objects containing product metadata and data pointers. The :green:`form_interface` consults configuration to determine target files and technologies, then delegates to the persistence layer which generates addressing information and coordinates the write workflow. :green:`storage` translates addresses into technology-specific write function calls. :green:`root_storage` is an example implementation of writing to a columnar file format.

Read Operations
  Phlex provides product identification through :green:`product_base` (with product ID). The :green:`form_interface` routes the request to the persistence layer, which performs index lookups to resolve product IDs to physical row locations, generates appropriate addressing tokens, and retrieves the data. :green:`storage` dispatches reads from a row to a technology-specific read implementation. :green:`root_storage` is an example of reading from a columnar file format.

Configuration Flow
  Phlex-side configuration (:green:`parse_config`) is translated into FORM-internal representations at interface construction time, enabling efficient runtime lookups and maintaining separation between phlex framework and persistence concerns. Persistence forwards configuration information to the storage layer which constructs technology-specific read, write, and file operation implementations on-demand. Storage sorts configuration information by major and minor technology so that each I/O component only receives relevant configuration parameters.


Sequence Diagrams
-----------------

.. figure:: /_static/images/write-operation.*
    :alt: Diagram decription
    :align: center
    :width: 100%
    :name: fig-write-operation
    
    Diagram of the FORM write operation.

Write Operation
  The disgram in Fig. :numref:`fig-write-operation` illustrates how a write request flows through FORM, from the phlex framework layer down to the persistence and storage layers. Phlex calls FORM's write() method once per event; FORM processes one write operation at a time without internal loops. The diagram shows the ROOT implementation layer (ROOT_TFileImp, ROOT_TTreeContainerImp) that translates FORM's storage interface calls into ROOT-specific API calls.

.. figure:: /_static/images/read-operation.*
    :alt: Diagram decription
    :align: center
    :width: 100%
    :name: fig-read-operation
    
    Diagram of the FORM read operation.

Read Operation
  The diagram in Fig. :numref:`fig-read-operation` shows the full read path inside FORM, beginning with a product lookup request and continuing through index resolution, token construction, and backend-specific data retrieval. Phlex calls FORM's read() method once per request; FORM processes one read operation at a time without internal loops. The diagram shows the ROOT implementation layer that translates FORM's storage interface calls into ROOT-specific API calls.

Storage Sequence
  This sequence focuses on the internal mechanics of the Storage layer, illustrating in detail how a ROOT TTree backend processes a readContainer call (see Fig. :numref:`fig-storage-sequence`). It exposes the low-level interactions between Storage, the ROOT_TTreeContainerImp, TFile, TTree, and TBranch components that allow FORM to retrieve a single data product from a ROOT columnar file.
  
  The storage package has a deep hierarchy of dependencies between objects at runtime. The default implementation of IStorage::readContainer() using a ROOT_TTreeContainerImp illustrates how the components of this package work together.

.. figure:: /_static/images/storage-read-sequence-uml.*
    :alt: Diagram decription
    :align: center
    :width: 100%
    :name: fig-storage-sequence
    
    Example of a ROOT TTree backend processes a readContainer call.

Most operations in the storage package are much simpler than IStorage::readContainer(). IStorage::fillContainer() is a good example of the complexity of other functions in the storage package.
