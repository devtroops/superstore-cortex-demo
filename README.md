# Superstore Cortex Demo

This repository contains a normalized Superstore dataset (split into `products`, `regions`, `customers`, `orders`, `order_items`) plus:
- Snowflake DDL and `COPY INTO` commands
- semantic model (JSON + YAML) for Cortex Analyst demos
- example NL → SQL prompts and demo notebook

## Repo structure
See `/data/raw` for the original CSV, `/data/split` for the normalized CSV files.

## E-R Diagram
<img width="2000" height="1125" alt="image" src="https://github.com/user-attachments/assets/c66a3233-587f-441e-bfb6-2efd74f7ac96" />

# Business requirements examples
-- Which states and cities are generating the highest revenue?
-- Which product category is both the best-selling and the most profitable?
-- Which product sub-categories and specific products are top performers as well as those that are underperforming?
-- Are there products that are frequently bought together?
-- Which customer segment is bringing in the most profit?
-- What is the most preferred shipping mode among our customers? ACCORDING TO REGION/CITY/STATE OF CUSTOMER

## Quickstart (clone + demo)
```bash
git clone https://github.com/devtroops/superstore-cortex-demo.git
cd superstore-cortex-demo

## Data Source Acknowledgement

The original Superstore dataset used in this project is sourced from the
public GitHub repository by WuCandice:

https://github.com/WuCandice/Superstore-Sales-Analysis

All credit for the raw dataset goes to the original creator.
This project only provides a normalized version of the data for educational
purposes and to demonstrate Snowflake Semantic Models and Cortex Analyst.

# Optionally: run the Python normalizer to re-generate split CSVs:
python3 scripts/normalize_superstore.py --input data/raw/Superstore.csv --out data/split/
