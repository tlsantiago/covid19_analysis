SELECT *

FROM covid19.dbo.worldDataHDI

ORDER BY location asc


-- Several empty rolls were added when we exported the excel file

DELETE FROM covid19.dbo.worldDataHDI
WHERE location is NULL

-- Evaluating different HDI performances
-- Low HDI

SELECT * FROM (
SELECT Top 5 *
FROM covid19.dbo.worldDataHDI
WHERE HDI_tier = 'Low Human Development'
ORDER BY DeathLikelyhood asc ) as A

UNION

SELECT * FROM (SELECT Top 5 *
FROM covid19.dbo.worldDataHDI
WHERE HDI_tier = 'Low Human Development'
ORDER BY DeathLikelyhood desc) as B

-- Medium HDI

SELECT * FROM (
SELECT Top 5 *
FROM covid19.dbo.worldDataHDI
WHERE HDI_tier = 'Medium Human Development'
ORDER BY DeathLikelyhood asc ) as A

UNION

SELECT * FROM (SELECT Top 5 *
FROM covid19.dbo.worldDataHDI
WHERE HDI_tier = 'Medium Human Development'
ORDER BY DeathLikelyhood desc) as B

-- High HDI

SELECT * FROM (
SELECT Top 5 *
FROM covid19.dbo.worldDataHDI
WHERE HDI_tier = 'High Human Development'
ORDER BY DeathLikelyhood asc ) as A

UNION

SELECT * FROM (SELECT Top 5 *
FROM covid19.dbo.worldDataHDI
WHERE HDI_tier = 'High Human Development'
ORDER BY DeathLikelyhood desc) as B

-- Very High HDI

SELECT * FROM (
SELECT Top 5 *
FROM covid19.dbo.worldDataHDI
WHERE HDI_tier = 'Very High Human Development'
ORDER BY DeathLikelyhood asc ) as A

UNION

SELECT * FROM (SELECT Top 5 *
FROM covid19.dbo.worldDataHDI
WHERE HDI_tier = 'Very High Human Development'
ORDER BY DeathLikelyhood desc) as B