                -- CREATING TABLES FOR THE BRONZE LAYER--
/*==================================================================================================================
This script creates tables for the Bronze layer. The tables are created in relation to the crm and erp data sources 
that contains the data that is going to be inserted into our bronze layer. Note that when creating the tablefirstly
it is dropped if it exists. this is to replace any existing similar table. this is only done at this stage in which
the ables are empty.At the later stage tables will only be altered to avoid losing vital information.
=====================================================================================================================
*/
--                    CRM FILE SOURCE

DROP TABLE IF EXISTS bronze.crm_cust_info;
create table bronze.crm_cust_info (
cst_id int,
cst_key varchar(50),
cst_firstname varchar(50),
cst_lastname varchar(50),
cst_marital_status varchar(50),
cst_gndr varchar(50),
cst_create_date DATE
);

DROP TABLE IF EXISTS bronze.crm_prd_info;
create table bronze.crm_prd_info (
prd_id INT,
prd_key VARCHAR(50),
prd_nm VARCHAR(50),
prd_cost INT,
prd_line VARCHAR(50),
prd_start_dt DATE,
prd_end_dt DATE
);

DROP TABLE IF EXISTS bronze.crm_sales_details;
create table bronze.crm_sales_details (
sls_ord_num VARCHAR(50),
sls_prd_key VARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT
);
-- ERP FILE SOURCE
DROP TABLE IF EXISTS bronze.erp_cust_az12;
create table bronze.erp_cust_az12 (
CID VARCHAR(50),
BDATE DATE,
GEN VARCHAR(50)
);

DROP TABLE IF EXISTS bronze.erp_loc_a101;
create table bronze.erp_loc_a101 (
CID VARCHAR(50),
CNTRY VARCHAR(50)
);

DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;
create table bronze.erp_px_cat_g1v2 (
ID VARCHAR(50),
CAT VARCHAR(50),
SUBCAT VARCHAR(50),
MAINTENANCE VARCHAR(50)
);
DROP TABLE IF EXISTS bronze.epr_loca101;

-- ===============================================================================================
