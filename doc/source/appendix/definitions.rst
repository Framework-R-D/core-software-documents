Definitions
===========

Association
  An internal FORM handle to an on-file resource that can be shared by multiple Containers. An Association is a kind of Container although existing Associations immediately throw an exception if their interface is used. A TTree is an example of a resource shared through an Association in FORM.

Associative container
  A FORM Container that uses shared resources through an Association. A Tree_Container that writes one data product to one branch of a TTree on disk is an example of an Associative_Container.

Container
  Term adopted from the POOL project that means a destination for data products written/read by the Phlex framework through FORM. Imagine a single FORM file with 3 data products: Track, Hit, and MCParticle. Tracks and MCParticles are written by spill data product cell. Hits are written by APA family within a spill data product cell. To save space, FORM might save Tracks and MCParticles to the same RNTuple, per_spill, and Hits to a different RNTuple, per_apa. The per_spill RNTuple is referred to by two Containers: one for Tracks and another for MCParticles. The per_apa RNTuple is referred to by one Container for Hits.

Data product
  A single physics object or collection of physics objects. Data products are the information that C++ and Python algorithms exchange to communicate in Phlex. A reconstructed particle trajectory, or Track, is an example of a data product. A vector<Track> is another example of a single data product.   A data product’s representation on disk must satisfy some requirements to be compatible with FORM’s RNTuple containers:

  * does not rely on dynamic polymorphism to store objects of different types in the same container under a common base type. Likewise, even a single data product of derived type must not be stored by its base type in a file.

  * does not contain raw pointers to other objects. Containers like the C++ standard template library’s vector<> and map<> are allowed through specializations in RNTuple.

  * does not use a custom ROOT streamer when writing/reading to/from a file. Does not have any members that use custom ROOT streamers. The deprecated TLorentzVector class in ROOT is an example of an object that requires a custom ROOT streamer to do I/O.

Data product cell
  A Phlex term for one level in the runtime-defined hierarchy of data products. A Phlex job organizes data products into one or more cells that can form a hierarchy. Imagine a job that works with Tracks and MCParticles per beam spill and hits per APA per beam spill. “beam spill” and “APA” are both examples of data product cells. There are probably multiple beam spills and multiple APAs in this example Phlex job. But each APA is an element of a single beam spill. A single beam spill can contain multiple APAs. Phlex refers to each member of a family of data product cells by an integer index in its user-facing API.

FORM
  The Flexible Object Read/write Model. The I/O library developed specifically for the Phlex framework and the subject of this documentation.

Index
  FORM’s representation of a Phlex data_cell_index. FORM persists an index on disk when it writes data products to a file. FORM uses an index to route I/O calls from Phlex to the correct Container. An index is represented as a std::string in memory when used by FORM.

Major technology
  Term borrowed from the POOL project that means the file format in which data products are stored. TFile is an example of a major technology, regardless of whether data products are stored in a TTree, RNTuple, or something else. HDF5 also specifies its own major technology (file format).

Minor technology
  Term borrowed from the POOL project that means the format a data product is stored on within a file. TTree is an example of a minor technology that can be used with the TFile major technology, both from ROOT. By ROOT 6.36, TFile also supports another minor technology: RNTuple.

Phlex
  DUNE’s new reconstruction framework: parallel hierarchical layered execution of physics algorithms. Phlex was designed from first principles to bridge DUNE’s computing needs with the hardware capabilities of the collaboration: concurrent reconstruction of GB-scale readout records on multi-core CPUs with 2GB of RAM per core and streamed data access. FORM is a bespoke I/O library for Phlex.

Placement
  FORM’s internal description of where to write a data product.  A Placement specifies a technology, a file name, and a container name to which a data product will be written.

POOL/Athena
  POOL is an I/O library that was designed to be shared among the LHC experiments. Athena is the ATLAS experiment’s fork of POOL that has continued to serve the experiment’s needs up to the era of the HL-LHC. The adaptability of the POOL and Athena libraries’ architectures to RNTuple inspired much of the design of FORM.

Token
  FORM’s internal description of where to read a data product from.  A Token specifies a technology, a file name, a container name, and an entry number from which to read a data product.
