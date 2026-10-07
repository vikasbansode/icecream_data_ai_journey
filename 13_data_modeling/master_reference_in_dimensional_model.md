# Master & Reference Data in Dimensional Modeling

## Key teaching point
Master data is not the same thing as a dimension, although master data often becomes the source for dimensions. A dimension is an analytical representation of business context.

### Example
Product Master -> Product Dimension -> Fact Sales

Master data may contain operational attributes and lifecycle controls. The dimensional product dimension may additionally contain surrogate keys, historical versions and analytics-friendly attributes.

## Reference data
Reference data can become dimension attributes or lookup tables. Example: Product Category, Customer Segment, Store Type, Weather Condition.

## MDM concepts to introduce
- source of truth
- golden record
- duplicate resolution
- survivorship
- match and merge
- stewardship
- ownership
- effective dating
- hierarchy management
- reference value governance
- change approval

## SCD connection
When a master attribute changes, students should decide whether the analytical dimension needs Type 1 overwrite or Type 2 history.
