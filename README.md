# Data-Warehouse-project---SQL
Building a data warehouse with My SQL Workbench, including ETL process, data modelling and analytics.
# SQL Data Warehouse Project 🏗️

## 📖 Project Overview
This project demonstrates the design and implementation of a modern data warehouse using SQL. It focuses on building a structured data pipeline that extracts raw data from CRM and ERP source systems, transforms it into clean and integrated datasets, and models it for analytical purposes. 

The project follows the **Medallion Architecture** (Bronze, Silver, Gold) to ensure data quality, consistency, and business readiness.

## 🎯 Project Objectives
*   **Data Ingestion:** Extract and load raw data from CRM and ERP systems into the Bronze layer.
*   **Data Transformation:** Clean, standardize, and normalize data in the Silver layer (handling missing values, standardizing country codes, and resolving gender conflicts).
*   **Data Modeling:** Implement a dimensional **Star Schema** in the Gold layer for analytical reporting.
*   **Business Value:** Create business-ready fact and dimension views to answer key questions like "Which products generate the highest revenue?" and "Which countries have the highest sales?"

## 🏗️ Architecture (Medallion)
The project is structured into three distinct layers:

1.  **🥉 Bronze Layer (Raw Data):** Stores raw data ingested from source systems with minimal transformation.
2.  **🥈 Silver Layer (Cleaned Data):** Responsible for data cleaning, standardization, and integration. (e.g., removing hyphens from customer IDs, standardizing country names like 'DE' to 'Germany', and handling NULLs).
3.  **🥇 Gold Layer (Business Ready):** Contains the dimensional model, organized into a Star Schema consisting of Dimensions and Facts.

## 📊 Data Model (Gold Layer)
The Gold layer consists of three primary views:

*   **`gold.dim_customers`**: Integrates CRM and ERP customer data. Generates surrogate keys using `ROW_NUMBER()` and resolves conflicting gender data between systems.
*   **`gold.dim_products`**: Contains current product information. Filters out historical records (`WHERE prd_end_dt IS NULL`) and joins product categories.
*   **`gold.fact_sales`**: The central fact table connecting sales transactions to the customer and product dimensions using surrogate keys, allowing for robust slicing and dicing of sales metrics (amount, quantity, price).

**
<img width="3033" height="3320" alt="deepseek_mermaid_20261112_0ce80b" src="https://github.com/user-attachments/assets/c0d0d124-a5e2-4eef-a312-d0a8dc5ec3a6" />

      **

## 🛠️ Technologies Used
*   **Language:** SQL
*   **Database:** [Insert Database - e.g., MySQL]
*   **IDE/Tool:** [Insert Tool - e.g., MySQL Workbench]
*   **Version Control:** Git & GitHub

## 📂 Project Structure
```text
├── datasets/              # Raw source data (CSV files)
├── scripts/
│   ├── bronze/            # DDL and ingestion scripts
│   ├── silver/            # Data cleaning and transformation scripts
│   └── gold/              # Data modeling (Views creation)
└── README.md
