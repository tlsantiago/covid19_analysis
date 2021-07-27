-- First, taking a glimpse of what's the structure and how the database looks

SELECT
*
FROM
covid19.dbo.worldData


-- Selecting columns to start with


SELECT 
Continent, Location, date, 
total_cases, new_cases, total_deaths, 
new_deaths, new_vaccinations, people_fully_vaccinated, 
stringency_index, population, median_age, 
gdp_per_capita, human_development_index,extreme_poverty, cardiovasc_death_rate, 
diabetes_prevalence, female_smokers, male_smokers


FROM covid19.dbo.worldData
ORDER BY 1, 2


-- Percentage of population infected daily


SELECT Location, date, Population, total_cases, cast((total_cases/population)*100 as decimal(10,3)) as InfectedPercentage
FROM covid19.dbo.worldData
ORDER BY 1, 2


-- Percentage of deaths by population daily


SELECT Location, date, Population, total_deaths, cast((total_deaths/population)*100 as decimal(10,3)) as DeathPercentage
FROM covid19.dbo.worldData
ORDER BY 1, 2


-- Likelihood of dying daily


SELECT Location, date, total_cases, total_deaths, cast((total_deaths/total_cases)*100 as decimal(10,3)) as DeathPercentage
FROM covid19.dbo.worldData
ORDER BY 1, 2


-- Countries with highest infection rate compared to population


SELECT Location, Population, MAX(total_cases) as HighestInfectionCount, cast(MAX((total_cases/population))*100 as decimal(10,3)) as InfectionPercentage
FROM covid19.dbo.worldData
GROUP BY Location, Population
ORDER BY InfectionPercentage desc


-- Countries with highest death percentage compared to population, excluding continent sum


SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount, MAX(cast(Population as float)) as TotalPopulation,
	   cast((MAX(cast(total_deaths as int)) /  MAX(cast(Population as float)))*100 as decimal(10,3))as TotalDeathPercentage

FROM covid19.dbo.worldData
WHERE 
	(continent is not null AND location <> 'World') AND
	(continent is not null AND location <> 'South America') AND
	(continent is not null AND location <> 'North America') AND
	(continent is not null AND location <> 'Asia') AND
	(continent is not null AND location <> 'European Union') AND
	(continent is not null AND location <> 'Europe')

GROUP BY location
ORDER BY TotalDeathPercentage desc


-- Stringency index compared to infection rate


SELECT location,
	   MAX(cast(total_cases as int)) as TotalCasesCount, 
	   MAX(cast(Population as float)) as TotalPopulation,
	   cast((MAX(cast(total_cases as int)) /  MAX(cast(Population as float)))*100 as decimal(10,3))as TotalInfectionPercentage,
	    MAX(cast(stringency_index as float)) as StringencyIndexMax


FROM covid19.dbo.worldData
WHERE 
	(continent is not null AND location <> 'World') AND
	(continent is not null AND location <> 'South America') AND
	(continent is not null AND location <> 'North America') AND
	(continent is not null AND location <> 'Asia') AND
	(continent is not null AND location <> 'European Union') AND
	(continent is not null AND location <> 'Europe')

GROUP BY location
ORDER BY StringencyIndexMax desc


-- Death percentage compared to median age


SELECT location, 
		MAX(cast(total_deaths as int)) as TotalDeathCount, 
		MAX(cast(Population as float)) as TotalPopulation,
	    cast((MAX(cast(total_deaths as int)) /  MAX(cast(Population as float)))*100 as decimal(10,3))as TotalDeathPercentage,
	    cast((MAX(cast(total_deaths as int)) /  MAX(cast(total_cases as float)))*100 as decimal(10,3)) as TotalDeathLikelihood,
	    MAX(cast(median_age as float)) as MedianAge

FROM covid19.dbo.worldData
WHERE 
	(continent is not null AND location <> 'World') AND
	(continent is not null AND location <> 'South America') AND
	(continent is not null AND location <> 'North America') AND
	(continent is not null AND location <> 'Asia') AND
	(continent is not null AND location <> 'European Union') AND
	(continent is not null AND location <> 'Europe')

GROUP BY location
ORDER BY TotalDeathLikelihood desc


-- Death percentage compared to HDI, GDP and extreme poverty


SELECT location, 
		MAX(cast(total_deaths as int)) as TotalDeathCount, 
		MAX(cast(Population as float)) as TotalPopulation,
	    cast((MAX(cast(total_deaths as int)) /  MAX(cast(Population as float)))*100 as decimal(10,3))as TotalDeathPercentage,
	    cast((MAX(cast(total_deaths as int)) /  MAX(cast(total_cases as float)))*100 as decimal(10,3)) as TotalDeathLikelihood,
		MAX(cast(median_age as float)) as MedianAge,
		MAX(cast(gdp_per_capita as float)) as PerCapitaGDP,
		MAX(cast(human_development_index as float)) as HDI,
		MAX(extreme_poverty) as ExtremePoverty

