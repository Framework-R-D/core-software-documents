.. _appendix-b-quick-start:

Quick Start
===========

The Phlex module for writing data products provides an excellent example of how FORM is used:

**Configuration:**

.. code-block:: c++

    // Build FORM configuration
    form::experimental::config::output_item_config output_cfg;
    form::experimental::config::tech_setting_config tech_cfg;

    // FIXME: Temporary solution to accommodate Phlex limitation.
    // Eventually, Phlex will communicate to FORM which products will be written
    // before executing any algorithms

    // Temp. Sol for Phlex Prototype 0.1
    // Register products from config

    for (auto const& product : products_to_save) {
      output_cfg.addItem(product, m_output_file, m_technology);
    }

    // Initialize FORM interface
    m_form_interface = 
      std::make_unique<form::experimental::form_interface>(output_cfg, tech_cfg);

**Writing Data Products:**

.. code-block:: c++

    // This method is called by Phlex - signature must be: void(product_store const&)

    void save_data_products(phlex::experimental::product_store const& store)
    {
      // Check if store is empty - smart way, check store not products vector
      if (store.empty()) {
        return;
      }
      
      // STEP 1: Extract metadata from Phlex's product_store

      // Extract creator (algorithm name)
      std::string creator = store.source();
      
      // Extract segment ID (partition) - extract once for entire store
      std::string segment_id = store.id()->to_string();
      
      std::cout << "\\n=== FormOutputModule::save_data_products ===\\n";
      std::cout << "Creator: " << creator << "\\n";
      std::cout << "Segment ID: " << segment_id << "\\n";
      std::cout << "Number of products: " << store.size() << "\\n";

      // STEP 2: Convert each Phlex product to FORM format

      // Collect all products for writing
      std::vector<form::experimental::product_with_name> products;
      
      // Reserve space for efficiency - avoid reallocations
      products.reserve(store.size());

      // Iterate through all products in the store
      for (auto const& [product_name, product_ptr] : store) {
        // product_name: "tracks" (from the map key)
        // product_ptr: pointer to the actual product data
        std::cout << " Product: " << product_name << "\\n";

        // Create FORM product with metadata
        products.emplace_back(product_name, // label, from map key
          product_ptr->address(), // data, from phlex product_base
          &product_ptr->type() // type, from phlex product_base
          );
      }

      // STEP 3: Send everything to FORM for persistence

      // Write all products to FORM
      // Pass segment_id once for entire collection (not duplicated in each product)
      // No need to check if products is empty - already checked store.empty() above
      m_form_interface->write(creator, segment_id, products);
      std::cout << "Wrote " << products.size() << " products to FORM\\n";
    }
