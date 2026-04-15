# Data Catalog — Gold Layer

This document describes the **Gold Layer** of the Data Warehouse, containing curated and business-ready data models.

---

## `gold.dim_customers`

| Column Name       | Data Type     | Description |
|------------------|--------------|-------------|
| customer_key     | INT          | Surrogate key |
| customer_id      | INT          | Unique numerical identifier |
| customer_number  | VARCHAR(50)  | Alphanumerical identifier representing customer |
| first_name       | VARCHAR(50)  | Customer's first name |
| last_name        | VARCHAR(50)  | Customer's last name |
| country          | VARCHAR(50)  | Country of residence (e.g. 'Australia', 'Germany') |
| marital_status   | VARCHAR(50)  | Marital status ('Single', 'Married') |
| gender           | VARCHAR(50)  | Customer's gender (e.g. 'Male', 'Female') |
| birthdate        | DATE         | Customer's birthdate (YYYY-MM-DD) |
| create_date      | DATE         | Date of record creation |

---

## `gold.dim_products`

| Column Name      | Data Type     | Description |
|-----------------|--------------|-------------|
| product_key     | INT          | Surrogate key |
| product_id      | INT          | Unique identifier |
| product_number  | VARCHAR(50)  | Alphanumerical identifier representing product |
| category_id     | VARCHAR(50)  | Unique identifier for product category |
| category        | VARCHAR(50)  | Product classification |
| subcategory     | VARCHAR(50)  | More detailed classification |
| maintenance     | VARCHAR(50)  | Whether product requires maintenance |
| cost            | INT          | Base price |
| product_line    | VARCHAR(50)  | Product line |
| start_date      | DATE         | Model availability start date |

---

## `gold.fact_sales`

| Column Name    | Data Type     | Description |
|----------------|--------------|-------------|
| order_number   | VARCHAR(50)  | Unique alphanumerical identifier |
| product_key    | INT          | Foreign key → dim_products |
| customer_key   | INT          | Foreign key → dim_customers |
| order_date     | DATE         | Date of order |
| shipping_date  | DATE         | Date of shipping |
| due_date       | DATE         | Payment due date |
| sales_amount   | INT          | Total value of sale |
| quantity       | INT          | Number of units sold |
| price          | INT          | Unit price |

---

## Notes

- All tables belong to the **Gold Layer** (business-level data).
- Surrogate keys are used for dimensional modeling.
- Fact table links to dimensions via foreign keys.
- Data is optimized for analytics and reporting.

