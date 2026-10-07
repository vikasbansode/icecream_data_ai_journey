# Master Data and Reference Data

## Why this is included
Master Data and Reference Data are added to the Ice Cream Data & AI Journey so students can see that not every dataset is transactional. A mature data platform uses stable business entities and controlled code lists to make transactions consistent.

## Master Data
Master data represents important business entities shared across processes. In Frosty World examples: Customer, Product, Store, Supplier, Employee and Promotion.

### Examples
- Customer Master: who the customer is
- Product Master: what the business sells
- Store Master: where the business operates
- Supplier Master: who supplies products/materials
- Employee Master: who works in the business
- Promotion Master: which promotions exist and when they are valid

## Reference Data
Reference data provides controlled values used to classify, validate and standardize other data. Examples: customer segment, product category, payment method, sales channel, order status, weather condition, UOM, tax category, store type and geography.

## Difference
| Master Data | Reference Data |
|---|---|
| Business entities | Controlled value sets |
| Customer, Product, Store | Student, Family, Premium |
| Often has lifecycle | Usually changes less frequently |
| Identifies real-world objects | Standardizes classifications/codes |
| May require MDM | Often managed as reference-data governance |

## How they connect to the fact
`Fact_Sales` uses Customer, Product and Store master keys and uses reference values for classifications such as channel, payment method, status and discount type.

## Teaching flow
Source Systems -> Master Data / Reference Data -> Data Quality & Standardization -> Staging -> Dimensional Model -> Fact Sales -> Data Mart -> Analytics -> BI -> AI.

## Governance topics
Teach ownership, stewardship, definitions, allowed values, effective dates, status, source system, golden record, duplicate detection, survivorship, validation and change history.
