-- check row counts, duplicates, and nulls in crm_cust_info
SELECT COUNT(*) FROM bronze.crm_cust_info;

SELECT * FROM bronze.crm_cust_info LIMIT 10;

SELECT cst_id, COUNT(*) AS count_duplicates
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS null_count
FROM bronze.crm_cust_info
WHERE cst_id IS NULL;

-- check row counts, duplicates, and nulls in crm_prd_info
SELECT COUNT(*) FROM bronze.crm_prd_info;

SELECT * FROM bronze.crm_prd_info LIMIT 10;

SELECT prd_id, COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS null_count
FROM bronze.crm_prd_info
WHERE prd_id IS NULL;

-- check row counts, duplicates, and nulls in crm_sales_details
SELECT COUNT(*) FROM bronze.crm_sales_details;
SELECT * FROM bronze.crm_sales_details LIMIT 10;   

SELECT sls_prd_key, COUNT(*) AS count_duplicates
FROM bronze.crm_sales_details
GROUP BY sls_prd_key
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS null_count
FROM bronze.crm_sales_details
WHERE sls_prd_key IS NULL; 

-- check row counts, duplicates, and nulls in erp_cust_az12
SELECT COUNT(*) FROM bronze.erp_cust_az12;

SELECT * FROM bronze.erp_cust_az12 LIMIT 10;

SELECT cid, COUNT(*) AS count_duplicates
FROM bronze.erp_cust_az12
GROUP BY cid
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS null_count
FROM bronze.erp_cust_az12
WHERE cid IS NULL;

-- check row counts, duplicates, and nulls in erp_loc_a101

SELECT COUNT(*) FROM bronze.erp_loc_a101;
SELECT * FROM bronze.erp_loc_a101 LIMIT 10;
SELECT cid, COUNT(*)
FROM bronze.erp_loc_a101
GROUP BY cid
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS null_count
FROM bronze.erp_loc_a101
WHERE cid IS NULL;

-- check row counts, duplicates, and nulls in px_cat_g1v2

SELECT COUNT(*) FROM bronze.px_cat_g1v2;
SELECT * FROM bronze.px_cat_g1v2 LIMIT 10;
SELECT id, COUNT(*)
FROM bronze.px_cat_g1v2
GROUP BY id
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS null_count
FROM bronze.px_cat_g1v2
WHERE id IS NULL;
