Architechture
=============

Data Flow
---------

Write Operations
  Phlex creates product_base objects containing product metadata and data pointers. The form_interface consults configuration to determine target files and technologies, then delegates to the persistence layer which generates addressing information and coordinates the write workflow. storage translates addresses into technology-specific write function calls. root_storage is an example implementation of writing to a columnar file format.

Read Operations
  Phlex provides product identification through product_base (with product ID). The form_interface routes the request to the persistence layer, which performs index lookups to resolve product IDs to physical row locations, generates appropriate addressing tokens, and retrieves the data. storage dispatches reads from a row to a technology-specific read implementation. root_storage is an example of reading from a columnar file format.

Configuration Flow
  Phlex-side configuration (parse_config) is translated into FORM-internal representations at interface construction time, enabling efficient runtime lookups and maintaining separation between phlex framework and persistence concerns. Persistence forwards configuration information to the storage layer which constructs technology-specific read, write, and file operation implementations on-demand. Storage sorts configuration information by major and minor technology so that each I/O component only receives relevant configuration parameters.


Sequence Diagrams
-----------------

Write Operation
  This diagram illustrates how a write request flows through FORM, from the phlex framework layer down to the persistence and storage layers. Phlex calls FORM's write() method once per event; FORM processes one write operation at a time without internal loops. The diagram shows the ROOT implementation layer (ROOT_TFileImp, ROOT_TTreeContainerImp) that translates FORM's storage interface calls into ROOT-specific API calls.

.. image:: /_static/images/write-operation.svg
    :alt: Diagram decription
    :align: center
    :width: 100%

Read Operation
  This diagram shows the full read path inside FORM, beginning with a product lookup request and continuing through index resolution, token construction, and backend-specific data retrieval. Phlex calls FORM's read() method once per request; FORM processes one read operation at a time without internal loops. The diagram shows the ROOT implementation layer that translates FORM's storage interface calls into ROOT-specific API calls.

.. image:: /_static/images/read-operation.svg
    :alt: Diagram decription
    :align: center
    :width: 100%

Storage Sequence
  This sequence focuses on the internal mechanics of the Storage layer, illustrating in detail how a ROOT TTree backend processes a readContainer call. It exposes the low-level interactions between Storage, the ROOT_TTreeContainerImp, TFile, TTree, and TBranch components that allow FORM to retrieve a single data product from a ROOT columnar file.
  
  The storage package has a deep hierarchy of dependencies between objects at runtime. The default implementation of IStorage::readContainer() using a ROOT_TTreeContainerImp illustrates how the components of this package work together.

.. image:: /_static/images/storage-read-sequence-uml.svg
    :alt: Diagram decription
    :align: center
    :width: 100%

Most operations in the storage package are much simpler than IStorage::readContainer(). IStorage::fillContainer() is a good example of the complexity of other functions in the storage package.
