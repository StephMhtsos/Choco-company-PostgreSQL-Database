# Choco-company-PostgreSQL-Database
Choco is a wholesale supplier that imports various types of chocolate from international markets and sells to bakeries, confectioneries, and chocolate manufacturers in Greece. This project models their database schema, populates it with sample data, and implements 20 SQL queries covering a wide range of database concepts.


A relational database project for **Choco**, a wholesale chocolate supplier managing customers, products, and orders. Built with PostgreSQL as part of a university database course.

---

##  Overview

Choco is a wholesale supplier that imports various types of chocolate from international markets and sells to bakeries, confectioneries, and chocolate manufacturers in Greece. This project models their database schema, populates it with sample data, and implements 20 SQL queries covering a wide range of database concepts.

---

##  Repository Structure

```
choco-postgresql/
├── tables.sql        # CREATE TABLE statements (schema)
├── queries.sql       # 20 SQL queries (Q1–Q20)
├── CUSTOMER-data.csv         # Sample customer data (1000 records)
├── PRODUCT-data.csv          # Sample product data (100 records)
├── ORDERS-data.csv           # Sample orders data
├── ORDER_DETAILS-data.csv    # Sample order details data

```

---

##  Schema

The database consists of 4 tables:

```
CUSTOMERS(cust_no, cust_name, street, number, town, postcode, cr_limit, curr_balance)
PRODUCTS(prod_code, description, prod_origin, list_price, qty_on_hand, reorder_level, reorder_qty)
ORDERS(order_no, order_date, cust_no)
ORDER_DETAILS(order_no, prod_code, order_qty, order_price)
```

### Relationships
- `ORDERS.cust_no` → `CUSTOMERS.cust_no`
- `ORDER_DETAILS.order_no` → `ORDERS.order_no`
- `ORDER_DETAILS.prod_code` → `PRODUCTS.prod_code`

### Constraints
- **PRIMARY KEY** on all tables
- **FOREIGN KEY** for referential integrity
- **CHECK**: `prod_origin IN ('SA','CA','WA','EA','AS')`
- **CHECK**: `order_qty >= 10`
- **DEFAULT**: `curr_balance = 0`, `qty_on_hand = 0`

---

## 📊 Queries Implemented

| # | Description |
|---|---|
| Q1 | Customers ranked by outstanding balance |
| Q2 | Products that need immediate reordering |
| Q3 | Customers who ordered 'Almond-Choco' in April 2025 |
| Q4 | Orders where quantity exceeds reorder quantity |
| Q5 | Best order for 'OrangeChoco' products |
| Q6 | Cities with average credit limit above 9,000€ |
| Q7 | Min/Max order value per product |
| Q8 | Days in June 2025 with daily orders exceeding 35,000€ |
| Q9 | Products ordered in January 2024 with customer count |
| Q10 | Most expensive products by list price |
| Q11 | Date of the largest order ever |
| Q12 | Customers with no orders in February 2025 |
| Q13 | Customers who ordered on August 12th 2025 |
| Q14 | Product origin with highest stock value percentage |
| Q15 | Products ever sold below list price |
| Q16 | Orders with no matching customer (data audit) |
| Q17 | Customers who have never placed an order |
| Q18 | Products ordered in April 2024 or 2+ times in May 2025 |
| Q19 | Product descriptions and customer names for orders from Ξάνθη |
| Q20 | Maximum amount a customer exceeds their credit limit |

> All 20 queries are written as **single SQL statements** with no intermediate results.

---

##  How to Run

### Prerequisites
- [PostgreSQL](https://www.postgresql.org/download/)
- [pgAdmin 4](https://www.pgadmin.org/download/) (recommended)

### Steps

1. **Create the database** in pgAdmin and open the Query Tool

2. **Run the schema:**
```sql
-- Run tables.sql in pgAdmin Query Tool
```

3. **Import the CSV files** — for each table, right-click → Import/Export Data:
   - Import order: `CUSTOMERS` → `PRODUCTS` → `ORDERS` → `ORDER_DETAILS`
   - Settings: Header ON, Delimiter: comma

4. **Run any query** from `queries.sql`

---

##  Technologies

- **PostgreSQL** — Database management system
- **pgAdmin 4** — GUI for database management
- **SQL** — Query language

---

##  SQL Concepts Used

- `JOIN` (INNER, LEFT)
- Aggregate functions (`SUM`, `AVG`, `MAX`, `MIN`, `COUNT`)
- `GROUP BY` & `HAVING`
- Subqueries
- `EXTRACT()` for date filtering
- `DISTINCT`
- `LIKE` for pattern matching

---