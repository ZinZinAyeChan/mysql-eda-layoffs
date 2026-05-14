USE world_layoffs;

DROP TABLE IF EXISTS layoffs;
CREATE TABLE layoffs (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL
);

select *
from layoffs;

LOAD DATA LOCAL INFILE '/Users/zinzinayechan/Documents/Portfolio/SQL/Project 1 Data Cleaning/layoffs.csv'
INTO TABLE layoffs
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_rows FROM layoffs;
