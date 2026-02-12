Key Design Decisions
====================

**Addressing Abstraction**: Placement and Token objects encapsulate physical addressing details, decoupling logical product names from storage locations and allowing flexible organization strategies.

**Multi-product Operation Support**: The interface supports writing multiple related products in a single transaction, reducing overhead for workflows where products are naturally grouped (e.g., by event or processing segment).

**Multi-file Operation Support:** The interface supports seamlessly writing each data product to multiple different files. The same product can be written with either the same technology or different technologies. The user only has to request multiple files in the configuration. A single write command from the interface will then write each data product to as many files as are configured.

**Technology-agnostic Interface**: Phlex can leverage different I/O technologies through FORM with a single interface. FORM manages the lifetimes of I/O and file handles and dispatches read and write operations in a uniform way. Technology-specific I/O implementations only have to implement FORM’s storage interface.