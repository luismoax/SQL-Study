-- -- SQL Script to create and populate Employees table
-- Create Table Employees
-- (
--     Id int primary key,
--     Name nvarchar(50),
--     Gender nvarchar(10),
--     Salary int,
--     Country nvarchar(10)
-- )
-- Go

-- Insert Into Employees Values (1, 'Mark', 'Male', 5000, 'USA')
-- Insert Into Employees Values (2, 'John', 'Male', 4500, 'India')
-- Insert Into Employees Values (3, 'Pam', 'Female', 5500, 'USA')
-- Insert Into Employees Values (4, 'Sara', 'Female', 4000, 'India')
-- Insert Into Employees Values (5, 'Todd', 'Male', 3500, 'India')
-- Insert Into Employees Values (6, 'Mary', 'Female', 5000, 'UK')
-- Insert Into Employees Values (7, 'Ben', 'Male', 6500, 'UK')
-- Insert Into Employees Values (8, 'Elizabeth', 'Female', 7000, 'USA')
-- Insert Into Employees Values (9, 'Tom', 'Male', 5500, 'UK')
-- Insert Into Employees Values (10, 'Ron', 'Male', 5000, 'USA')
-- Go


------------------------------------------------------------------------------------------------------------
-- Goal: Group By Country and Gender showing totals on the last rows

-- Using Simple Group By
SELECT
    Country,
    Gender,
    SUM(Emp.Salary) AS TotalSalary
FROM
    Employees AS Emp
GROUP BY Emp.Country, Emp.Gender

UNION ALL

SELECT
    Emp.Country,
    NULL AS Gender,
    SUM(Emp.Salary) AS TotalSalary
FROM
    Employees AS Emp
GROUP BY Emp.Country

UNION ALL

SELECT
    NULL AS Country,
    Emp.Gender,
    SUM(Emp.Salary) AS TotalSalary
FROM
    Employees AS Emp
GROUP BY Emp.Gender

UNION ALL

SELECT
    NULL AS Country,
    NULL AS Gender,
    SUM(Emp.Salary)
FROM
    Employees AS Emp


-- There are 2 problems with the above approach.
-- 1. The query is huge as we have combined different Group By queries using UNION ALL operator. This can grow even more if we start to add more groups
-- 2. The Employees table has to be accessed 4 times, once for every query.

-- If we use Grouping Sets feature introduced in SQL Server 2008, the amount of T-SQL code that you have to write will be greatly reduced. 
-- The following Grouping Sets query produce the same result as the above UNION ALL query.

SELECT
    Emp.Country,
    Emp.Gender,
    SUM(Emp.Salary)
FROM
    Employees AS Emp
GROUP BY
    GROUPING SETS
    (
        (Emp.Country,Emp.Gender),   -- Sum of Salary by Country and Gender
        (Emp.Country),              -- Sum of Salary by Country
        (Emp.Gender),               -- Sum of Salary by Gender
        ()                          -- Sum of Salary
    )
ORDER BY GROUPING(Emp.Country), GROUPING(Emp.Gender), Gender DESC

-- This orders the results by the GROUPING function values for Country and Gender. The GROUPING function returns:
-- 0 if the column is part of the grouping level for that row.
-- 1 if the column is aggregated for that row.
-- So, the result will first sort by whether Country is grouped, then by whether Gender is grouped. Rows where Country and Gender are both grouped together (specific country-gender combinations) will appear first. Rows where only one or neither is grouped will appear afterward, based on this hierarchy.

-- the Gender DESC part orders on Gender itself after sorting by GROUPING values. This means:

-- Within the same grouping level (e.g., both Country and Gender are grouped or only one is), 
-- rows will be further ordered by Gender alphabetically or numerically, depending on the data type.