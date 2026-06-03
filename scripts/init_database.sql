/*
===============================================================================
DataWarehouse Initialization Script
===============================================================================
Purpose:
    Creates the DataWarehouse database and establishes the Medallion
    architecture schemas.

Schemas:
    bronze - Stores raw data ingested from source systems.
    silver - Stores cleansed, validated, and transformed data.
    gold   - Stores business-ready data for reporting and analytics.

Version: 1.0
===============================================================================
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
