--                      DATA MODELLING GOLD LAYER 
-- ========================================================================================================================
/*This script focuses on data modelling and analytical data structuring. Its primary purpose is to transform
 the cleaned data stored in the Silver layer into datasets ready for business analytics using a dimensional modelling approach. 
 It creates two dimension views, namely dim_customers and dim_products, which contain descriptive information 
 about customers and products respectively. It also creates a central fact view, fact_sales, which contains measurable
 sales information and connects the dimensions using surrogate keys. The script applies techniques such as surrogate
 key generation, data integration through table joins, and filtering to ensure that only relevant product records are
 included. The resulting Gold layer follows a Star Schema structure, making the data easier to query and analyse for 
 business intelligence, reporting and dashboard development.
*/
-- ==========================================================================================================================

--                               CREATING CUSTOMER DIMENSIONS VIEW 

create or replace view gold.dim_customers as 
select
	row_number() over (order by ci.cst_id) as customer_key,
    ci.cst_id as customer_id,
    ci.cst_key as customer_number,
    ci.cst_firstname as first_name,
    ci.cst_lastname as last_name,
    la.cntry as country,
    ci.cst_marital_status as marital_status,
    
    case when ci.cst_gndr is not null
				and ci.cst_gndr <> 'n/a'
		 then ci.cst_gndr
         else coalesce(ca.gen, 'n/a')
	end as gender,
    ca.bdate as birthdate,
    ci.cst_create_date as create_date
    
    from silver.crm_cust_info as ci
    left join silver.erp_cust_az12 as ca
    on ci.cst_key = ca.cid
    
    left join silver.erp_loc_a101 as la
    on ci.cst_key = la.cid;
   
   select*from gold.dim_customers
   limit 10;
   -- ==============================================================================================
   
   
--                               CREATING PRODUCTS DIMENSIONS VIEW 

create or replace view gold.dim_products as
select
	row_number() over(
		order by pn.prd_start_dt,pn.prd_key)
	as product_key,
    
    pn.prd_id as product_id,
    pn.prd_key as product_number,
    pn.prd_nm as product_name,
    pn.cat_id as category_id,
    pc.cat as subcategory,
    pc.maintenance as maintenence,
    pn.prd_cost as cost,
    pn.prd_line as product_line,
    pn.prd_start_dt as start_date
    
from silver.crm_prd_info pn
left join silver.erp_px_cat_g1v2 pc
	on pn.cat_id = pc.ID
where pn.prd_end_dt is null;

select*from gold.dim_products
   limit 10;
-- ========================================================================================

--                               CREATING FACT SALES VIEW 

create or replace view gold.fact_sales as
select
sd.sls_ord_num as order_number,
pr.product_key,
cu.customer_key,
sd.sls_order_dt as order_date,
sd.sls_ship_dt as shopping_date,
sd.sls_due_dt as due_date,
sd.sls_sales as sales_amount,
sd.sls_quantity as quantity,
sd.sls_price as sales_price
from silver.crm_sales_details sd
left join gold.dim_products pr
on sd.sls_prd_key = pr.product_number
left join gold.dim_customers cu
on sd.sls_cust_id = cu.customer_id;

select*from gold.fact_sales
limit  10;






