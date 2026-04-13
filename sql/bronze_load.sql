\set ON_ERROR_STOP on
\timing ON

\! echo 'LOAD START'
\! echo '-----------------------------------------------'
\! echo 'Loading data into bronze layer...'

\! echo '--------- crm_cust_info TRUNCATE AND LOAD ---------'
TRUNCATE TABLE bronze.crm_cust_info;
\copy bronze.crm_cust_info FROM 'datasets/source_crm/cust_info.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');

\! echo '--------- crm_prd_info TRUNCATE AND LOAD ---------'

TRUNCATE TABLE bronze.crm_prd_info;
\copy bronze.crm_prd_info FROM 'datasets/source_crm/prd_info.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');

\! echo '--------- crm_sales_details TRUNCATE AND LOAD ---------'

TRUNCATE TABLE bronze.crm_sales_details;
\copy bronze.crm_sales_details FROM 'datasets/source_crm/sales_details.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');

\! echo '--------- crm_erp_cust_az12 TRUNCATE AND LOAD ---------'

TRUNCATE TABLE bronze.erp_cust_az12;
\copy bronze.erp_cust_az12 FROM 'datasets/source_erp/cust_az12.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');

\! echo '--------- crm_erp_loc_a101 TRUNCATE AND LOAD ---------'

TRUNCATE TABLE bronze.erp_loc_a101;
\copy bronze.erp_loc_a101 FROM 'datasets/source_erp/loc_a101.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');


\! echo '--------- crm_px_cat_g1v2 TRUNCATE AND LOAD ---------'
TRUNCATE TABLE bronze.px_cat_g1v2;
\copy bronze.px_cat_g1v2 FROM 'datasets/source_erp/px_cat_g1v2.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');
\! echo '-----------------------------------------------'
\! echo 'LOAD COMPLETE'