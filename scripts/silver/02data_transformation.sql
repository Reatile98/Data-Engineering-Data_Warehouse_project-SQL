 --                  SILVER LAYER DATA TRANSFORMATION AND INSERTING
 -- =================================================================================================
/* This script focuses heavily  on data analytics. What it does is data transformaton. it 
undertakes data cleaning procedures such as data normalization, data standardisation and 
assuring data consistency.  After data has been transformed the script inserts it in the silver
layer.*/
-- ====================================================================================================
--                    TRANSFORMING AND INSERTING CRM_CUST_INFO
-- ====================================================================================================
insert into silver.crm_cust_info(
cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_marital_status,
cst_gndr,
cst_create_date)
select
cst_id,
cst_key,
TRIM(cst_firstname) as cst_firstname,
TRIM(cst_lastname) as cst_lastname,
case when upper(TRIM(cst_marital_status)) = 'S' THEN 'Single'
	when upper(TRIM(cst_marital_status)) = 'M' then 'Married'
    else 'n/a'
end cst_marital_status,
case when upper(TRIM(cst_gndr)) = 'F' THEN 'Female'
	when upper(TRIM(cst_gndr)) = 'M' then 'Male'
    else 'n/a'
end cst_gndr,
cst_create_date
from (
select *,
row_number() over(partition by cst_id order by cst_create_date DESC)
 AS flag_last
from bronze.crm_cust_info
WHERE cst_id IS NOT NULL)
as t where flag_last = 1 ;

-- ======================================================================================================
--                    TRANSFORMING AND INSERTING CRM_PRD_INFO
-- ======================================================================================================
alter table silver.crm_prd_info
	add column cat_id varchar(50) after prd_id,
    modify column prd_start_dt date,
    modify column prd_end_dt date;

insert into silver.crm_prd_info(
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
)
select 
prd_id,
replace(substring(prd_key,1,5),'-','_') as cat_id,
substring(prd_key, 7, length(prd_key)) as prd_key,
prd_nm,
ifnull(prd_cost, 0) as prd_cost,
case upper(trim(prd_line))
	when 'M' then 'Mountain'
    when 'R' then 'Road'
    when 'S' then 'Other Sales'
    when 'T' then 'Touring'
    else 'N/A'
end as prd_line,
cast(prd_start_dt as date) as prd_start_dt,
cast(lead(prd_end_dt) over (partition by prd_key order by prd_start_dt) -1 as date) as prd_end_dt
FROM bronze.crm_prd_info;

select *
from silver.crm_prd_info;

-- ======================================================================================================
--                    TRANSFORMING AND INSERTING CRM_SALES_DEAILS
-- =======================================================================================================
alter table silver.crm_sales_details
	modify column sls_order_dt date,
    modify column sls_ship_dt date,
    modify column sls_due_dt date;
insert into silver.crm_sales_details(
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
)
select
sls_ord_num,
sls_prd_key,
sls_cust_id,
case when sls_order_dt = 0 or length(sls_order_dt) !=8 then null
else str_to_date(cast(sls_order_dt as char),'%Y%m%d')
end as sls_order_dt,
case when sls_ship_dt = 0 or length(sls_ship_dt) !=8 then null
else str_to_date(cast(sls_ship_dt as char),'%Y%m%d')
end as sls_ship_dt,
case when sls_due_dt = 0 or length(sls_due_dt) !=8 then null
else str_to_date(cast(sls_due_dt as char),'%Y%m%d')
end as sls_due_dt,	
case  when sls_sales is null 
	or sls_sales < 0 
    or sls_sales != sls_quantity * abs(sls_price) 
    then sls_quantity * abs(sls_price)
    else sls_sales
end as sls_sales, 
sls_quantity,
case when sls_price is null or sls_price = 0
	then sls_sales / nullif(sls_quantity, 0)
    else sls_price
end as sls_price    
from bronze.crm_sales_details;

select *
from silver.crm_sales_details;

-- =========================================================================================================
--                    TRANSFORMING AND INSERTING EPR_CUST_AZ12
-- =========================================================================================================

insert into silver.erp_cust_az12 (CID,BDATE,GEN)
select
case when CID like 'NAS%' then substring(CID,4, length(CID))
	else CID
END AS CID,
case when BDATE > current_date() then null
	else BDATE
end as BDATE,
case when upper(trim(GEN)) in ('F', 'FEMALE') then 'female'
	when upper(trim(GEN)) in ('M', 'MALE') then 'male'
	else 'n/a'
end as GEN
from bronze.erp_cust_az12;
select*from silver.erp_cust_az12;
-- =============================================================================================
--                    TRANSFORMING AND INSERTING EPR_LOC_A101
-- =============================================================================================

insert into silver.erp_loc_a101(CID,CNTRY)
select
replace(CID, '-', '') as CID,
case when trim(CNTRY) = 'DE' then 'Germany'
	when trim(CNTRY) in ('US','USA') then 'United States'
    when trim(CNTRY) = '' or CNTRY is null then 'n/a'
    else trim(CNTRY)
end as CNTRY
from bronze.erp_loc_a101;

select*FROM silver.erp_loc_a101;

-- ================================================================================================
--                    TRANSFORMING AND INSERTING EPR_PX_CAT_G1V2
-- ================================================================================================
insert into silver.erp_px_cat_g1v2(
ID, CAT,SUBCAT,MAINTENANCE)
select
ID,
CAT,
SUBCAT,
MAINTENANCE
from bronze.erp_px_cat_g1v2;
select* from silver.erp_px_cat_g1v2;

-- ==================================================================================================
