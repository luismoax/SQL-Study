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

-- CUBE() IN SQL SERVER PRODUCES THE RESULT SET BY GENERATING ALL COMBINATIONS OF COLUMNS SPECIFIED IN GROUP BY CUBE(). 

------------------------------------------------------------------------------------------------------------

-- Goal:  Retrieve Sum of Salary grouped by all combinations of the following 2 columns as well as Grand Total. Country, Gender

-- Using GROUP BY and UNION ALL
SELECT
    Emp.Country,
    Emp.Gender,
    SUM(Emp.Salary) AS [Salary]
FROM
    Employees AS Emp
GROUP BY Emp.Country, Emp.Gender

UNION ALL


SELECT
    Emp.Country,
    NULL AS [Gender],
    SUM(Emp.Salary) AS [Salary]
FROM
    Employees AS Emp
GROUP BY Emp.Country

UNION ALL


SELECT
    NULL AS [Country],
    Emp.Gender,
    SUM(Emp.Salary) AS [Salary]
FROM
    Employees AS Emp
GROUP BY Emp.Gender

UNION ALL

SELECT
    NULL AS Country,
    NULL AS [Gender],
    SUM(Emp.Salary) AS [Salary]
FROM
    Employees AS Emp

-- Using CUBE 1

SELECT
    Emp.Country,
    Emp.Gender,
    SUM(Emp.Salary) AS [Salary]
FROM
    Employees AS Emp
GROUP BY Emp.Country, Emp.Gender WITH CUBE


-- Using CUBE 2

SELECT
    Emp.Country,
    Emp.Gender,
    SUM(Salary) AS [Salary]
FROM
    Employees AS Emp
GROUP BY CUBE(Emp.Country, Emp.Gender)

-- Using Grouping Sets
SELECT
    Emp.Country,
    Emp.Gender,
    SUM(Emp.Salary) AS [Salary]
FROM
    Employees AS Emp
GROUP BY GROUPING SETS
(
    (Emp.Country, Emp.Gender),
    (Emp.Country),
    (Emp.Gender),
    ()
)
