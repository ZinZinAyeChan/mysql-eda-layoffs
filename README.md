# 🔍 MySQL Exploratory Data Analysis — World Layoffs Dataset

A MySQL EDA project analysing global tech layoffs trends. Built on top of the cleaned dataset from [Project 1](https://github.com/yourusername/mysql-data-cleaning-layoffs), this project explores patterns across companies, industries, countries, and time periods.

---

## 📊 Dataset

- **Source:** World Layoffs (`layoffs.csv`)
- **Size:** ~2,361 records
- **Columns:** `company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, `funds_raised_millions`

---

## 🔎 Analysis Performed

- **Company-level** — top companies by total layoffs; top 5 companies per year ranked by layoffs using `DENSE_RANK()`
- **Industry-level** — which industries had the highest total layoffs
- **Country-level** — which countries were most affected
- **Stage-level** — layoffs by company funding stage
- **Time-based** — layoffs by year; monthly layoff totals; rolling cumulative sum over time using window functions and CTEs
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

- Aggregations — `SUM()`, `MAX()`, `MIN()`, `GROUP BY`
- Date functions — `YEAR()`, `SUBSTRING()` for month extraction
- Window functions — rolling total with `SUM() OVER(ORDER BY)`
- CTEs — multi-step analysis with `WITH` clauses
- Ranking — `DENSE_RANK()` partitioned by year
- Filtering & sorting — `WHERE`, `ORDER BY`, `HAVING`

---

## 🛠️ Built With

- MySQL
