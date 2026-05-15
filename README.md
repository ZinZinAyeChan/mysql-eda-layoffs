# 🔍 MySQL Data Cleaning & EDA (World Layoffs Dataset)

A MySQL project analysing global tech layoffs through a full data pipeline — from raw data cleaning to exploratory analysis. The dataset covers ~2,361 layoff records across companies, industries, and countries worldwide.

---

## 📊 Dataset

- **Source:** World Layoffs (`layoffs.csv`)
- **Size:** ~2,361 records
- **Columns:** `company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, `funds_raised_millions`

---

## 🧹 Part 1 — Data Cleaning

A structured 4-step cleaning process to transform raw, messy data into an analysis-ready table.

**1. Remove Duplicates**
Used `ROW_NUMBER()` with `PARTITION BY` across all columns to identify and delete exact duplicate rows via a staging table.

**2. Standardise the Data**
- Trimmed extra whitespace from `company`
- Unified inconsistent industry names (e.g. `Crypto Currency` → `Crypto`)
- Removed trailing punctuation from `country` (e.g. `United States.` → `United States`)
- Converted `date` from text to proper `DATE` format using `STR_TO_DATE()`

**3. Handle Null & Blank Values**
- Converted blank strings to `NULL` for consistency
- Used a self-join to fill missing `industry` values where another row for the same company had the value available

**4. Remove Unnecessary Rows & Columns**
- Dropped rows where both `total_laid_off` and `percentage_laid_off` were `NULL`
- Dropped the helper `row_num` column after deduplication

---

## 🔎 Part 2 — Exploratory Data Analysis

Explores layoff patterns across companies, industries, countries, and time periods.

- **Company-level** — top companies by total layoffs; top 5 per year ranked using `DENSE_RANK()`
- **Industry-level** — which industries had the highest total layoffs
- **Country-level** — which countries were most affected
- **Stage-level** — layoffs by company funding stage
- **Time-based** — layoffs by year; monthly totals; rolling cumulative sum using window functions and CTEs
- **100% layoffs** — companies that laid off their entire workforce, sorted by funds raised

---

## 📁 Files

| File | Description |
|---|---|
| `layoffs.csv` | Raw dataset |
| `Importing_Data.sql` | Creates the database and imports the CSV |
| `Project_1_Data_Cleaning.sql` | 4-step data cleaning script |
| `Project_2_Exploratory_Data_Analysis.sql` | Full EDA script |

---

## 🧠 Concepts Demonstrated

- Staging tables for safe data manipulation
- Deduplication with `ROW_NUMBER()` and CTEs
- Data standardisation — `TRIM()`, `STR_TO_DATE()`, `UPDATE`
- Self-joins for imputing missing values
- `ALTER TABLE`, `DROP COLUMN`, `MODIFY COLUMN`
- Aggregations — `SUM()`, `MAX()`, `MIN()`, `GROUP BY`
- Date functions — `YEAR()`, `SUBSTRING()` for month extraction
- Window functions — rolling total with `SUM() OVER(ORDER BY)`
- Ranking — `DENSE_RANK()` partitioned by year
- Multi-step CTEs with `WITH` clauses

---

## 🛠️ Built With

- MySQL
