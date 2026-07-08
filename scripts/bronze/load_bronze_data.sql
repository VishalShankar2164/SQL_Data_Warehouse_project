/*
===============================================================================
                    Bronze Layer Data Load Script
===============================================================================
===============================================================================
                        CRM SOURCE TABLES LOAD
===============================================================================
Load: crm_cust_info
Target Table: bronze.crm_cust_info
Source File: cust_info.csv
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze as
BEGIN
    Declare @Start_Time DATETIME,@End_Time DATETIME; 
    BEGIN TRY
        PRINT '----- Loading bronze layer... -----';

        PRINT '----- Loading CRM Table... -----';

     Set @Start_Time = GETDATE();
        TRUNCATE TABLE bronze.crm_cust_info
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\Dell\Pictures\2.SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        TRUNCATE TABLE bronze.crm_prd_info
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\Dell\Pictures\2.SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        TRUNCATE TABLE bronze.crm_sales_details
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\Dell\Pictures\2.SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
    
        PRINT '----- Loading ERP Table... -----';

        TRUNCATE TABLE bronze.erp_LOC_A101
        BULK INSERT bronze.erp_LOC_A101
        FROM 'C:\Users\Dell\Pictures\2.SQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
    
        TRUNCATE TABLE bronze.erp_PX_CAT_G1V2
        BULK INSERT bronze.erp_PX_CAT_G1V2
        FROM 'C:\Users\Dell\Pictures\2.SQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
    
        TRUNCATE TABLE bronze.erp_CUST_AZ12
        BULK INSERT bronze.erp_CUST_AZ12
        FROM 'C:\Users\Dell\Pictures\2.SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
    Set @End_Time = GETDATE();
        PRINT '----- Loading Completed 100% -----';
        PRINT 'Load Duration: ' + CAST(DATEDIFF(second,@Start_Time,@End_Time) AS NVARCHAR(20));
    END TRY
    BEGIN CATCH
        PRINT 'Error During Loading bronze layer..';
        PRINT 'Error Message:' + ERROR_MESSAGE();
    END CATCH
END
