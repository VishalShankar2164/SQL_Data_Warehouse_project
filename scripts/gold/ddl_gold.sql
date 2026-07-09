-- ============================================================================
-- View: gold.dim_customers
-- Description: Customer Dimension
-- ============================================================================

CREATE VIEW gold.dim_customers AS
SELECT 
        ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
        ci.cst_id AS customer_id,
        ci.cst_key AS customer_number,
        ci.cst_firstname first_name,
        ci.cst_lastname last_name,
        la.CNTRY AS country,
        ci.cst_marital_status AS marital_status,
        ca.BDATE AS birth_date,
        CASE 
            WHEN ci.cst_gndr != 'N/A' THEN ci.cst_gndr
            ELSE COALESCE(ca.GEN, 'N/A')
        END AS gender,
        ci.cst_create_date AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_CUST_AZ12 ca
ON          ci.cst_key = ca.cid
LEFT JOIN silver.erp_LOC_A101 la
ON          ci.cst_key = la.CID;


-- ============================================================================
-- View: gold.dim_products
-- Description: Product Dimension
-- ============================================================================

CREATE VIEW gold.dim_products AS
	SELECT
			ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
			pn.prd_id AS product_id,
			pn.prd_key AS product_number,
			pn.prd_nm AS product_name,
			pn.cat_id AS category_id,
			pc.CAT AS category,
			pc.SUBCAT AS sub_category,
			pc.MAINTENANCE AS maintainance,
			pn.prd_line AS product_line,
			pn.prd_cost AS cost,
			pn.prd_start_dt AS start_date
	FROM silver.crm_prd_info pn
	LEFT JOIN silver.erp_PX_CAT_G1V2 pc
	ON		pn.cat_id = pc.id
	WHERE pn.prd_end_dt IS NULL;


-- ============================================================================
-- View: gold.fact_sale
-- Description: Sales Fact Table
-- ============================================================================

CREATE VIEW gold.fact_sale AS
SELECT 
    sd.sls_ord_num AS order_number,
    pr.product_key,
    cu.customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt AS shipping_date,
    sd.sls_due_dt AS due_date,
    sd.sls_sales AS sale,
    sd.sls_quantity AS quantity,
    sd.sls_price AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
ON sd.sls_cust_id = cu.customer_id;
