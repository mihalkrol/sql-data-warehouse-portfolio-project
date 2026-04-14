SELECT
CASE WHEN sls_sales IS NULL OR sls_sales<0 THEN ABS(COALESCE(sls_price, 1)*sls_quantity)
    END AS sls_sales,
CASE WHEN sls_quantity IS NULL or sls_quantity<0 THEN ABS(sls_sales/COALESCE(sls_price, 1))
    END AS sls_quantity,
CASE WHEN sls_price IS NULL or sls_price<0 THEN ABS(sls_sales/COALESCE(sls_quantity, 1))
    END AS sls_price
FROM bronze.crm_sales_details;



