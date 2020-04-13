-4.1

SELECT SUM([participants]) AS "Number of participants", [course_code] 
  FROM [CourseInstance] 
  GROUP BY [course_code] 
  ORDER BY "Number of participants" desc, [course_code] asc


-4.2

SELECT COUNT([grade]) AS "Number of grades", [student_number]
FROM [CourseGrade]
WHERE [grade] > 0
GROUP BY [student_number]
ORDER BY "Number of grades" desc, [student_number] asc


-4.3.

SELECT [student_number], AVG([grade]) AS "Average grade"
FROM [CourseGrade]
  GROUP BY  [student_number]
  ORDER BY [student_number] asc


SELECT [student_number], CAST (AVG(grade * 1.0) AS DECIMAL(4,2))  AS "Average grade"
FROM [CourseGrade]
GROUP BY  [student_number]
ORDER BY [student_number] asc


-4.4

SELECT [teacher_number], COUNT([instance_number]) AS "Number of course instances" 
FROM [CourseInstance]
WHERE [teacher_number] IS NOT NULL
GROUP BY  [teacher_number]
ORDER BY [teacher_number]


-4.5
How many different courses has each teacher given? Display teacher number and "Number of
different courses". Sort the result by (number of different courses in descending order, teacher
number in ascending order)

SELECT [teacher_number], COUNT(DISTINCT [course_code]) as "Number of different courses"
FROM [CourseInstance]
WHERE [teacher_number] IS NOT NULL 
GROUP BY  [teacher_number]
ORDER BY "Number of different courses" desc, [teacher_number] asc


-4.6.
List all the teachers who have given more than one course instance. Display teacher number and
"Number of course instances". Sort the result by teacher number.

SELECT [teacher_number], COUNT([instance_number]) as "Number of course instances"
FROM [CourseInstance]  
WHERE [teacher_number] IS NOT NULL 
GROUP BY  [teacher_number] HAVING  COUNT([instance_number]) >1
ORDER BY "Number of course instances" desc, [teacher_number] asc


-4.7
List for each student the student number, average grade, highest grade, and lowest grade. In the
query, rename the columns as "Average grade", "Highest grade", and "Lowest grade". Sort the
result by (average grade, student number).
NOTE: Display the correct average grade with two decimal places.

SELECT [student_number], CAST (AVG(grade * 1.0) AS DECIMAL(4,2))  AS "Average grade", MAX(grade) AS "Highest grade", MIN (grade) AS "Lowest grade"
FROM [CourseGrade]
GROUP BY  [student_number]
ORDER BY "Average grade", [student_number] asc


-4.8
SELECT [student_number], CAST (AVG(grade * 1.0) AS DECIMAL(4,2))  AS "Average grade", MAX(grade) AS "Highest grade", MIN (grade) AS "Lowest grade"
FROM [CourseGrade]
GROUP BY  [student_number] HAVING CAST (AVG(grade * 1.0) AS DECIMAL(4,2)) > 3
ORDER BY "Average grade", [student_number] asc



-4.9
In which course instances is the number of participants above the average? Display number of
participants, course code, and instance number. Sort the result by (number of participants in
descending order, course code in ascending order, instance number in ascending order).

SELECT [participants], [course_code],  [instance_number]
FROM [CourseInstance]
WHERE  [participants] > (SELECT AVG([participants]) FROM [CourseInstance])
ORDER BY [participants] desc, [course_code] asc, [instance_number] asc


 -4.10
 List all the students (surname, first name, student number) who have not passed any courses. Sort
the result in ascending order by (surname, first name, student number).
Hint: The table CouseGrade contains facts on all the passing grades. The table Student contains
facts on all the students.

SELECT [surname], [first_name], [student_number]
FROM [Student] 
WHERE [student_number] NOT IN 
(SELECT [student_number] FROM [CourseGrade] WHERE [grade] > 1  )



-4.11
List all the teachers (surname, first name, teacher number, salary) who earn more than all of those
teachers who work at campus that has campus code 'c222'. Sort the result by (surname, first name,
teacher number) in ascending order.


SELECT [surname], [first_name], [teacher_number], [salary] 
FROM [Teacher]
WHERE [salary] >
(SELECT MAX([salary]) FROM [Teacher] WHERE [campus_code] = 'c222')
ORDER BY  [surname], [first_name], [teacher_number]


