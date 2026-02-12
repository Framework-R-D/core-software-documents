FORM Philosophy
===============

FORM is designed around three core principles:

**Clean Abstraction Boundaries**: FORM maintains distinct responsibilities across layers—interface translation, persistence navigation, addressing, and I/O operations. Each layer operates through well-defined contracts, allowing independent evolution and testing of components.

**Technology Neutrality**: FORM's interface and orchestration logic remain independent of specific storage technologies. Configuration specifies technology choices, and FORM routes operations accordingly without exposing technology-specific details to phlex code.

**Configuration-Driven Approach**: Users specify which data products are persisted, where they are stored, and which technologies are used through configuration objects rather than hardcoded logic. This declarative model separates I/O specification from algorithm implementation, enabling persistence strategies to evolve without modifying physics code.