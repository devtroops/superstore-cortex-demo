# Superstore Cortex Demo

This repository contains a normalized Superstore dataset (split into `products`, `regions`, `customers`, `orders`, `order_items`) plus:
- Snowflake DDL and `COPY INTO` commands
- semantic model (JSON + YAML) for Cortex Analyst demos
- example NL → SQL prompts and demo notebook

## Repo structure
See `/data/raw` for the original CSV, `/data/split` for the normalized CSV files.

## Quickstart (clone + demo)
```bash
git clone https://github.com/devtroops/superstore-cortex-demo.git
cd superstore-cortex-demo

# Optionally: run the Python normalizer to re-generate split CSVs:
python3 scripts/normalize_superstore.py --input data/raw/Superstore.csv --out data/split/
