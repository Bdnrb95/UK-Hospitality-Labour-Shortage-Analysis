# UK Hospitality Labour Shortage Analysis (2008–2024)

## Project Overview

This project analyses labour shortages in the UK hospitality sector between 2008 and 2024 by comparing workforce availability with sector revenue performance before, during, and after COVID-19.

The analysis uses multiple public datasets and introduces a custom **Vacancy Pressure Index** to measure staffing demand relative to industry size rather than vacancy counts alone.

The goal of this project was to determine whether labour shortages represented a temporary disruption caused by pandemic restrictions or a structural workforce shift affecting long-term sector performance.

The workflow demonstrates a full analytics pipeline using:

- Excel (data cleaning & transformation)
- MySQL (exploratory data analysis)
- Power BI (dashboard modelling)
- Tableau (interactive visualisation)



## Project Objectives

This analysis was created to answer the following questions:

- How did hospitality revenue change during and after COVID-19?
- Did workforce availability recover at the same pace as sector performance?
- When did labour shortages become most severe?
- Were staffing shortages temporary or structural?
- What patterns can be observed for the sector moving forward?

## Project Motivation

Having worked in Hospitality in the past 10 years, I wanted to investigate whether workforce shortages observed across the sector after COVID-19 reflected short-term disruption or longer-term labour market change.

This project combines domain experience with technical analysis to explore structural staffing pressure across a 17-year time period.

## Data Sources

Three publicly available UK datasets were combined:

Revenue Index:             Sector performance relative to baseline level (index = 100)
Hospitality Revenue:       Accommodation + food & beverage services revenue (£ millions)
Vacancy Data :             Workforce shortages across hospitality sector

Coverage period: 2008 - 2024


##  Data Cleaning (Excel)

Initial preprocessing and transformation were completed in Excel.

### Dataset 1 — Revenue Index

This dataset measures sector performance relative to a baseline value of 100.

Cleaning steps:

- Filtered years between 2008 and 2024
- Retained revenue index column only
- Created comparison column: Index_vs_Base
- This measures percentage deviation from baseline revenue levels.

- Created additional column: Year_to_Year
- To measure change in sector perfomance

### Dataset 2 — Hospitality Revenue

Accommodation services and food & beverage services were extracted from a large services dataset.

Cleaning steps:

- Selected relevant sector categories
- Filtered analysis period
- Calculated: Total_Revenue, Revenue_Growth_Pct
- These variables track sector expansion and contraction across years

### Dataset 3 — Hospitality Vacancies

The vacancy dataset required restructuring due to its reporting period format.

Cleaning steps:

- Extracted hospitality vacancy values
- Converted reporting periods into numeric year format
- Standardised vacancy values
- Created pivot table showing: Average vacancies per year
- This enabled consistent yearly comparison with revenue indicators

## Master Dataset Construction

The cleaned datasets were merged into a single analytical table using Excel **XLOOKUP**.

Final dataset structure:
- year
- revenue_index
- vs_base_pct
- hospitality_revenue_m
- revenue_growth_pct
- hospitality_vacancies
- vacancy_pressure_index

Custom metric created: Vacancy Pressure Index = Vacancies / Revenue
This metric measures labour demand relative to sector size rather than absolute vacancy counts.

## Exploratory Data Analysis (SQL)

SQL was used to investigate structural changes in labour pressure across time.

Each query answered a specific analytical question about sector behaviour.

### Dataset Validation

SELECT * FROM hospitality_analysis;
- Used to confirm dataset import accuracy and column alignment.

SELECT COUNT(*) FROM hospitality_analysis;
- Confirmed expected number of yearly observations: 17 rows (2008–2024)

SELECT
AVG(revenue_index) AS avg_revenue_index,
AVG(hospitality_vacancies) AS avg_vacancies,
AVG(vacancy_pressure_index) AS avg_pressure
FROM hospitality_analysis;
- Established long-term averages for:
- revenue performance
- workforce shortages
- labour pressure

- These provide context for identifying abnormal years.

SELECT
CASE
WHEN year <= 2019 THEN 'Pre-COVID'
ELSE 'Post-COVID'
END AS period,
AVG(hospitality_vacancies),
AVG(hospitality_revenue_m),
AVG(vacancy_pressure_index)
FROM hospitality_analysis
GROUP BY period;
- Tested whether labour shortages persisted after reopening.
- Result: Vacancy pressure remained structurally higher after COVID-19.

SELECT *
FROM hospitality_analysis
ORDER BY vacancy_pressure_index DESC
LIMIT 1;
- Identified the year of highest staffing strain relative to sector size.
- Peak pressure occurred during recovery rather than lockdown.

SELECT
year,
hospitality_revenue_m,
hospitality_vacancies
FROM hospitality_analysis
ORDER BY year
- Compared sector performance with workforce availability across time.
- Result: Revenue recovered faster than labour supply.

SELECT
year,
vacancy_pressure_index,
vacancy_pressure_index -
LAG(vacancy_pressure_index)
OVER (ORDER BY year) AS yearly_change
FROM hospitality_analysis;
- Detected sudden increases in labour pressure during reopening phases

## Power BI Dashboard
The Power BI dashboard presents sector trends through KPI indicators and time-series comparisons

Dashboard features:

- Vacancy pressure trend by year
- Revenue vs vacancy comparison
- Pre- vs post-COVID segmentation
- KPI indicators
- COVID phase labour pressure comparison

![Power BI Dashboard](Power%20BI%20SSH.png)

## Tableau Interactive Dashboard
The Tableau dashboard extends the analysis with interactive filtering and structural segmentation.

Features include:
- Interactive year filtering
- Workforce vs revenue comparison
- Vacancy pressure trend analysis
- COVID phase comparison
- Peak labour demand indicators

Click the image below to open the live interactive dashboard:

[![Tableau Dashboard](Tableau%20SSH.png)](https://public.tableau.com/app/profile/bence.bodnar/viz/Hospitality_Project_17748823376360/Dashboard1)

## Key Findings

The analysis identified several structural labour market patterns.

1. Revenue collapsed during lockdown

- Hospitality performance dropped sharply during 2020 restrictions.

2. Revenue recovered rapidly after reopening

- By 2022 the sector exceeded pre-pandemic revenue levels.

3. Workforce availability did not recover at the same pace

- Vacancy demand increased significantly during reopening.

4. Labour shortages peaked during recovery rather than lockdown

- This suggests structural workforce supply constraints rather than temporary disruption.

5. Vacancy pressure stabilised after 2023

- This likely reflects sector contraction rather than full workforce recovery.

## Tools Used

Excel      	Data cleaning & dataset integration
MySQL      	Exploratory analysis
Power BI  	Dashboard modelling
Tableau    	Interactive analytics
GitHub    	Documentation & version control

## Conclusion
Hospitality revenue recovered strongly after COVID-19, but workforce availability did not recover at the same pace.

Labour shortages peaked during the recovery phase rather than during lockdown itself, indicating a structural workforce constraint across the sector rather than a short-term disruption.