FROM covid19.dbo.worldData
WHERE 
	(continent is not null AND location <> 'World') AND
	(continent is not null AND location <> 'South America') AND
	(continent is not null AND location <> 'North America') AND
	(continent is not null AND location <> 'Asia') AND
	(continent is not null AND location <> 'European Union') AND
	(continent is not null AND location <> 'Europe')

GROUP BY location
ORDER BY TotalDeathLikelihood desc


-- Death percentage compared to risk factors


SELECT location, 
		MAX(cast(total_deaths as int)) as TotalDeathCount, 
		MAX(cast(Population as float)) as TotalPopulation,
	    cast((MAX(cast(total_deaths as int)) /  MAX(cast(Population as float)))*100 as decimal(10,3))as TotalDeathPercentage,
	    cast((MAX(cast(total_deaths as int)) /  MAX(cast(total_cases as float)))*100 as decimal(10,3)) as TotalDeathLikelihood,
		MAX(cast(median_age as float)) as MedianAge,
		MAX(cast(cardiovasc_death_rate as float)) as CardiovascDeathRate,
		MAX(cast(diabetes_prevalence as float)) as DiabetesPrevalence,
		MAX(female_smokers) as FemaleSmokers,
		MAX(male_smokers) as MaleSmokers


FROM covid19.dbo.worldData
WHERE 
	(continent is not null AND location <> 'World') AND
	(continent is not null AND location <> 'South America') AND
	(continent is not null AND location <> 'North America') AND
	(continent is not null AND location <> 'Asia') AND
	(continent is not null AND location <> 'European Union') AND
	(continent is not null AND location <> 'Europe')

GROUP BY location
ORDER BY TotalDeathLikelihood desc


-- South America Evaluation


SELECT location,
	   MAX(cast(Population as float)) as TotalPopulation,
	   MAX(cast(total_cases as int)) as TotalCasesCount, 	
	   cast((MAX(cast(total_cases as int)) /  MAX(cast(Population as float)))*100 as decimal(10,3))as TotalInfectionPercentage,
	   MAX(cast(total_deaths as int)) as TotalDeathCount,
	   cast((MAX(cast(total_deaths as int)) / MAX(cast(Population as float)))*100 as decimal(10,3)) as TotalDeathPercentage,
	   MAX(cast(people_fully_vaccinated as float)) as FullyVaccinatedPopulaton,
	   MAX(cast(stringency_index as float)) as StringencyIndexMax,
	   median_age, gdp_per_capita, human_development_index, extreme_poverty,
	   cast((MAX(cast(total_deaths as float)) / MAX(cast(total_cases as float)))*100 as decimal(10,3)) as DeathLikelyhood


FROM covid19.dbo.worldData

WHERE 
	(continent = 'South America' AND location <> 'World')

GROUP BY location, median_age, gdp_per_capita, human_development_index, extreme_poverty
ORDER BY DeathLikelyhood desc


-- North America Evaluation


SELECT location,
	   MAX(cast(Population as float)) as TotalPopulation,
	   MAX(cast(total_cases as int)) as TotalCasesCount, 	
	   cast((MAX(cast(total_cases as int)) /  MAX(cast(Population as float)))*100 as decimal(10,3))as TotalInfectionPercentage,
	   MAX(cast(total_deaths as int)) as TotalDeathCount,
	   cast((MAX(cast(total_deaths as int)) / MAX(cast(Population as float)))*100 as decimal(10,3)) as TotalDeathPercentage,
	   MAX(cast(stringency_index as float)) as StringencyIndexMax,
	   MAX(cast(people_fully_vaccinated as float)) as FullyVaccinatedPopulaton,
	   median_age, gdp_per_capita, human_development_index, extreme_poverty,
	   cast((MAX(cast(total_deaths as float)) / MAX(cast(total_cases as float)))*100 as decimal(10,3)) as DeathLikelyhood


FROM covid19.dbo.worldData

WHERE 
	(continent = 'North America' AND location <> 'World') OR location = 'Brazil'

GROUP BY location, median_age, gdp_per_capita, human_development_index, extreme_poverty
ORDER BY DeathLikelyhood desc


-- Europe Evaluation


