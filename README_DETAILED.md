# Ice Cream Data & AI Journey — V5 Source-First Practical Project

This version is built around one rule: **source data is not warehouse data**.

Sources are heterogeneous: SQLite sales, CSV customer/store/weather, Excel product catalog, XML supplier catalog, website HTML, API JSON, Parquet, Arrow, sensor data and reference data.

Only after collection → ingestion → raw → cleaning → staging → transformation → modeling are warehouse fact/dimension tables created.

Every practical phase follows: **Context → Example → Source/Data Problem → Detect → Fix → Verify → Code → Output → Business Interpretation → Exercise**.

Implementations use **Python, Pandas, Polars, DuckDB and Plotly** where appropriate.

Data Analysis ends at **BI & Reporting**. Data Analysis Automation is separate and focuses on extraction, database connections, KPI calculation, reporting, validation, scheduling and operational automation.
