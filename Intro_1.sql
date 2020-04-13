CREATE TABLE Department
(
 deptno		INTEGER			NOT NULL,
 deptname	VARCHAR(50)		NOT NULL,

 CONSTRAINT PK_Department PRIMARY KEY(deptno)
)

CREATE TABLE Employee
(
 empno		INTEGER			NOT NULL,
 empname	VARCHAR(50)		NOT NULL,
 deptno		INTEGER			NOT NULL,

 CONSTRAINT PK_Employee PRIMARY KEY(empno),
 CONSTRAINT FK_Employee_Department FOREIGN KEY(deptno) REFERENCES Department(deptno)
)

INSERT INTO Department(deptno, deptname) VALUES
(10, 'Sales'),
(20, 'Marketing')

INSERT INTO Employee(empno, empname, deptno) VALUES
(1, 'John', 10),
(2, 'Susan', 20)

SELECT deptno, deptname FROM Department

SELECT deptname FROM Department WHERE deptno = 10

SELECT deptname FROM Department ORDER BY deptname

SELECT empname, deptname
 FROM Employee JOIN Department ON (Department.deptno = Employee.deptno)
ORDER BY empname

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
 FROM INFORMATION_SCHEMA.COLUMNS


SELECT TABLE_NAME, CONSTRAINT_NAME, COLUMN_NAME
 FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ORDER BY TABLE_NAME
