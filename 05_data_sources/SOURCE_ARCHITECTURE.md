# Source Architecture

This folder contains **source data only**. These are not warehouse dimensions or fact tables.

| Source | Example data | Format | Role |
|---|---|---|---|
| POS SQLite | sales transactions | SQLite | Transaction source |
| Customer registry | customer details | CSV | Operational/master-like source |
| Store locations | store details | CSV | Operational/master-like source |
| Product catalog | products/prices | Excel | Operational source |
| Supplier catalog | suppliers | XML | Operational source |
| Competitor website | competitor products | HTML | External source |
| Weather API | weather | JSON | External/API source |
| Historical catalog | product history | Parquet | File source |
| Product catalog | product records | Arrow | File source |
| Freezer sensors | temperature/vibration/etc. | CSV | Sensor source |
| Countries/states/etc. | allowed values | CSV | Reference data source |

**Do not place `dim_customer`, `dim_product`, `dim_store`, `dim_date`, or `fact_sales` here.**
Those are created after cleaning, staging, transformation, and dimensional modeling.