SELECT location,
	   MAX(cast(Population as float)) as TotalPopulation,
	   MAX(cast(total_cases as int)) as TotalCasesCount, 	
	   cast((MAX(cast(total_cases as int)) /  MAX(cast(Population as float)))*100 as decimal(10,3))as TotalInfectionPercentage,
	   MAX(cast(total_deaths as int)) as TotalDeathCount,
	   cast((MAX(cast(total_deaths as int)) / MAX(cast(Population as float)))*100 as decimal(10,3)) as TotalDeathPercentage,
	   MAX(cast(stringency_index as float)) as StringencyIndexMax,
	   MAX(cast(people_fully_vaccinated as float)) as FullyVaccinatedPopulaton,
	   median_age, gdp_per_capita, human_development_index, extreme_poverty,
	   cast((MAX(cast(total_deaths as float)) / MAX(cast(total_cases as float)))*100 as decimal(10,3)) as DeathLikelyhood


FROM covid19.dbo.worldData

WHERE 
	(continent = 'Europe' AND location <> 'World') OR location = 'Brazil'

GROUP BY location, median_age, gdp_per_capita, human_development_index, extreme_poverty
ORDER BY DeathLikelyhood desc


-- Asia Evaluation


SELECT location,
	   MAX(cast(Population as float)) as TotalPopulation,
	   MAX(cast(total_cases as int)) as TotalCasesCount, 	
	   cast((MAX(cast(total_cases as int)) /  MAX(cast(Population as float)))*100 as decimal(10,3))as TotalInfectionPercentage,
	   MAX(cast(total_deaths as int)) as TotalDeathCount,
	   cast((MAX(cast(total_deaths as int)) / MAX(cast(Population as float)))*100 as decimal(10,3)) as TotalDeathPercentage,
	   MAX(cast(stringency_index as float)) as StringencyIndexMax,
	   MAX(cast(people_fully_vaccinated as float)) as FullyVaccinatedPopulaton,
	   median_age, gdp_per_capita, human_development_index, extreme_poverty,
	   cast((MAX(cast(total_deaths as float)) / MAX(cast(total_cases as float)))*100 as decimal(10,3)) as DeathLikelyhood

FROM covid19.dbo.worldData

WHERE 
	(continent = 'Asia' AND location <> 'World') OR location = 'Brazil'

GROUP BY location, median_age, gdp_per_capita, human_development_index, extreme_poverty
ORDER BY DeathLikelyhood desc


-- Africa Evaluation


SELECT location,
	   MAX(cast(Population as float)) as TotalPopulation,
	   MAX(cast(total_cases as int)) as TotalCasesCount, 	
	   cast((MAX(cast(total_cases as int)) /  MAX(cast(Population as float)))*100 as decimal(10,3))as TotalInfectionPercentage,
	   MAX(cast(total_deaths as int)) as TotalDeathCount,
	   cast((MAX(cast(total_deaths as int)) / MAX(cast(Population as float)))*100 as decimal(10,3)) as TotalDeathPercentage,
	   MAX(cast(stringency_index as float)) as StringencyIndexMax,
	   MAX(cast(people_fully_vaccinated as float)) as FullyVaccinatedPopulaton,
	   median_age, gdp_per_capita, human_development_index, extreme_poverty,
	   cast((MAX(cast(total_deaths as float)) / MAX(cast(total_cases as float)))*100 as decimal(10,3)) as DeathLikelyhood


FROM covid19.dbo.worldData

WHERE 
	(continent = 'Africa' AND location <> 'World') OR location = 'Brazil'

GROUP BY location, median_age, gdp_per_capita, human_development_index, extreme_poverty
ORDER BY DeathLikelyhood desc


-- Oceania Evaluation


SELECT location,
	   MAX(cast(Population as float)) as TotalPopulation,
	   MAX(cast(total_cases as int)) as TotalCasesCount, 	
	   cast((MAX(cast(total_cases as int)) /  MAX(cast(Population as float)))*100 as decimal(10,3))as TotalInfectionPercentage,
	   MAX(cast(total_deaths as int)) as TotalDeathCount,
	   cast((MAX(cast(total_deaths as int)) / MAX(cast(Population as float)))*100 as decimal(10,3)) as TotalDeathPercentage,
	   MAX(cast(stringency_index as float)) as StringencyIndexMax,
	   MAX(cast(people_fully_vaccinated as float)) as FullyVaccinatedPopulaton,
	   median_age, gdp_per_capita, human_development_index, extreme_poverty,
	   cast((MAX(cast(total_deaths as float)) / MAX(cast(total_cases as float)))*100 as decimal(10,3)) as DeathLikelyhood


FROM covid19.dbo.worldData

WHERE 
	(continent = 'Oceania' AND location <> 'World') OR location = 'Brazil'

GROUP BY location, median_age, gdp_per_capita, human_development_index, extreme_poverty
ORDER BY DeathLikelyhood desc