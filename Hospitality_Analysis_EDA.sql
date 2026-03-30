-- Creating the database to use for the project

CREATE DATABASE hospitality_project;

-- Creating a table to set the sturcture for our csv when being loaded

CREATE TABLE hospitality_analysis (
	year INT PRIMARY KEY,
    revenue_index FLOAT,
    vs_base_pct FLOAT,
    hospitality_revenue_m FLOAT,
    revenue_growth_pct FLOAT,
    hospitality_vacancies INT,
    vacancy_pressure_index FLOAT
);

-- Imported the CSV trough the import wizard

-- Checking if population worked and all in order, with simple Select statements
SELECT * FROM hospitality_analysis;
SELECT COUNT(*) FROM hospitality_analysis;

-- First Query calculating the avg value of key variables to see what i compare the findings to

SELECT
	AVG(revenue_index) AS avg_revenue_index,
    AVG(hospitality_vacancies) AS avg_vacancies,
    AVG(vacancy_pressure_index) AS avg_pressure
FROM hospitality_analysis;

-- Creating a case statement to split the data into pre and post covid group to see how the sector changed around the pandemic

SELECT
	CASE
		WHEN year <= 2019 THEN 'Pre-COVID'
        ELSE 'Post-COVID'
	END AS period,
    AVG(revenue_index) AS avg_revenue_index,
    AVG(hospitality_vacancies) AS avg_vacancies,
    AVG(vacancy_pressure_index) AS avg_pressure
FROM hospitality_analysis
GROUP BY period;

-- Creating a query to find the years with highest to lowest pressure index (showing the years with the most severe labour shortages) 

SELECT *
FROM hospitality_analysis
ORDER BY vacancy_pressure_index DESC;

-- Creating a query to observe how vacancies and revenues acted compared to eachoter

SELECT
	year,
    hospitality_revenue_m,
    hospitality_vacancies
FROM hospitality_analysis
ORDER BY year;

-- Creating a window function to compare the vacancy preassure change year by year

SELECT
    year,
    vacancy_pressure_index,
    vacancy_pressure_index
      - LAG(vacancy_pressure_index) OVER (ORDER BY year) AS yearly_change
FROM hospitality_analysis;

-- Creating a simple time series query to see main indicators in chromological order

SELECT
	year,
    revenue_index,
    hospitality_revenue_m,
    hospitality_vacancies,
    vacancy_pressure_index
FROM hospitality_analysis
ORDER BY year;

-- Another query to comapre revenue growth and labour pressure by year

SELECT
	year,
    revenue_growth_pct,
    vacancy_pressure_index
FROM hospitality_analysis
ORDER BY year;
    
