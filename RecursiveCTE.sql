

-- CREATE TABLE tblEmployeeWithManager
-- (
--   EmployeeId int PRIMARY KEY,
--   Name VARCHAR(20),
--   ManagerId INT
-- )

-- INSERT INTO tblEmployeeWithManager VALUES (1, 'Tom', 2)
-- INSERT INTO tblEmployeeWithManager VALUES (2, 'Josh', null)
-- INSERT INTO tblEmployeeWithManager VALUES (3, 'Mike', 2)
-- INSERT INTO tblEmployeeWithManager VALUES (4, 'John', 3)
-- INSERT INTO tblEmployeeWithManager VALUES (5, 'Pam', 1)
-- INSERT INTO tblEmployeeWithManager VALUES (6, 'Mary', 3)
-- INSERT INTO tblEmployeeWithManager VALUES (7, 'James', 1)
-- INSERT INTO tblEmployeeWithManager VALUES (8, 'Sam', 5)
-- INSERT INTO tblEmployeeWithManager VALUES (9, 'Simon', 1)


-- Recursive CTE
WITH
RecEmployeeWithManager AS
(
    -- Anchor
    SELECT
        frst.EmployeeId,
        frst.Name,
        frst.ManagerId,
        CAST('SuperBoss' AS VARCHAR(20)) AS ManagerName,
        1 AS [Level]
    FROM
        tblEmployeeWithManager AS frst
    WHERE ManagerId IS NULL

    UNION ALL

    SELECT
        scnd.EmployeeId,
        scnd.Name,
        scnd.ManagerId,
        frst.Name AS ManagerName,
        frst.[Level] + 1 AS [Level]
    FROM
        RecEmployeeWithManager AS frst
    INNER JOIN
        tblEmployeeWithManager AS scnd ON frst.EmployeeId = scnd.ManagerId
)
SELECT    
    rewm.Name,    
    rewm.ManagerName,
    rewm.[Level]
FROM
    RecEmployeeWithManager AS rewm
ORDER BY [Level] ASC
