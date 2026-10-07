# Real-World Data Analysis & BI Automation Scenarios

1. **Daily CSV arrival** — detect the newest sales file, validate it, process it, archive it, and create a daily KPI report.
2. **SQLite extraction** — run a scheduled SQL query against the POS SQLite database and export the result to the staging folder.
3. **Excel report generation** — refresh KPI calculations and write an Excel management report.
4. **Plotly report generation** — generate daily/monthly charts automatically and save HTML.
5. **Data freshness check** — check whether today's source data arrived; create an exception file if not.
6. **Row-count reconciliation** — compare source and target row counts and stop the pipeline if counts differ unexpectedly.
7. **Reference-data validation** — check that product category, payment method, state, and other codes exist in reference data.
8. **Master-data lookup** — validate that customer/product/store identifiers can be resolved before analysis.
9. **Incremental processing** — process only files not previously processed and keep an execution log.
10. **Scheduled weekly report** — calculate weekly sales, orders, average order value, top products and top stores and write a report.
11. **Exception report** — create a separate CSV of invalid records rather than silently dropping them.
12. **Archive and quarantine** — move successful files to `archive/` and invalid files to `quarantine/`.
13. **Failure/re-run** — record step, start time, end time, row counts and status so a failed pipeline can be restarted.
14. **Dashboard dataset refresh** — rebuild the BI-ready data mart on a schedule.

These are data/BI automations. They do not require machine learning or generative AI.
