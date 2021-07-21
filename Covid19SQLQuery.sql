-- First, taking a glimpse of what's the structure and how the database looks

SELECT
*
FROM
covid19.dbo.worldData


-- Selecting columns to start with


SELECT 
Continent, Location, date, 
total_cases, new_cases, total_deaths, 
new_deaths, new_tests, total_tests, tests_per_case
total_vaccinations, people_fully_vaccinated, stringency_index, 
population, median_age, gdp_per_capita,
hospital_beds_per_thousand, human_development_index,
extreme_poverty, cardiovasc_death_rate, diabetes_prevalence,
female_smokers, male_smokers

FROM covid19.dbo.worldData
ORDER BY 1, 2

