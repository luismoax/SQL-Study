-- Scripts to create Dummy Data

-- CREATE TABLE tblEmployee
-- (
--   Id int Primary Key,
--   Name nvarchar(30),
--   Gender nvarchar(10),
--   DepartmentId int
-- )


-- CREATE TABLE tblDepartment
-- (
--  DeptId int Primary Key,
--  DeptName nvarchar(20)
-- )

-- Insert into tblDepartment values (1,'IT')
-- Insert into tblDepartment values (2,'Payroll')
-- Insert into tblDepartment values (3,'HR')
-- Insert into tblDepartment values (4,'Admin')

-- Insert into tblEmployee values (1,'John', 'Male', 3)
-- Insert into tblEmployee values (2,'Mike', 'Male', 2)
-- Insert into tblEmployee values (3,'Pam', 'Female', 1)
-- Insert into tblEmployee values (4,'Todd', 'Male', 4)
-- Insert into tblEmployee values (5,'Sara', 'Female', 1)
-- Insert into tblEmployee values (6,'Ben', 'Male', 3)


WITH
EmployeesNameGender AS
(    
    SELECT
        Id,
        Name,
        Gender
    FROM
        tblEmployee
)
-- SELECT
--     *
-- FROM
--     EmployeesNameGender

--- Let's update the CTE

UPDATE
    EmployeesNameGender
SET
    Gender = 'Female'
WHERE Id = 1

-- Checking that the actual underlying table was updated
SELECT * FROM tblEmployee


-- Now, query the tblEmployee table. 
-- JOHN's gender is actually UPDATED. 
-- So, if a CTE is created on one base table, then it is possible to UPDATE the CTE, 
-- WHICH IN TURN WILL UPDATE THE UNDERLYING BASE TABLE. 
-- In this case, UPDATING Employees_Name_Gender CTE, updates tblEmployee table.