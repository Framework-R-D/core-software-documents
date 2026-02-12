FORM Configuration Classes (No Inheritance)
===========================================

Configuration classes exist in two parallel hierarchies maintaining independence from the phlex framework:

**mock_phlex Configuration Domain:**
------------------------------------

.. image:: /_static/images/config.svg
    :alt: Diagram decription
    :align: center
    :width: 90%

**FORM Configuration Domain:**

.. image:: /_static/images/form-config.svg
    :alt: Diagram decription
    :align: center
    :width: 90%

**Design Rationale**: Two parallel PersistenceItem types (structurally identical but in different namespaces) maintain a clear boundary between FORM and phlex. mock_phlex configuration can evolve independently of FORM internals. Translation occurs once at form_interface construction.