-- Create table Sales
-- (
--     Id int primary key identity,
--     Continent nvarchar(50),
--     Country nvarchar(50),
--     City nvarchar(50),
--     SaleAmount int
-- )
-- Go

-- Insert into Sales values('Asia','India','Bangalore',1000)
-- Insert into Sales values('Asia','India','Chennai',2000)
-- Insert into Sales values('Asia','Japan','Tokyo',4000)
-- Insert into Sales values('Asia','Japan','Hiroshima',5000)
-- Insert into Sales values('Europe','United Kingdom','London',1000)
-- Insert into Sales values('Europe','United Kingdom','Manchester',2000)
-- Insert into Sales values('Europe','France','Paris',4000)
-- Insert into Sales values('Europe','France','Cannes',5000)
-- Go

-- Grouping(Column) indicates whether the column in a GROUP BY list is aggregated or not. Grouping returns 1 for aggregated or 0 for not aggregated in the result set.
-- Grouping Functions can be used with ROLLUP, CUBE, and Grouping Sets
-- This is useful when we need to precisely know whether cells are aggregated (amid displaying NULL) or whether they have an actual value NULL.
---------------------------------------------------------------------------------------

-- Grouping Function (1 for aggregated | 0 for not aggregated)
SELECT
    S.Continent,
    S.Country,
    S.City,
    SUM(S.SaleAmount) AS [SalesAmount],
    -- Appliying Grouping Function
    GROUPING(S.Continent) AS GP_Continent,
    GROUPING(S.Country) AS GP_Country,
    GROUPING(S.City) AS GP_City
FROM
    Sales AS S
GROUP BY
    S.Continent,
    S.Country,
    S.City
WITH ROLLUP

------------------------------------------

-- Grouping Function (1 for aggregated | 0 for not aggregated)
-- Use a CASE to display 'ALL' in case the column is aggregated
SELECT
    CASE WHEN GROUPING(S.Continent) = 1 THEN 'All' ELSE S.Continent END AS [Continent],
    CASE WHEN GROUPING(S.Country) = 1 THEN 'All' ELSE S.Country END AS [Country],
    CASE WHEN GROUPING(S.City) = 1 THEN 'All' ELSE S.City END AS [City],
    SUM(S.SaleAmount) AS [SalesAmount],
    -- Appliying Grouping Function
    GROUPING(S.Continent) AS GP_Continent,
    GROUPING(S.Country) AS GP_Country,
    GROUPING(S.City) AS GP_City
FROM
    Sales AS S
GROUP BY
    S.Continent,
    S.Country,
    S.City
WITH ROLLUP

------------------------------------------

-- Let's insert a column containing NULL in the name of the city
-- Insert into Sales values('Asia','Japan',NULL,1000)

------------------------------------------

-- Grouping Function (1 for aggregated | 0 for not aggregated)
-- Use a CASE to display 'ALL' in case the column is aggregated, and use COALESCE to check wether the actual value of the column is NULL.
SELECT
    CASE WHEN GROUPING(S.Continent) = 1 THEN 'All' ELSE COALESCE(S.Continent, 'Unknown') END AS [Continent],
    CASE WHEN GROUPING(S.Country) = 1 THEN 'All' ELSE COALESCE(S.Country, 'Unknown') END AS [Country],
    CASE WHEN GROUPING(S.City) = 1 THEN 'All' ELSE COALESCE(S.City, 'Unknown') END AS [City],
    SUM(S.SaleAmount) AS [SalesAmount],
    -- Appliying Grouping Function
    GROUPING(S.Continent) AS GP_Continent,
    GROUPING(S.Country) AS GP_Country,
    GROUPING(S.City) AS GP_City
FROM
    Sales AS S
GROUP BY
    S.Continent,
    S.Country,
    S.City
WITH ROLLUP
