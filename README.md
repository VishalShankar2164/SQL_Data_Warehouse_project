# 🚀 Modern SQL Data Warehouse Project

An end-to-end SQL Data Warehouse project built using **Microsoft SQL Server**, implementing the **Medallion Architecture (Bronze, Silver, Gold)** to transform raw ERP and CRM data into analytics-ready datasets.

This project demonstrates industry-standard data warehousing concepts including ETL pipelines, data modeling, data cleansing, dimensional modeling, and analytical reporting.

---

## 📌 Project Overview

The objective of this project is to design and implement a scalable SQL Data Warehouse capable of:

- Importing raw data from multiple source systems
- Cleaning and transforming data
- Building dimensional models
- Creating business-friendly analytical datasets
- Generating meaningful business insights

The project follows the **Bronze → Silver → Gold** architecture commonly used in modern data engineering.

---

## 🏗️ Architecture

```
             Source Systems
          (ERP + CRM CSV Files)
                    │
                    ▼
        ┌─────────────────────┐
        │      Bronze Layer    │
        │ Raw Data Ingestion   │
        └─────────────────────┘
                    │
                    ▼
        ┌─────────────────────┐
        │      Silver Layer    │
        │ Data Cleaning & ETL  │
        └─────────────────────┘
                    │
                    ▼
        ┌─────────────────────┐
        │      Gold Layer      │
        │ Analytics & Reporting│
        └─────────────────────┘
```

# 🛠️ Technologies Used

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL
- Git
- GitHub
- Draw.io

---

# 📊 Data Warehouse Layers

## 🥉 Bronze Layer

Purpose:

- Store raw source data
- Preserve original records
- No transformations
- Bulk data loading

Features:

- Raw ERP data
- Raw CRM data
- Bulk Insert
- Initial staging

---

## 🥈 Silver Layer

Purpose:

- Clean data
- Standardize formats
- Remove duplicates
- Handle null values
- Data validation

Transformations include:

- Data cleansing
- Data normalization
- Duplicate removal
- Standardized column names
- Business rule implementation

---

## 🥇 Gold Layer

Purpose:

Business-ready dimensional model for reporting.

Contains:

- Fact tables
- Dimension tables
- Star Schema
- Analytics-ready datasets

---

# ⭐ Features

- End-to-End ETL Pipeline
- Data Warehouse Implementation
- Medallion Architecture
- Star Schema Modeling
- Stored Procedures
- Views
- Data Cleansing
- Data Validation
- Analytical Queries
- SQL Best Practices

---

# 🧠 SQL Concepts Demonstrated

- Joins
- Common Table Expressions (CTEs)
- Window Functions
- Aggregate Functions
- CASE Statements
- Stored Procedures
- Views
- Constraints
- Primary & Foreign Keys
- Surrogate Keys
- ROW_NUMBER()
- LEAD()
- LAG()
- ISNULL()
- Data Type Conversion
- Date Functions

---

# 📈 Business Analysis

The Gold Layer can be used to analyze:

- Customer Performance
- Sales Trends
- Product Performance
- Revenue Analysis
- Customer Demographics
- Product Categories
- Order Analysis










---

# ⭐ If you found this project useful, don't forget to Star the repository!
