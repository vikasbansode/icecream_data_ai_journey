# Teacher Guide V6

Use one phase at a time. Run the notebook, inspect the actual files, then give students the corresponding exercise folder. Students should write their own code.

Important architecture: source files are sources; raw is a preserved ingestion layer; cleaned data is validated; staging is prepared for transformation; dimensions/facts are created in modeling/warehouse; analysis joins warehouse facts to dimensions with DuckDB SQL; BI/reporting uses the analysis outputs; automation schedules the repetitive process.
