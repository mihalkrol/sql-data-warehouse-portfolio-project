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
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date) AS flag_last
FROM bronze.crm_cust_info
)
WHERE flag_last = 1;