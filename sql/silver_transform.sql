-- silver.crm_cust_info truncate and insert with transformations

TRUNCATE TABLE silver.crm_cust_info;

INSERT INTO silver.crm_cust_info (
    cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_material_status,
    cst_gndr,
    cst_create_date
)

SELECT
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname, 
CASE WHEN UPPER(cst_material_status) = 'M' THEN 'Married'
    WHEN UPPER(cst_material_status) = 'S' THEN 'Single'
END AS cst_material_status,
CASE WHEN UPPER(cst_gndr) = 'M' THEN 'Male'
    WHEN UPPER(cst_gndr) = 'F' THEN 'Female'
END AS cst_gndr,
cst_create_date
FROM (

SELECT *,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info
)
WHERE flag_last = 1;

-- silver.crm_prd_info truncate and insert with transformations

TRUNCATE TABLE silver.crm_prd_info;

INSERT INTO silver.crm_prd_info (
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)   

SELECT prd_id,
REPLACE(SUBSTRING(prd_key,1,5), '-', '_') AS cat_id,
SUBSTRING(prd_key, 7, LENGTH(prd_key)) AS prd_key,
prd_nm,
COALESCE(prd_cost,0) AS prd_cost,
CASE WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
    WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
    WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
    WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'other Sales'
END AS prd_line,
CAST(prd_start_dt AS DATE) AS prd_start_dt,
-- fixing end date (no overlapping production series)
CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - INTERVAL '1 day' AS DATE)  AS prd_end_dt_test
FROM bronze.crm_prd_info


-- silver.crm_sales_details truncate and insert with transformations

TRUNCATE TABLE silver.crm_sales_details;

INSERT INTO silver.crm_sales_details (
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_ord_dt,
    sls_ship_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
)

SELECT
sls_ord_num,
sls_prd_key,
sls_cust_id,
-- changing date format from integers to DATE
CASE WHEN sls_ord_dt = 0 OR LENGTH(sls_ord_dt::TEXT) != 8 THEN NULL
    ELSE TO_DATE(sls_ord_dt::TEXT, 'YYYYMMDD') END AS sls_ord_dt,
CASE WHEN sls_ship_dt = 0 OR LENGTH(sls_ship_dt::TEXT) != 8 THEN NULL
    ELSE TO_DATE(sls_ship_dt::TEXT, 'YYYYMMDD') END AS sls_ship_dt,
CASE WHEN sls_due_dt = 0 OR LENGTH(sls_due_dt::TEXT) != 8 THEN NULL
    ELSE TO_DATE(sls_due_dt::TEXT, 'YYYYMMDD') END AS sls_due_dt,
-- fixing sales (negatives, nulls, mismatches)
CASE WHEN sls_sales IS NULL 
    OR sls_sales <0 
    OR sls_price*sls_quantity != sls_sales
    THEN ABS(sls_quantity * sls_price)
    ELSE sls_sales 
    END AS sls_sales,
sls_quantity,
CASE WHEN sls_price IS NULL or sls_price < 0 THEN ABS(sls_sales/sls_quantity)
    ELSE sls_price END AS sls_price
FROM bronze.crm_sales_details;


-- silver.erp_cust_az12 truncate and insert with transformations

TRUNCATE TABLE silver.erp_cust_az12;

INSERT INTO silver.erp_cust_az12 (
    cid,
    bdate,
    gen
)

SELECT
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,13)
    ELSE cid END AS cid,
CASE WHEN bdate > CURRENT_DATE THEN NULL
    ELSE bdate END AS bdate,
CASE WHEN UPPER(gen) IN ('M', 'MALE') THEN 'Male'
    WHEN UPPER(gen) IN ('F', 'FEMALE') THEN 'Female'
END AS gen
FROM bronze.erp_cust_az12;

-- silver.erp_loc_a101 truncate and insert with transformations

TRUNCATE TABLE silver.erp_loc_a101;

INSERT INTO silver.erp_loc_a101 (
    cid,
    cntry
)

SELECT
REPLACE (cid, '-', '') AS cid   , 
CASE WHEN cntry = 'US' THEN 'United States'
    WHEN cntry = 'DE' THEN 'Germany'
    WHEN cntry = ' ' THEN NULL
    ELSE cntry END AS cntry
FROM bronze.erp_loc_a101;


-- silver.px_cat_g1v2 truncate and insert with transformations

TRUNCATE TABLE silver.px_cat_g1v2;

INSERT INTO silver.px_cat_g1v2 (
    id,
    cat,
    subcat,
    maintnance
)

SELECT
id, cat, subcat, maintnance
FROM bronze.px_cat_g1v2;