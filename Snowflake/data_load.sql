-- Summary of objects created in this script:
--
-- Roles:
--   - cortex_analyst
--
-- Warehouses:
--   - cortex_wh
--
-- Databases:
--   - superstore
--   
-- Schemas:
--   - superstore.sales
--
-- File Format:
--   - csvformat

use role accountadmin;

create or replace role cortex_analyst;

grant create warehouse on account to role CORTEX_ANALYST;
grant create database on account to role cortex_analyst;
-
set current_user = (select current_user());   
grant role cortex_analyst to user identifier($current_user);
alter user set default_role = cortex_analyst;
alter user set default_warehouse = cortex_wh;

use role cortex_analyst;
use warehouse cortex_wh; 

CREATE OR REPLACE DATABASE SUPERSTORE;
CREATE OR REPLACE SCHEMA SALES;
CREATE WAREHOUSE IF NOT EXISTS CORTEX_WH;


 
--CREATION OF FILE FORMAT
create or replace file format csvformat  
  skip_header = 1  --SKIP THE FIRST ROW 
  field_optionally_enclosed_by = '"'  
  type = 'csv';  
--CREATION OF STAGE
create or replace stage data_stage  
  file_format = csvformat ;
  
--QUICKLY LOAD THE DATA USING SNOWSIGHT
-- customers 
CREATE OR REPLACE TABLE customers (
customer_id VARCHAR PRIMARY KEY,
customer_name VARCHAR,
segment VARCHAR,
country VARCHAR,
city VARCHAR,
state VARCHAR,
postal_code VARCHAR
);


-- regions
CREATE OR REPLACE TABLE regions (
region_id INTEGER AUTOINCREMENT PRIMARY KEY,
region_name VARCHAR UNIQUE
);


-- products
CREATE OR REPLACE TABLE products (
product_id VARCHAR PRIMARY KEY,
product_name VARCHAR,
category VARCHAR,
sub_category VARCHAR
);


-- orders (header / order-level)
CREATE OR REPLACE TABLE orders (
order_id VARCHAR PRIMARY KEY,
order_date DATE,
ship_date DATE,
ship_mode VARCHAR,
customer_id VARCHAR REFERENCES customers(customer_id),
region_id INTEGER REFERENCES regions(region_id)
);


-- order_items (fact table; one row per product in an order)
CREATE OR REPLACE TABLE order_items (
order_item_id INTEGER AUTOINCREMENT PRIMARY KEY,
order_id VARCHAR REFERENCES orders(order_id),
product_id VARCHAR REFERENCES products(product_id),
quantity INTEGER,
sales NUMBER(12,2),
discount NUMBER(6,4),
profit NUMBER(12,2)
--profit_margin_pct NUMBER(6,4)
);

LS @DATA_STAGE;

SELECT $1,$2 FROM @SUPERSTORE.SALES.DATA_STAGE/products.csv;


--MAKE YOUR DATASET READY
COPY INTO products
FROM @data_stage/products.csv
FILE_FORMAT = (FORMAT_NAME = 'csvformat')
ON_ERROR = 'ABORT_STATEMENT';

COPY INTO regions
FROM @data_stage/regions.csv
FILE_FORMAT = (FORMAT_NAME = 'csvformat')
ON_ERROR = 'ABORT_STATEMENT';

COPY INTO customers
FROM @data_stage/customers.csv
FILE_FORMAT = (FORMAT_NAME = 'csvformat')
ON_ERROR = 'ABORT_STATEMENT';

COPY INTO orders
FROM @data_stage/orders.csv
FILE_FORMAT = (FORMAT_NAME = 'csvformat')
ON_ERROR = 'ABORT_STATEMENT';

COPY INTO order_items
FROM @data_stage/order_items.csv
FILE_FORMAT = (FORMAT_NAME = 'csvformat')
ON_ERROR = 'ABORT_STATEMENT';
