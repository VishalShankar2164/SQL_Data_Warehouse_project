/*
===============================================================================
                            Silver
===============================================================================
Table: crm_cust_info
Schema: silver
===============================================================================

Purpose:
    Stores raw customer information ingested from the CRM source system.
    This table serves as the landing layer for customer master data
    before cleansing and transformation in the Silver layer.

Source:
    CRM System

Notes:
    - Data is loaded in its original format from the source system.
    - Minimal or no transformations should be applied in the silver layer.
    - Data quality validations are performed in the Silver layer.

===============================================================================
*/

-- Drop table if it already exists
IF OBJECT_ID('silver.crm_cust_info','U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;
GO
CREATE TABLE silver.crm_cust_info(
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE,
    dwh_created_date DATETIME2 DEFAULT GETDATE()
);
GO
/*
===============================================================================
Table: crm_prd_info
Schema: silver
===============================================================================

Purpose:
    Stores raw product master data extracted from the CRM source system.

Source:
    CRM System

Notes:
    - Contains product attributes and lifecycle dates.
    - Data is loaded without transformations.
    - Used as input for Silver-layer product dimension processing.

===============================================================================
*/
IF OBJECT_ID('silver.crm_prd_info','U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;
GO
CREATE TABLE silver.crm_prd_info(
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE,
    dwh_created_date DATETIME2 DEFAULT GETDATE()
);
GO
/*
===============================================================================
Table: crm_sales_details
Schema: silver
===============================================================================

Purpose:
    Stores raw sales transaction data extracted from the CRM source system.

Source:
    CRM System

Notes:
    - Contains order, shipment, due date, quantity, and sales information.
    - Data is loaded in its original format from the source.
    - Serves as the foundation for sales fact table creation.

===============================================================================
*/
IF OBJECT_ID('silver.crm_sales_details','U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;
GO
CREATE TABLE silver.crm_sales_details(
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT,
    dwh_created_date DATETIME2 DEFAULT GETDATE()
);
GO
/*
===============================================================================
                            ERP SOURCE TABLES
===============================================================================
===============================================================================
Table: erp_LOC_A101
Schema: silver
===============================================================================

Purpose:
    Stores customer location information extracted from the ERP system.

Source:
    ERP System

Notes:
    - Maps customer identifiers to country information.
    - Loaded without modification from the source system.
    - Used for customer geography enrichment in downstream layers.

===============================================================================
*/
IF OBJECT_ID('silver.erp_LOC_A101','U') IS NOT NULL
    DROP TABLE silver.erp_LOC_A101;
GO
CREATE TABLE silver.erp_LOC_A101(
    CID NVARCHAR(50),
    CNTRY NVARCHAR(50),
    dwh_created_date DATETIME2 DEFAULT GETDATE()
);
GO
/*
===============================================================================
Table: erp_CUST_AZ12
Schema: silver
===============================================================================

Purpose:
    Stores customer demographic information extracted from the ERP system.

Source:
    ERP System

Notes:
    - Contains birth date and gender attributes.
    - Used to enrich customer master records.
    - Data quality validation occurs in the Silver layer.

===============================================================================
*/
IF OBJECT_ID('silver.erp_CUST_AZ12','U') IS NOT NULL
    DROP TABLE silver.erp_CUST_AZ12;
GO
CREATE TABLE silver.erp_CUST_AZ12(
    CID	NVARCHAR(50),
    BDATE DATE,
    GEN NVARCHAR(50),
    dwh_created_date DATETIME2 DEFAULT GETDATE()
);
GO
/*
===============================================================================
Table: erp_PX_CAT_G1V2
Schema: silver
===============================================================================

Purpose:
    Stores product category and maintenance hierarchy data extracted
    from the ERP system.

Source:
    ERP System

Notes:
    - Provides category and subcategory classifications.
    - Used to enrich product master data.
    - Loaded as received from the source system.

===============================================================================
*/
IF OBJECT_ID('silver.erp_PX_CAT_G1V2','U') IS NOT NULL
    DROP TABLE silver.erp_PX_CAT_G1V2;
GO
CREATE TABLE silver.erp_PX_CAT_G1V2(
    ID	NVARCHAR(50),
    CAT	NVARCHAR(50),
    SUBCAT NVARCHAR(50),
    MAINTENANCE NVARCHAR(50),
    dwh_created_date DATETIME2 DEFAULT GETDATE()
);
GO
