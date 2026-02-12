Sequence Diagrams
=================

**Write Operation:** This diagram illustrates how a write request flows through FORM, from the phlex framework layer down to the persistence and storage layers. Phlex calls FORM's write() method once per event; FORM processes one write operation at a time without internal loops. The diagram shows the ROOT implementation layer (ROOT_TFileImp, ROOT_TTreeContainerImp) that translates FORM's storage interface calls into ROOT-specific API calls.

.. image:: /_static/images/write-operation.svg
    :alt: Diagram decription
    :align: center
    :width: 100%

**Read Operation:** This diagram shows the full read path inside FORM, beginning with a product lookup request and continuing through index resolution, token construction, and backend-specific data retrieval.
Phlex calls FORM's read() method once per request; FORM processes one read operation at a time without internal loops. The diagram shows the ROOT implementation layer that translates FORM's storage interface calls into ROOT-specific API calls.

.. image:: /_static/images/read-operation.svg
    :alt: Diagram decription
    :align: center
    :width: 100%

**Storage Sequence:** This sequence focuses on the internal mechanics of the Storage layer, illustrating in detail how a ROOT TTree backend processes a readContainer call. It exposes the low-level interactions
between Storage, the ROOT_TTreeContainerImp, TFile, TTree, and TBranch components that allow FORM to retrieve a single data product from a ROOT columnar file.

The storage package has a deep hierarchy of dependencies between objects at runtime. The default implementation of IStorage::readContainer() using a ROOT_TTreeContainerImp illustrates how the components of this package work together.

.. image:: /_static/images/storage-read-sequence-uml.svg
    :alt: Diagram decription
    :align: center
    :width: 100%

Most operations in the storage package are much simpler than IStorage::readContainer(). IStorage::fillContainer() is a good example of the complexity of other functions in the storage package.
