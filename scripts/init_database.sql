/*
===============================================================================
DataWarehouse Initialization Script
===============================================================================

Purpose:
    Creates the DataWarehouse database and initializes the Medallion
    architecture schemas used for data ingestion, transformation,
    and analytics.

Schemas:
    bronze - Raw data layer containing source-system data as ingested.
    silver - Cleansed, validated, and transformed data layer.
    gold   - Curated, business-ready data layer for reporting and analytics.

Version:
    1.0

===============================================================================
*/

-- Create the DataWarehouse database
CREATE DATABASE DataWarehouse;
GO

-- Switch context to the DataWarehouse database
USE DataWarehouse;
GO

-- Create Bronze schema for raw source data
CREATE SCHEMA bronze;
GO

-- Create Silver schema for cleansed and transformed data
CREATE SCHEMA silver;
GO

-- Create Gold schema for business-ready reporting and analytics
CREATE SCHEMA gold;
GO
