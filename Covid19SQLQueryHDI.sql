SELECT *

FROM covid19.dbo.worldDataHDI

ORDER BY location asc


-- Several empty rolls were added when we exported the excel file

DELETE FROM covid19.dbo.worldDataHDI
WHERE location is NULL

-- Evaluating different HDI performances
