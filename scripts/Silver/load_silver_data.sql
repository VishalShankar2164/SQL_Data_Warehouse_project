CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    /*
    ===============================================================================
    Table: silver.crm_cust_info
    Schema: silver
    ===============================================================================
    */
    TRUNCATE TABLE silver.crm_cust_info;
    PRINT 'Inserting Data into silver.crm_cust_info';

    Insert INTO silver.crm_cust_info( 
        cst_id ,
        cst_key,
        cst_firstname,
        cst_lastname,
        cst_marital_status,
        cst_gndr,
        cst_create_date
        )
    select 
        cst_id,
        cst_key,
        trim(cst_firstname) as cst_firstname,
        trim(cst_lastname) as cst_lastname,
        Case    when Upper(trim(cst_marital_status)) =  'S' then 'Single'
	            when upper(trim(cst_marital_status)) = 'M' then 'Married'
	            else 'N/A' 
        end cst_marital_status,
        Case    when Upper(cst_gndr) =  'F' then 'Female'
	            when upper(cst_gndr) = 'M' then 'Male'
	            else 'N/A' 
        end cst_gndr,
        cst_create_date
    FROM(
	        select *,
	        ROW_NUMBER() OVER(Partition BY cst_id Order by cst_create_date DESC) AS flag_last 
	        FROM bronze.crm_cust_info
            where cst_id IS NOT NULL
        )t 
            Where flag_last = 1;


    /*
    ===============================================================================
    Table: silver.crm_prd_info
    Schema: silver
    ===============================================================================
    */
    TRUNCATE TABLE silver.crm_prd_info;
    PRINT 'Inserting Data into silver.crm_prd_info';

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
		    SELECT
			    prd_id,
			    REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id, -- Extract category ID
			    SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,        -- Extract product key
			    prd_nm,
			    ISNULL(prd_cost, 0) AS prd_cost,
			    CASE 
				    WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
				    WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
				    WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
				    WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
				    ELSE 'n/a'
			    END AS prd_line, -- Map product line codes to descriptive values
			    CAST(prd_start_dt AS DATE) AS prd_start_dt,
			    DATEADD(DAY, -1,LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)) AS prd_end_dt
	    FROM bronze.crm_prd_info;


    /*
    ===============================================================================
    Table: silver.crm_sales_details
    Schema: silver
    ===============================================================================
    */
    TRUNCATE TABLE silver.crm_sales_details;
    PRINT 'Inserting Data into silver.crm_sales_details';

    INSERT INTO silver.crm_sales_details (
        sls_ord_num,
        sls_prd_key,
        sls_cust_id,
        sls_order_dt,
        sls_ship_dt,
        sls_due_dt,
        sls_sales,
        sls_quantity,
        sls_price
        )
	    SELECT
        sls_ord_num ,
        sls_prd_key ,
        sls_cust_id ,
            CASE 
                WHEN sls_order_dt = 0 or len(sls_order_dt) != 8 then NULL
                ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
            END AS sls_order_dt,
            CASE 
                WHEN sls_ship_dt = 0 or len(sls_ship_dt) != 8 then NULL
                ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
            END AS sls_ship_dt,
            CASE 
                WHEN sls_due_dt  = 0 or len(sls_due_dt ) != 8 then NULL
                ELSE CAST(CAST(sls_due_dt  AS VARCHAR) AS DATE)
            END AS sls_due_dt  ,
            CASE 
                WHEN sls_sales IS NULL OR sls_sales <= 0 or sls_sales != sls_quantity * abs(sls_price) THEN sls_quantity * abs(sls_price)
                ELSE sls_sales
            END AS sls_sales ,
            sls_quantity,
            CASE 
                WHEN sls_price <= 0 or sls_price IS NULL then sls_sales / NULLIF(sls_quantity,0)
                ELSE sls_price
            END AS sls_price 
        FROM bronze.crm_sales_details


    /*
    ===============================================================================
    Table: silver.erp_CUST_AZ12
    Schema: silver
    ===============================================================================
    */
    TRUNCATE TABLE silver.erp_CUST_AZ12;
    PRINT 'Inserting Data into silver.erp_CUST_AZ12';

    INSERT INTO silver.erp_CUST_AZ12(
        CID,
        BDATE,
        GEN
        )
       SELECT
            CASE 
                WHEN CID LIKE 'NAS%'THEN SUBSTRING(CID,4,LEN(CID))
                ELSE CID
            END AS CID,
            CASE 
                WHEN BDATE > GETDATE() THEN NULL
                ELSE BDATE
            END AS BDATE,
            CASE 
                WHEN UPPER(TRIM(GEN)) IN ('F' ,'FEMALE') THEN 'Female' 
                WHEN UPPER(TRIM(GEN)) IN ('M' ,'MALE') THEN 'Male'
                ELSE 'N/A'
            END AS GEN
        FROM  bronze.erp_CUST_AZ12


    /*
    ===============================================================================
    Table: silver.erp_LOC_A101
    Schema: silver
    ===============================================================================
    */
    TRUNCATE TABLE silver.erp_LOC_A101;
    PRINT 'Inserting Data into silver.erp_LOC_A101';

    INSERT INTO silver.erp_LOC_A101(
			    cid,
			    cntry
		    )
		    SELECT
			    REPLACE(cid, '-', '') AS cid, 
			    CASE
				    WHEN TRIM(cntry) = 'DE' THEN 'Germany'
				    WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
				    WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
				    ELSE TRIM(cntry)
			    END AS cntry 
		    FROM bronze.erp_LOC_A101


    /*
    ===============================================================================
    Table: silver.erp_PX_CAT_G1V2
    Schema: silver
    ===============================================================================
    */
    TRUNCATE TABLE silver.erp_PX_CAT_G1V2;
    PRINT 'Inserting Data into silver.erp_PX_CAT_G1V2';

    INSERT INTO silver.erp_PX_CAT_G1V2(
        ID	,
        CAT	,
        SUBCAT ,
        MAINTENANCE
        )
        Select 
        ID	,
        CAT	,
        SUBCAT ,
        MAINTENANCE 
        From Bronze.erp_PX_CAT_G1V2
END
