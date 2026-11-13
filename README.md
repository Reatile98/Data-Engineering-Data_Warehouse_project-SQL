# Data-Warehouse-project
Building a data warehouse with My SQL Workbench, including ETL process, data modelling and analytics.
# SQL Data Warehouse Project 🏗️

## 📖 Project Overview
This project demonstrates the design and implementation of a modern data warehouse using SQL. It focuses on building a structured data pipeline that extracts raw data from CRM and ERP source systems, transforms it into clean and integrated datasets, and models it for analytical purposes. 

The project follows the **Medallion Architecture** (Bronze, Silver, Gold) to ensure data quality, consistency, and business readiness.

## 🏗️ Architecture & Data Flow

The project follows the **Medallion Architecture (Bronze, Silver, Gold)** to ensure data quality, consistency, and business readiness. 

flowchart LR
    %% Source Systems
    subgraph Sources ["📥 Source Systems"]
        CRM[CRM Systems]
        ERP[ERP Systems]
    end

    %% Bronze Layer
    subgraph Bronze ["🥉 Bronze Layer Raw Data"]
        B_CRM[(bronze.crm)]
        B_ERP[(bronze.erp)]
    end

    %% Silver Layer
    subgraph Silver ["🥈 Silver Layer Cleaned Data"]
        S_CUST[silver.crm_cust_info]
        S_SALES[silver.crm_sales_details]
        S_PROD[silver.crm_prd_info]
        S_ERP_CUST[silver.erp_cust_az12]
        S_ERP_LOC[silver.erp_loc_a101]
        S_ERP_CAT[silver.erp_px_cat_g1v2]
    end

    %% Gold Layer
    subgraph Gold ["🥇 Gold Layer Business Ready"]
        G_DIM_C[gold.dim_customers]
        G_DIM_P[gold.dim_products]
        G_FACT[gold.fact_sales]
    end

    %% Connections
    CRM --> B_CRM
    ERP --> B_ERP

    B_CRM -->|Clean and Standardize| S_CUST
    B_CRM -->|Clean and Standardize| S_SALES
    B_CRM -->|Clean and Standardize| S_PROD
    
    B_ERP -->|Standardize Country and Gender| S_ERP_CUST
    B_ERP -->|Standardize Location| S_ERP_LOC
    B_ERP -->|Standardize Category| S_ERP_CAT

    S_CUST -->|Join| G_DIM_C
    S_ERP_CUST -->|Join| G_DIM_C
    S_ERP_LOC -->|Join| G_DIM_C

    S_PROD -->|Join| G_DIM_P
    S_ERP_CAT -->|Join| G_DIM_P

    S_SALES -->|Fact Integration| G_FACT
    G_DIM_C -->|Surrogate Keys| G_FACT
    G_DIM_P -->|Surrogate Keys| G_FACT

    %% Styling
    classDef bronze fill:#cd7f32,stroke:#333,stroke-width:2px,color:#fff;
    classDef silver fill:#c0c0c0,stroke:#333,stroke-width:2px,color:#000;
    classDef gold fill:#ffd700,stroke:#333,stroke-width:2px,color:#000;
    
    class Bronze,B_CRM,B_ERP bronze;
    class Silver,S_CUST,S_SALES,S_PROD,S_ERP_CUST,S_ERP_LOC,S_ERP_CAT silver;
    class Gold,G_DIM_C,G_DIM_P,G_FACT gold;

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


<img width="3033" height="3320" alt="deepseek_mermaid_20261112_0ce80b" src="https://github.com/user-attachments/assets/c0d0d124-a5e2-4eef-a312-d0a8dc5ec3a6" />

      
## 🛠️ Tech Stack & Tools

| Category | Technology |
| :--- | :--- |
| **Language** | ![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white) |
| **Database** | ![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white) |
| **IDE / Tool** | ![MySQL Workbench](https://img.shields.io/badge/MySQL_Workbench-005C84?style=for-the-badge&logo=mysql&logoColor=white) |
| **Version Control** | ![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white) ![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) |

## 🛠️ Technologies Used
*   **Language:** SQL
*   **Database:** [ MySQL nch]
*   **IDE/Tool:** [ MySQL Workbench]
*   **Version Control:** Git & GitHub

## 📂 Project Structure
```text
├── datasets/              # Raw source data (CSV files)
├── scripts/
│   ├── bronze/            # DDL and ingestion scripts
│   ├── silver/            # Data cleaning and transformation scripts
│   └── gold/              # Data modeling (Views creation)
└── README.md
