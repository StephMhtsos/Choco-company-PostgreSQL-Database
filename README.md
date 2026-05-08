# Choco-company-PostgreSQL-Database
Choco is a wholesale supplier that imports various types of chocolate from international markets and sells to bakeries, confectioneries, and chocolate manufacturers in Greece. This project models their database schema, populates it with sample data, and implements 20 SQL queries covering a wide range of database concepts.
📋 Overview
Choco-K29 is a wholesale supplier that imports various types of chocolate from international markets and sells to bakeries, confectioneries, and chocolate manufacturers in Greece. This project models their database schema, populates it with sample data, and implements 20 SQL queries covering a wide range of database concepts.

Repository Structure
choco-k29-postgresql/
├── project2tables.sql        # CREATE TABLE statements (schema)
├── project2queries.sql       # 20 SQL queries (Q1–Q20)
├── CUSTOMER-data.csv         # Sample customer data (1000 records)
├── PRODUCT-data.csv          # Sample product data (100 records)
├── ORDERS-data.csv           # Sample orders data
├── ORDER_DETAILS-data.csv    # Sample order details data
└── Project_2_readme.pdf      # Project write-up and assumptions

Schema
The database consists of 4 tables:
CUSTOMERS(cust_no, cust_name, street, number, town, postcode, cr_limit, curr_balance)
PRODUCTS(prod_code, description, prod_origin, list_price, qty_on_hand, reorder_level, reorder_qty)
ORDERS(order_no, order_date, cust_no)
ORDER_DETAILS(order_no, prod_code, order_qty, order_price)
Relationships

ORDERS.cust_no → CUSTOMERS.cust_no
ORDER_DETAILS.order_no → ORDERS.order_no
ORDER_DETAILS.prod_code → PRODUCTS.prod_code

Constraints

PRIMARY KEY on all tables
FOREIGN KEY for referential integrity
CHECK: prod_origin IN ('SA','CA','WA','EA','AS')
CHECK: order_qty >= 10
DEFAULT: curr_balance = 0, qty_on_hand = 0


📊 Queries Implemented
#DescriptionQ1Customers ranked by outstanding balanceQ2Products that need immediate reorderingQ3Customers who ordered 'Almond-Choco' in April 2025Q4Orders where quantity exceeds reorder quantityQ5Best order for 'OrangeChoco' productsQ6Cities with average credit limit above 9,000€Q7Min/Max order value per productQ8Days in June 2025 with daily orders exceeding 35,000€Q9Products ordered in January 2024 with customer countQ10Most expensive products by list priceQ11Date of the largest order everQ12Customers with no orders in February 2025Q13Customers who ordered on August 12th 2025Q14Product origin with highest stock value percentageQ15Products ever sold below list priceQ16Orders with no matching customer (data audit)Q17Customers who have never placed an orderQ18Products ordered in April 2024 or 2+ times in May 2025Q19Product descriptions and customer names for orders from ΞάνθηQ20Maximum amount a customer exceeds their credit limit
