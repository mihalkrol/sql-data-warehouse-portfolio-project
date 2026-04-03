/* 
 * This SQL script initializes the necessary schemas for the data architecture.
 * It creates four schemas: bronze, silver, gold, and analytics.
 */


CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;
CREATE SCHEMA IF NOT EXISTS analytics;