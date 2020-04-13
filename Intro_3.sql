 INSERT INTO Department(deptno,deptname) VALUES
 (30, 'Management')

 INSERT INTO Employee(empno, empname, deptno) VALUES
 (4, 'Athena', 30)

SELECT empname FROM Employee

SELECT empname FROM Employee WHERE empno = 2

SELECT empname FROM Employee WHERE deptno = 10

