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

-- NOTE: By default, ROLLUP operates in a hierarchical or nested way, meaning it calculates subtotals by reducing each level from right to left in the GROUP BY clause. 
-- In other words, ROLLUP(Region, Product) generates subtotals by Region first, then a grand total across all regions and products.
------------------------------------------------------------------------------------------------------------
-- Goal: Retrieve Salary by country along with grand total

-- Usin GROUP BY and UNION ALL
SELECT
    Emp.Country,
    SUM(Emp.Salary)
FROM
    Employees AS Emp
GROUP BY
    Emp.Country

UNION ALL

SELECT
    NULL AS Country,
    SUM(Emp.Salary)
FROM
    Employees AS Emp


-- Using Roll Up 1

SELECT
    Emp.Country,
    SUM(Emp.Salary)
FROM
    Employees AS Emp
GROUP BY Emp.Country WITH ROLLUP

-- Using Roll Up 2

SELECT
    Emp.Country,
    SUM(Emp.Salary)
FROM
    Employees AS Emp
GROUP BY ROLLUP(Emp.Country )

-- Using Grouping Sets
SELECT
    Emp.Country,
    SUM(Emp.Salary)
FROM
    Employees AS Emp
GROUP BY GROUPING SETS
    (
        (Emp.Country),
        ()
    )

------------------------------------------------------------------------------------------------------------

-- Goal: Group Salary by Country and Gender. Also compute the Subtotal for Country level and Grand Total as shown below.

-- Usin GROUP BY and UNION ALL
SELECT
    Emp.Country,
    Emp.Gender,
    SUM(Salary)
FROM
    Employees AS Emp
GROUP BY
    Emp.Country, Emp.Gender

UNION ALL

SELECT
    Emp.Country,
    NULL AS [Gender],
    SUM(Salary)
FROM
    Employees AS Emp
GROUP BY
    Emp.Country

UNION ALL

SELECT
    NULL AS [Country],
    NULL AS [Gender],
    SUM(Salary)
FROM
    Employees AS Emp

-- Using ROLLUP with GROUP BY 1
SELECT
    Emp.Country,
    Emp.Gender,
    SUM(Salary)
FROM
    Employees AS Emp
GROUP BY
    Emp.Country, Emp.Gender WITH ROLLUP


-- Using ROLLUP with GROUP BY 2
SELECT
    Emp.Country,
    Emp.Gender,
    SUM(Salary)
FROM
    Employees AS Emp
GROUP BY ROLLUP(Emp.Country, Emp.Gender)

-- Using GROUPING SETS

SELECT
    Emp.Country,
    Emp.Gender,
    SUM(Salary)
FROM
    Employees AS Emp
GROUP BY GROUPING SETS
(
    (Country, Gender),
    (Country),
    ()
)


