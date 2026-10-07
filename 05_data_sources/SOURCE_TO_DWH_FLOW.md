# Source-to-DWH Flow

```text
Operational / External Sources
  |-- SQLite POS
  |-- CSV Customer Registry
  |-- CSV Store Locations
  |-- Excel Product Catalog
  |-- XML Supplier Catalog
  |-- Website HTML
  |-- Weather API JSON
  |-- Parquet
  |-- Arrow
  |-- Sensor CSV
  |-- Reference CSV
          |
          v
     Data Collection
          |
          v
       Ingestion
          |
          v
      RAW Layer
          |
          v
     Data Cleaning
          |
          v
    STAGING Layer
          |
          v
 Data Transformation
          |
          v
 Data Modeling
          |
          +--> dim_customer
          +--> dim_product
          +--> dim_store
          +--> dim_date
          +--> fact_sales
          |
          v
    Data Warehouse
          |
          v
      Data Marts
          |
          v
 Analysis / Visualization / BI
```
