# Source Data Inventory

These are **source representations**, not warehouse dimensions or facts. The source layer intentionally contains operational/source structures that may be messy, heterogeneous and owned by different systems.

| Source | Format | Example | Business purpose |
|---|---|---|---|
| POS sales system | SQLite | `sqlite/sales_source.db` | Sales transactions |
| Customer registry | CSV | `csv/customer_registry.csv` | Customer registry |
| Store locations | CSV | `csv/store_locations.csv` | Store/location data |
| Product catalog | Excel | `excel/product_catalog.xlsx` | Product catalog |
| Supplier catalog | XML | `xml/supplier_catalog.xml` | Supplier information |
| Competitor website | HTML | `website/competitor_products.html` | Competitor products/prices |
| Weather service | JSON API response | `api/weather_api_response.json` | Weather observations |
| Historical catalog | Parquet | `parquet/historical_product_catalog.parquet` | Historical product data |
| Product catalog | Arrow | `arrow/product_catalog.arrow` | Columnar source example |
| Freezer sensors | CSV sensor stream | `sensor/freezer_sensor_data.csv` | Equipment measurements |
| Geography | CSV reference | `reference/countries.csv`, `states.csv` | Controlled geography values |

**Important:** `dim_customer`, `dim_product`, `dim_store`, `fact_sales` do **not** belong in this source folder. Those are created later during dimensional modeling / DWH loading.