-4.12. List all the courses (course code, course name) that at least one student has passed this far. Sort the
result by course code in ascending order.

SELECT [course_code], [course_name] 
FROM [Course]
WHERE [course_code] IN 
(SELECT [course_code] FROM [CourseGrade] WHERE [grade] > 1 AND [grade_date] < GETDATE())


-4.13. List all the courses (course code, course name) that no student has passed this far. Sort the result by
course code in ascending order.

SELECT [course_code], [course_name] 
FROM [Course]
WHERE [course_code] NOT IN 
(SELECT [course_code] FROM [CourseGrade] WHERE [grade] > 1 AND [grade_date] < GETDATE())


-4.14. List all the teachers (teacher number, surname, first name) who have not given any courses this far.
Sort the result in ascending order by (surname, first name, teacher number).
Hint: What about missing information? See the SQL DML Quick Reference Guide for details.

SELECT [teacher_number], [surname], [first_name]
FROM  [Teacher]
WHERE [teacher_number] NOT IN 
(SELECT [teacher_number] FROM [CourseInstance] WHERE [teacher_number] IS NOT NULL  )
ORDER BY  [surname], [first_name], [teacher_number]


-4.15 List all courses (course name) that have been given by different teachers who are working at
different campuses. Example of such course: There exists two course instances of the course. The
first one is given by teacher A who is working at campus 1. The second one is given by teacher B who
is working at campus 2. Hint: here you might need a JOIN operation, a subquery, grouping,
aggregate function etc.


WITH TempTable(course_name, campus_code) AS (SELECT DISTINCT course_name, campus_code
			FROM CourseInstance AS CI
			JOIN Course AS C ON (C.course_code = CI.course_code)
			JOIN Teacher AS T ON (CI.teacher_number = T.teacher_number) WHERE campus_code is not null)
SELECT course_name FROM TempTable
GROUP BY course_name 
HAVING COUNT(*)>1



16. Display the gender distribution of students in the following way (sort the result by "%" in descending
order):
gender %
- - - - - - - - - - - -
M 53.8
F 46.2
Hint: You can use a scalar subquery as an operand of an arithmetic operation in the column list.

SELECT GENDER, cast(( 100.0 * COUNT(*)/(SELECT COUNT(*) FROM Student)) as decimal(4,1))  FROM Student 
GROUP BY GENDER



17. Display the gender distribution of students in the following way:
Female Male
- - - - - - - - - - - -
46.2 % 53.8 %


SELECT CAST(cast((SELECT 100.0 *COUNT(*) FROM [Student] WHERE [gender] = 'F') / COUNT(*) as decimal(4,1)) AS VARCHAR(4)) + ' %'
AS "Female", 
CAST(cast((SELECT 100.0 *COUNT(*) FROM [Student] WHERE [gender] = 'M') / COUNT(*) as decimal(4,1)) AS VARCHAR(4)) + ' %' 
AS "Male"
FROM [Student]


18. Display student number and average grade of the student(s) who has/have the highest average
grade. Display the average grade with two decimal places.

WITH TEMPTAB (student_number,Average_grade) AS (
				SELECT [student_number],AVG(grade * 1.0)  
				FROM [CourseGrade]
				GROUP BY  [student_number] )
SELECT student_number, cast(Average_grade as decimal(4,2)) as "Average grade" FROM TEMPTAB WHERE Average_grade = (SELECT MAX(Average_grade) FROM TEMPTAB)


19. Display how many teachers were born in each decade. Sort the result by decade in ascending order.
See the sample query results on how to display the result. Hint: In this task, you do not necessarily
find all the needed syntax from the SQL DML Quick Reference Guide.

SELECT SUBSTRING(CAST(YEAR([birth_date])/10 AS VARCHAR(3)), 3, 1) + '0s' AS "decade", COUNT(*) AS " teachers born"
FROM [Teacher]
GROUP BY  SUBSTRING(CAST(YEAR([birth_date])/10 AS VARCHAR(3)), 3, 1) + '0s'


20. Find the youngest female student and youngest male student. Display gender, surname, first name,
birth date and age. Use a scalar function to compute the age.

SELECT gender, surname, first_name, [birth_date], DATEDIFF(YEAR, [birth_date], SYSDATETIME()) AS "Age"
FROM [Student] AS S
WHERE birth_date = (SELECT MAX(birth_date) 
FROM [Student]
WHERE gender = S.gender)
ORDER BY 1
