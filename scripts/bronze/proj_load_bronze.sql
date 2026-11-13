        -- INSERTING DATA INTO THE TABLES
-- ==================================================================================================
/* This scrips inserts data into the bronze layer tables. The source data is loaded without 
any transformations because this is the raw data layer and it i obtained as a CSV file from my uploads
directory. By TRUNCATING the table we are insuring that there is no data in before loading it then
the first raw is ignored because it had been included as the table heading when creating tables.
*/
-- ==================================================================================================
    
              -- LOADING DATA INTO CUST_INFO TABLE
    
TRUNCATE TABLE bronze.crm_cust_info;

LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\cust_info.csv'
INTO TABLE bronze.crm_cust_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS rows_in_sales
FROM bronze.crm_cust_info;

          -- LOADING DATA INTO PRD_INFO TABLE

TRUNCATE TABLE bronze.crm_prd_info;

LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\prd_info.csv'
INTO TABLE bronze.crm_prd_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS rows_in_sales
FROM bronze.crm_prd_info;

             -- LOADING DATA INTO SALES_DETAILS TABLE

TRUNCATE TABLE bronze.crm_sales_details;

LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\sales_deails.csv'
INTO TABLE bronze.crm_sales_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS rows_in_sales
FROM bronze.crm_sales_details;

               -- LOADING DATA INTO CUST_AZ12 TABLE

TRUNCATE TABLE bronze.erp_cust_az12;

LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\cust_az12.csv'
INTO TABLE bronze.erp_cust_az12
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS rows_in_sales
FROM bronze.erp_cust_az12;

               -- LOADING DATA INTO LOC_A101 TABLE

TRUNCATE TABLE bronze.erp_loc_a101;

LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\loc_a101.csv'
INTO TABLE bronze.erp_loc_a101
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS rows_in_sales
FROM bronze.erp_loc_a101;

                    -- LOADING DATA INTO PX_CAT_G1V2 TABLE

TRUNCATE TABLE bronze.erp_px_cat_g1v2;

LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\px_cat_g1v2.csv'
INTO TABLE bronze.crm_cust_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS rows_in_sales
FROM bronze.erp_px_cat_g1v2;

-- ==================================================================================================
/*NOTE: DUE TO COPLICATIONS WITH MYSQL WORKBENCH I HAD TO USE THE TABLE DATA IMPORT WIZARD */
-- ==================================================================================================
