# Transformation Rule Template

For every transformation record:

1. **Source field**
2. **Observed issue**
3. **How to detect it**
4. **Business rule**
5. **Transformation code**
6. **Expected output**
7. **Validation query/check**
8. **Rejected/quarantined records**
9. **Reconciliation**
10. **Owner/version/date**

Example — Date:

- Source: `15-02-2026`
- Issue: DD-MM-YYYY differs from target ISO format
- Detect: source-format profile
- Fix: `pd.to_datetime(..., format="%d-%m-%Y")`
- Output: `2026-02-15`
- Verify: datetime dtype + ISO serialization
- Ambiguous example: `03/04/2026` must be parsed only when the source contract identifies whether it is DD/MM or MM/DD.
