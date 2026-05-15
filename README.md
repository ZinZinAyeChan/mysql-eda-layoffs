# 🔍 MySQL Exploratory Data Analysis ( World Layoffs Dataset )

A MySQL EDA project analysing global tech layoff trends. Built on top of the cleaned dataset from Project 1 - Data Cleaning, this project explores patterns across companies, industries, countries, and time periods.

---

## 📊 Dataset

- **Source:** World Layoffs (`layoffs.csv`)
- **Size:** ~2,361 records
- **Columns:** `company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, `funds_raised_millions`

---

## 🔎 Analysis Performed

**Company-level**
- Top companies by total layoffs overall and ranked by year using `DENSE_RANK()`
- Companies that laid off 100% of their workforce, sorted by funds raised

**Industry & Country-level**
- Industries and countries with the highest total layoffs

**Stage-level**
- Layoffs broken down by company funding stage

**Time-based**
- Layoffs by year and by month
- Rolling cumulative sum of layoffs over time using window functions and CTEs

---

## 📁 Files

```
/layoffs.csv                                    # Raw dataset
/Importing_Data.sql                             # Creates the database and imports the CSV
/Project_1_Data_Cleaning.sql                    # 4-step data cleaning script
/Project_2_Exploratory_Data_Analysis.sql        # Full EDA script
/README.md
```

---

## 🧠 Concepts Demonstrated

- Aggregations — `SUM()`, `MAX()`, `MIN()`, `GROUP BY`
- Date functions — `YEAR()`, `SUBSTRING()` for month extraction
- Window functions — rolling total with `SUM() OVER(ORDER BY)`
- Ranking — `DENSE_RANK()` partitioned by year
- Multi-step CTEs with `WITH` clauses
- Filtering & sorting — `WHERE`, `ORDER BY`, `HAVING`

---

## 🛠️ Built With

- MySQL

---

## 👤 Author

**Zin Zin Aye Chan**  
[LinkedIn](https://linkedin.com/in/yourprofile) · [GitHub](https://github.com/yourusername)
