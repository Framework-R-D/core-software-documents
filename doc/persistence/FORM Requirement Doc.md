## **1\. Introduction**

The Deep Underground Neutrino Experiment (DUNE) requires a data persistence infrastructure that can accommodate diverse processing needs across varying granularity levels, while remaining compatible with modern I/O systems. FORM (Fine-grained Object Reading/Writing Model) is designed to meet this need by providing a scalable, modular, and technology-agnostic I/O framework that enables high-performance data access and storage for fine-grained detector segments.

---

## **2\. Scope**

FORM is responsible for:

* Persistently storing and retrieving physics and ancillary data from DUNE's modular detectors.  
* Enabling fine-grained access to data objects (e.g., APA, CRP, hits, reco tracks).  
* Supporting interchangeable I/O backends such as ROOT, HDF5, and others.  
* Integrating seamlessly into the DUNE computing framework (e.g., Phlex).  
* Maintaining transparent and efficient data access without burdening user code.

## **3\. System Requirements Mapping**

| Req ID | Requirement Description | FORM Implementation Strategy |
| ----- | ----- | ----- |
| **STKH-8** | The framework shall run on widely-used scientific computing systems in order to fully utilize DUNE computing resources. | FORM abstracts I/O backends and supports integration with ROOT (TTree, RNTuple) and HDF5, ensuring compatibility with Fermilab HPC, ALCF, and other common platforms. |
| **STKH-22** | Support flexibly defined, context-aware processing units to address varying granularity. | Phlex defines the unit of processing granularity (APA, CRP, spill, etc.) at configuration time and FORM supports those in I/O and storage. FORM also supports dynamically the definition of what constitutes a "processing unit" through Placement metadata. |
| **STKH-23** | FPU must change within a single job; i.e., process whole spills or subsets. | FORM supports this via dynamic row-level writing and reading per dataProductSetID and flexible creator-based table mapping. Depending on FPU size, data products would be stored in different Tables. |
| **STKH-24** | Framework shall support reading from disk only the data products required by a given algorithm. | FORM reads column-wise (per label) from specific tables (per creator) and can filter rows (per dataProductSetID), reducing I/O overhead. Data is compressed column-wise, which may result in the need to read and decompress more than one data product at the time. |
| **STKH-27** | \[Clarification required\] | Pending definition. Possibly refers to dynamic grouping or asynchronous access. No action taken. |
| **STKH-39** | Parentage info MUST include code version and compiler info and provide interface to include same for modules. | FORM will integrate version metadata capture and propagate such information into a special metadata table or **metadata** column written per table. |
| **STKH-73** | Framework MUST provide an API for external developers to write custom I/O backends. | FORM addresses this requirement at the Interface layer shared with Phlex through a clean and minimal public API. Developers can register and configure FORM to target different storage technologies (e.g. ROOT, HDF5 etc.) without modifying internal components. This flexibility is driven by the use of Placement metadata and configuration-time selection of the output format. |

## **4\. Functional Requirements**

* **FR-1: Fine-grained Data Access**  
  FORM shall support per-column and per-row access based on label and dataProductSetID.  
* **FR-2: Creator-based Table Naming**  
  Each algorithm (creator) defines a table. This mapping must be preserved across all backends.  
* **FR-3: Metadata Column Support**  
  Each table must include a `__metadata__` column with one row per dataProductSetID, capturing types and labels of other columns.  
* **FR-4: Transparent Backend Dispatch**  
  Based on format (e.g., ROOT, HDF5, mockIO), FORM shall internally dispatch to the correct I/O engine without exposing this detail to the user.  
* **FR-5: Scalable Concurrency**  
  FORM must enable row-by-row and column-by-column writing, supporting concurrent algorithm execution.

---

## **5\. Non-Functional Requirements**

* **NFR-1: Portability**  
  FORM shall run on Linux-based systems at Fermilab and ALCF using standard compilers and CMake.  
* **NFR-2: Backend Flexibility**  
  FORM shall support backend plugins without changes to core logic (e.g., add HDF5Storage.cpp).  
* **NFR-3: Low Memory Footprint**  
  FORM must minimize memory usage by avoiding full-event loads; support segment-wise I/O.

## **6\. Future Roadmap**

* **Phase 1** (2024–2025):  
  Implement FORM prototype with mock and ROOTStorage backends, supporting APA-level writes.  
* **Phase 2** (Late 2025):  
  Add HDF5 backend, optimize metadata handling, and enable user-configurable SelectionCriteria.  
* **Phase 3** (2026+):  
  Integrate FORM into full DUNE workflows, optimize concurrency, and support cloud/hybrid storage models.

---

## **7\. Appendix: Terminology**

* **dataProductSetID**: Unique row identifier for a single algorithm invocation.  
* **creator**: Algorithm name, used as table name.  
* **label**: Product label, used as column name.  
* **Placement**: Internal representation of table/column mappings, format, and metadata.  
* **IStorage**: Interface defining `fillTable(...)` API for backend implementations.

