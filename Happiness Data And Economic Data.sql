SELECT * 
FROM Portfolio.economy;

SELECT * 
FROM Portfolio.all_years;


-- Regional Summary of Happiness Data
SELECT Region, ROUND(AVG(SCORE),2) as 'Average Score', ROUND(AVG(GDP_Capita), 2) as 'Average GDP Per Capita', ROUND(AVG(Family), 2) AS 'Average Family Score',
ROUND(AVG(Life_Expectancy),2) as 'Average Life Expectancy', ROUND(AVG(Freedom), 2) as 'Average Freedom', ROUND(AVG(Gov_Corruption), 2) as 'Average Government Corruption',
ROUND(AVG(Generosity), 2) as 'Average Generosity'
FROM portfolio.all_years
WHERE Region is NOT NULL
GROUP BY Region
ORDER BY 2 DESC;

-- Regional Summary of Economic Data (Unemployment)
SELECT adminregion, ROUND(AVG(unemployment_percentage), 2) as 'Average Inflation Percentage'
FROM portfolio.economy
WHERE adminregion is NOT NULL
Group by adminregion
ORDER By 1;




-- US Specific Table for economy and happiness data
SELECT *
FROM portfolio.all_years ay
LEFT JOIN portfolio.economy econ
	on ay.Year = econ.year
    and ay.Country = econ.country
WHERE econ.country like '%united states%'
order by 1, 2;

-- Join both tables with matching yearly data
SELECT *
FROM portfolio.all_years ay
LEFT JOIN portfolio.economy econ
	ON ay.Year = econ.year
    and ay.Country = econ.country
ORDER BY 1, 2;

-- Making Views for Tableau --
-- US View
CREATE VIEW portfolio.USSpecificData as 
SELECT ay.Country, ay.Year, ay.Rank, ay.score, ay.GDP_Capita, ay.Family, ay. Life_Expectancy, ay.Freedom, ay.Gov_Corruption, ay.Generosity, 
econ.inflation_percentage, econ.real_interest_rate, econ.deposit_interest_rate, econ.lending_interest_rate, econ.unemployment_percentage, econ.country_code
FROM portfolio.all_years ay
LEFT JOIN portfolio.economy econ
	on ay.Year = econ.year
    and ay.Country = econ.country
WHERE econ.country like '%united states%'
order by 1, 2;


-- Worldwide View
CREATE VIEW portfolio.WorldData2 as
SELECT ay.Country, ay.Year, ay.region, ay.Rank, ay.score, ay.GDP_Capita, ay.Family, ay. Life_Expectancy, ay.Freedom, ay.Gov_Corruption, ay.Generosity, 
econ.inflation_percentage, econ.real_interest_rate, econ.deposit_interest_rate, econ.lending_interest_rate, econ.unemployment_percentage, econ.country_code
FROM portfolio.all_years ay
LEFT JOIN portfolio.economy econ
	on ay.Year = econ.year
    and ay.Country = econ.country
-- WHERE econ.country like '%united states%'
order by 1, 2;


-- Regional Summary Of Happiness Data
CREATE VIEW portfolio.HappinessRegional AS
SELECT Region, ROUND(AVG(SCORE),2) as 'Average Score', ROUND(AVG(GDP_Capita), 2) as 'Average GDP Per Capita', ROUND(AVG(Family), 2) AS 'Average Family Score',
ROUND(AVG(Life_Expectancy),2) as 'Average Life Expectancy', ROUND(AVG(Freedom), 2) as 'Average Freedom', ROUND(AVG(Gov_Corruption), 2) as 'Average Government Corruption',
ROUND(AVG(Generosity), 2) as 'Average Generosity'
FROM portfolio.all_years
WHERE Region is NOT NULL
GROUP BY Region
ORDER BY 2 DESC;