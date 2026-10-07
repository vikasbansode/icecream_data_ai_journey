# Master Data & Reference Data Discovery

## Learning Objectives
Students will identify master entities, reference domains, owners, keys, lifecycle fields, allowed values, duplicates, effective dates and relationships.

## Discovery questions
1. What is the business entity?
2. What is the unique business key?
3. Which system is the source of truth?
4. Who owns the data?
5. What attributes describe the entity?
6. Which values are controlled by reference data?
7. Are there duplicate records?
8. Are there invalid or obsolete reference values?
9. Are effective-from/effective-to dates present?
10. What happens when a master record changes?

## Customer Master discovery
- uniqueness of customer_id
- missing names
- invalid segments
- active/inactive status
- source system
- effective dates

## Product Master discovery
- product_id uniqueness
- product category validation against reference data
- unit price and cost
- product status
- UOM
- tax category

## Store Master discovery
- store_id uniqueness
- city/state validity
- store type
- status
- opening date

## Reference data discovery
For every reference domain inspect: code, description, active flag, allowed values, duplicates, deprecated values and mapping rules.

## Practical validation
```python
allowed = set(pd.read_csv('ref_customer_segment.csv')['customer_segment_name'])
invalid = customer[~customer['segment'].isin(allowed)]
print(invalid)
```

## Business impact
Bad master/reference data can create incorrect joins, inconsistent reports, broken KPIs and misleading AI results.
