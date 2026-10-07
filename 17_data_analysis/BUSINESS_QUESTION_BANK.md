# Ice Cream Data Analysis — Business Question Bank

The goal is to use DuckDB SQL against the dimensional warehouse to answer business questions, not merely calculate totals.

## Time questions
1. When was the highest sales day?
2. When was the lowest sales day?
3. When were orders highest?
4. When were orders lowest?
5. When did sales decrease significantly?
6. When did daily sales first fall below a threshold?
7. When did daily orders first fall from 2 to 1?
8. When was the last day with exactly 2 orders?
9. When did the daily sales pattern change?
10. What was the highest-sales week?
11. What was the highest-sales month?

## Product questions
12. Which product is best-selling on a particular date?
13. Which product is best-selling in a particular week?
14. Which product is best-selling in each week?
15. Which product has the highest overall sales?
16. Which product has the highest quantity sold?
17. When was each product's sales highest?
18. When did each product first have an order?
19. When did each product last have an order?
20. When did a selected product's orders become zero?
21. On which days did a selected product have zero sales?
22. When was the last zero-order day for a selected product?
23. Which product was the only product sold on a day?
24. When was the last promotion day for a product?
25. When did promotions stop for a product?

## Store/customer questions
26. Which store had the highest sales?
27. When was each store's highest-sales day?
28. Which city generated the highest sales?
29. Which customer spent the most?
30. Which customer segment generated the most sales?

## Diagnostic questions
31. Which product caused a monthly sales decline?
32. Which store contributed most to a sales decrease?
33. Which products had the largest week-over-week decline?
34. Did order count fall, average order value fall, or both?
35. Did quantity fall while price remained stable?

For every question, the notebook should show: business question → required tables → joins → SQL → result → interpretation.
