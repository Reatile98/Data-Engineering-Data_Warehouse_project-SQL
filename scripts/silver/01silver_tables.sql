  -- CREATING SILVER LAYER TABLES
-- ========================================================================================
/* This scrips creates and sets up the tables for the silver layer. Note that at this stage 
when creating tables they are created using LIKE which makes then exactly like the bronze 
layer tables. They are then altered to create records of of when a row was created in our 
data warehouse.*/
-- ========================================================================================

CREATE TABLE silver.crm_cust_info
LIKE bronze.crm_cust_info;

CREATE TABLE silver.crm_prd_info
LIKE bronze.crm_prd_info;

CREATE TABLE silver.crm_sales_details
LIKE bronze.crm_sales_details;

-- ALTERING THE TABLES

ALTER TABLE silver.crm_cust_info
ADD COLUMN dwh_create_date DATETIME
DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE silver.crm_prd_info
ADD COLUMN dwh_create_date DATETIME
DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE silver.crm_sales_details
ADD COLUMN dwh_create_date DATETIME
DEFAULT CURRENT_TIMESTAMP;

-------------
CREATE TABLE silver.erp_cust_az12
LIKE bronze.erp_cust_az12;

CREATE TABLE silver.erp_loc_a101
LIKE bronze.erp_loc_a101;

CREATE TABLE silver.erp_px_cat_g1v2
LIKE bronze.erp_px_cat_g1v2;

-- ALTERING TABLES

ALTER TABLE silver.erp_cust_az12
ADD COLUMN dwh_create_date DATETIME
DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE silver.erp_loc_a101
ADD COLUMN dwh_create_date DATETIME
DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE silver.erp_px_cat_g1v2
ADD COLUMN dwh_create_date DATETIME
DEFAULT CURRENT_TIMESTAMP;

-- =========================================================================================
