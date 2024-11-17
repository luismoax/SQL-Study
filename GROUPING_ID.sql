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

------------------------------------------------------------------------------------------------------------
-- GROUPING_ID() function concatenates all the GOUPING() functions, perform the binary to decimal conversion, 
-- and returns the equivalent integer. In short
-- GROUPING_ID(A, B, C) =  GROUPING(A) + GROUPING(B) + GROUPING(C). The values of GROUPING_ID(A, B, C) is the 
-- integer representation of the bitmask obtained after concatenating the columbs A, B, and C.


-- Using GROUPING_ID with a ROLL UP Query
SELECT
    S.Continent,
    S.Country,
    S.City,
    SUM(SaleAmount) AS [SalesAmount],
    -- Groupings
    GROUPING(S.Continent) AS [GP_Continent],
    GROUPING(S.Country) AS [GP_Country],
    GROUPING(S.City) AS [GP_City],
    -- Concatenation of the Grouping Function applied to each column in the GROUP BY
    CAST(GROUPING(S.Continent) AS VARCHAR(1)) + CAST(GROUPING(S.Country) AS VARCHAR(1)) + CAST(GROUPING(S.City) AS VARCHAR(1)) AS [BinaryRepresentation],
    -- GROUPING_ID returns the integer representation of the concatenation of the Grouping Function applied to each column in the GROUP BY
    GROUPING_ID(S.Continent, S.Country, S.City) AS [IntegerRepresentation]
FROM
    Sales AS S
GROUP BY
    S.Continent,
    S.Country,
    S.City
WITH ROLLUP

------------------------------------------------------------------------------------------------------------

-- Using GROUPING_ID with a CUBE Query
SELECT
    S.Continent,
    S.Country,
    S.City,
    SUM(SaleAmount) AS [SalesAmount],
    -- Groupings
    GROUPING(S.Continent) AS [GP_Continent],
    GROUPING(S.Country) AS [GP_Country],
    GROUPING(S.City) AS [GP_City],
    -- Concatenation of the Grouping Function applied to each column in the GROUP BY
    CAST(GROUPING(S.Continent) AS VARCHAR(1)) + CAST(GROUPING(S.Country) AS VARCHAR(1)) + CAST(GROUPING(S.City) AS VARCHAR(1)) AS [BinaryRepresentation],
    -- GROUPING_ID returns the integer representation of the concatenation of the Grouping Function applied to each column in the GROUP BY
    GROUPING_ID(S.Continent, S.Country, S.City) AS [IntegerRepresentation]
FROM
    Sales AS S
GROUP BY
    S.Continent,
    S.Country,
    S.City
WITH CUBE

-- Use of GROUPING_ID function : GROUPING_ID function is very handy if you want to sort and filter by level of grouping.
-- For instance

SELECT
    S.Continent,
    S.Country,
    S.City,
    SUM(SaleAmount) AS [SalesAmount],
    -- GROUPING_ID
    GROUPING_ID(S.Continent, S.Country, S.City) AS [IntegerRepresentation]
FROM
    Sales AS S
GROUP BY
    S.Continent,
    S.Country,
    S.City
WITH ROLLUP
-- Filter Only the Second Level Aggregations
HAVING GROUPING_ID(S.Continent, S.Country, S.City) = 3