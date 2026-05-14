-- Data Cleaning

SELECT *
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or blank values
-- 4. Remove Any Columns or Rows

-- 1. Remove Duplicates --

CREATE TABLE layoffs_staging
LIKE layoffs;
# making a copy of original table, so you can go back if you make any mistake

SELECT *
FROM layoffs_staging;
# only has column names

INSERT layoffs_staging
SELECT *
FROM layoffs;
# copying the data from layoffs

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging;
# fiinding out the duplicate rows, all no.2 are duplicates

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;
# just filter out the duplicate rows, which is no.2

SELECT *
FROM layoffs_staging
WHERE company = 'Casper';
# when u check, u realise some rows are not duplicates, just have the same name
# correction: in PARTITION BY, make sure you select all columns

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
DELETE 
FROM duplicate_cte
WHERE row_num > 1;
# Found out cannot just delete simply
# so we will create a new table and filter(delete)

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;
# only has column names

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging;
# copying the data from layoffs_staging

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2;

-- 2. Standardize the Data --

SELECT company, TRIM(company)
FROM layoffs_staging2;
# removing extra spaces from company

UPDATE layoffs_staging2
SET company = TRIM(company);
# updating the column

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;
# here, go through everything and check which one need to be changed
# here, crypto has different names

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';
# checking which one is the majority among 3 different names

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2;
# double checking if it was updated

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;
# here, US has two names, US and US.

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;
# removing the .

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'UNITED STATES%';
# two US combine together

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;
# changing date to right format
# %m/%d/%Y = format, Y has to be upper case

UPDATE layoffs_staging2
SET date = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;
# fixed

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;
# only do this on staging table

-- 3. Null Values or blank values --

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';
# (1) check industry if there's null or blank values
# suggestion is to fill the blanks with null to make the process easier

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';
# (4) fill the blank with null 

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';
# (2) industry is blank here, we will try to fill
# here, airbnb first line is null but second line has 'travel' for industry
# we will try to copy 'travel' and fill the null

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    # AND t1.location = t2.location (to make sure companies are in the same location)
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;
# (3) (5) connect the same table
# if it is blank, update with non-blank one e.g. if 'null', update with 'travel'
# 1. join the same table
# 2. make sure the company names are the same
# 3. WHERE: t1 shows first line with null, t2 shows second line with 'travel'
# we will copy 'travel' from t2 to fill in t1

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;
# (6) SET: filling the null to available industry e.g 'travel'

SELECT *
FROM layoffs_staging2;
# the rest of null, impossible to fill
# only if there's smth to calculate or smth to match, we can fill
# here we cannot

-- 4. Remove Any Columns or Rows --

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off	IS NULL;
# null for both, so it is useless, can consider to remove the rows, it's your call

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off	IS NULL;
# here, we'll delete

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;
# we don't need so we drop


