Technology Choices
==================

This section briefly explains why FORM has been implemented the way it exists today. FORM’s design requirements are largely driven by the user requirements that informed the design of phlex. Phlex was designed to adapt DUNE physics processing to the architecture of the global HEP computing grid. A typical HEP grid node has a multi-core CPU equipped with 2GB of RAM per core. Large-scale I/O either copies or streams data from a remote network-attached file store. DUNE’s previous processing strategy demonstrated that the raw data from a single far detector readout can fill several GB of RAM. So Phlex was designed to operate in a memory-constrained environment.

**Key Performance Metrics**

FORM’s primary goal is flexible, efficient I/O. But arguably as important is its focus on minimizing memory use. To support phlex’s memory goals, FORM should make no unnecessary copies of data products.
It should allow phlex to de-allocate memory to best manage DUNE’s RAM budget on a grid computing node. Minimizing user CPU time devoted to I/O is also important to FORM, but physics algorithms are expected to dwarf I/O time. FORM is currently designed for only serial I/O operations. ROOT’s implicit multithreading may still be used for compression and de-compression for specific minor technologies. The FORM developers are aware that concurrent I/O may eventually be desirable and are planning to use locks around critical sections to make FORM thread-safe.

**Language Features**

FORM’s language feature usage bridges phlex’s framework interface with target I/O libraries. ROOT’s RNTuple is the primary way FORM will do I/O with data products. So FORM uses c++ to maximize its use of ROOT’s API. This also matches phlex’s most featureful interface. FORM signals errors exclusively by throwing exceptions to best inter-operate with phlex. FORM has been developed so far using c++ 20 and is compatible with c++ 23 to match phlex’s language standard requirements. C++ is a particularly convenient language choice for supporting FORM’s detailed memory use requirements. FORM must be cognizant of memory semantics and especially avoid copies of data products from phlex. C++’s explicit memory management semantics lend themselves well to manual memory management. The cost of careful memory management and flexibility in FORM is c++’s fragile support for runtime type information. FORM uses type-erased payload pointers to refer to data product memory allocated by phlex. Type erasure in c++ requires careful forethought about allocating, de-allocating, and sharing memory by the FORM developers.

**Comparison to Other I/O Libraries**

FORM is designed to be the ideal I/O component for meeting phlex’s goals for DUNE computing. Comparing to a few other contemporary I/O libraries highlights features unique to FORM:

-  **Podio**: Podio is a concurrency-aware I/O library designed for studying future collider detector concepts. One of the key features of podio is that data products are always represented as simple c++ structs: the so-called plain old data memory layout. Podio emphasizes compatibility with vectorization technologies. The key difference between podio and FORM is FORM’s explicit memory management. Podio advertises automatic data product memory management. This is useful for general detector studies, but it will not help fit DUNE’s multi-GB readout records into memory in runtime-selected pieces. FORM enables phlex to decide exactly when a collection of data products leaves memory through eager writing.


-  **Directly using RNTuple**: All of FORM’s goals can be achieved using RNTuple directly without overhead from its data product organization and dispatch layers. FORM brings substantial additional value to phlex by allowing phlex to adopt new major and minor technologies as formats for data products written and read. Phlex’s stakeholder requirements already require support for HDF5 files from the DAQ alongside direct support for RNTuple-based data product storage. FORM provides a common API for interacting with these disparate technologies without having to rewrite large parts of phlex’s object store and messaging systems.


-  **LCIO**: LCIO is an I/O library aimed at a unified I/O protocol for simulation and reconstruction studies for the International Linear Collider. The key difference between FORM and LCIO is that LCIO stores data products in a fixed hierarchy. FORM is designed to represent phlex’s runtime-defined data product hierarchies including combining related families of data products of the same type into a single I/O query. These flexible data product hierarchies are critical to phlex’s strategy for making the most of the computing grid’s 2GB of RAM per node.

