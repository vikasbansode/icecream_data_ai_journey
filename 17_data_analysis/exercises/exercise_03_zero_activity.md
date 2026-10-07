# Exercise 03 — Find Zero-Sales Days

## Problem
A product manager asks: “When did this product have zero orders?”

A missing row is not automatically a zero. Build a complete date × product grid and left join the fact data.

## Tasks
1. Build the date × product grid.
2. Aggregate product-day sales.
3. Left join the aggregate to the grid.
4. Replace missing quantities with zero.
5. Find all zero-order days for Vanilla.
6. Return the last zero-order day for Vanilla.

## Student requirement
Use DuckDB SQL and explain why an INNER JOIN cannot answer this question.
