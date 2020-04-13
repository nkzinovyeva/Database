
-5.1.
SELECT [surname], [first_name], [CourseInstance].[teacher_number], [CourseInstance].[course_code], [CourseInstance].[instance_number]
FROM [Teacher]
JOIN [CourseInstance] ON ([Teacher].[teacher_number] = [CourseInstance].[teacher_number])
ORDER BY [surname], [first_name], [CourseInstance].[course_code], [CourseInstance].[instance_number]


-5.2.  Who is the person in charge of each course? Display course code, course name, and name of the
person in charge. Concatenate surname and first name as "Person in charge". Sort the result by
course code in ascending order.

SELECT [course_code], [course_name],[Teacher].surname + ', ' + [Teacher].first_name AS "Person in charge"
FROM [Course]
JOIN [Teacher] ON ([Course].[person_in_charge] = [Teacher].[teacher_number])


-5.13 What is the grade point average (= average grade) for each student? Display surname, first name,
student number, and average grade (with two decimal places, named as "Grade point average").
Sort the result by (surname, first name, student number).

SELECT [surname], [first_name], [Student].[student_number],  CAST (AVG([CourseGrade].[grade] * 1.0) AS DECIMAL(4,2)) AS "Grade point average"
FROM [Student]
JOIN [CourseGrade] ON ([Student].[student_number]  = [CourseGrade].student_number)
GROUP BY [surname], [first_name], [Student].[student_number]
ORDER BY [surname], [first_name], [Student].[student_number]


-5.4
Time dimension considerations
a) List all the current academic advisors (surname, first name, teacher number, start date, end
date). Sort the result by (surname, first name, teacher number) in ascending order.
b) List all the current and past academic advisors (surname, first name, teacher number, start
date, end date). Sort the result by (surname, first name, teacher number) in ascending order.

SELECT [Teacher].surname, [Teacher].first_name, [Teacher].teacher_number, [AcademicAdvisor].start_date, [AcademicAdvisor].end_date
FROM [AcademicAdvisor]
JOIN [Teacher] ON ( [Teacher].teacher_number = [AcademicAdvisor].teacher_number)
WHERE [AcademicAdvisor].end_date IS NULL
ORDER BY [Teacher].surname, [Teacher].first_name, [Teacher].teacher_number


SELECT [Teacher].surname, [Teacher].first_name, [Teacher].teacher_number, [AcademicAdvisor].start_date, [AcademicAdvisor].end_date
FROM [AcademicAdvisor]
JOIN [Teacher] ON ( [Teacher].teacher_number = [AcademicAdvisor].teacher_number)
ORDER BY [Teacher].surname, [Teacher].first_name, [Teacher].teacher_number


-5.5 What types of academic misconduct have occurred at Takkula University this far? List misconduct
description. Sort the result by misconduct type in ascending order. This time, use a join, not any
subquery.

SELECT [MisconductType].description 
FROM [MisconductType]
JOIN [MisconductIncident] ON ([MisconductType].misconduct_code = [MisconductIncident].misconduct_code)
WHERE [MisconductIncident].[decision_date] < SYSDATETIME()


-5.6. List all the students (surname, first name, student number, course code, grade) who live in Helsinki
and have at least one course grade greater than 2. Sort the result by (surname, first name, student
number, course code).

SELECT [surname], [first_name], [Student].[student_number], [CourseGrade].course_code, [CourseGrade].grade
FROM [Student]
JOIN [CourseGrade] ON ([Student].student_number = [CourseGrade].student_number)
WHERE [grade] > 2 AND [Student].city = 'HELSINKI'


-5.7 List all the teachers (course code, course name, teacher number, surname, first name) who have
given the course that has the course code 'a730'. Sort the result by teacher number in ascending
order.

SELECT DISTINCT [CourseInstance].[course_code], [Course].[course_name], [CourseInstance].[teacher_number], [Teacher].[surname], [Teacher].[first_name]
FROM [CourseInstance]
JOIN [Course] ON([CourseInstance].[course_code] = [Course].[course_code])
JOIN [Teacher] ON([CourseInstance].[teacher_number] = [Teacher].[teacher_number])
WHERE [CourseInstance].[course_code] = 'a730'



-5.8. List all the passing grades (course name, grade, surname, first name, student number) for female
students. Sort by the result by (course name, grade in descending order, surname, first name,
student number in ascending order).

SELECT  [Course].[course_name], [CourseGrade].[grade], [Student].surname, [Student].[first_name], [Student].[student_number]
FROM [CourseGrade]
JOIN [Student] ON ([Student].student_number = [CourseGrade].student_number)
JOIN [Course] ON ([CourseGrade].course_code = [Course].course_code)
WHERE  [Student].gender = 'F' AND [CourseGrade].grade > 1
ORDER BY [Course].[course_name] DESC, [CourseGrade].[grade] DESC, [Student].surname ASC, [Student].[first_name] ASC, [Student].[student_number] ASC


-5.9. In which courses have female students achieved grade 5? Display course code, course name, and
the number of grade 5s achieved by female students. Rename the last column as "Grade five". Sort
the result by course code in ascending order.

SELECT [CourseGrade].course_code, [Course].[course_name], COUNT([CourseGrade].[student_number]) AS "Grade five"
FROM [CourseGrade]
JOIN [Student] ON ([Student].student_number = [CourseGrade].student_number)
JOIN [Course] ON ([CourseGrade].course_code = [Course].course_code)
WHERE [Student].gender = 'F' AND [CourseGrade].grade = 5
GROUP BY [CourseGrade].course_code, [Course].[course_name]


-5.10. List all the students (surname, first name, student number) of those students, who have grade 3
from any course. Do not allow any duplicate entries in the result. Sort by (surname, first name,
student number) in ascending order.

SELECT DISTINCT [Student].surname, [Student].first_name, [Student].student_number
FROM [Student]
JOIN [CourseGrade] ON ([Student].student_number = [CourseGrade].student_number)
WHERE [CourseGrade].grade = 3
ORDER BY [Student].surname, [Student].first_name, [Student].student_number 


-5.11  List all the teachers (teacher number, surname, first name, month name of the grade date) who
have evaluated a course in May. Rename the last column as "Grade month". Sort the result by
teacher number in ascending order.
NOTICE: Make sure that the result of your query is not dependent of the local language
(English, Finnish, ...).

SELECT [Teacher].[teacher_number], [Teacher].[surname], [Teacher].[first_name], DATENAME (MONTH,[CourseGrade].[grade_date]) AS "Grade month"
FROM [Teacher]
JOIN [CourseGrade] ON ([Teacher].[teacher_number] = [CourseGrade].[examiner])
WHERE MONTH([CourseGrade].[grade_date]) = 5


-5.12 How are the average grade and the total number of grades distributed between female and male
students? Display gender, average grade (with 2 decimal places) and the number of grades. Rename
the last two columns as "Average grade" and "Number of grades". Sort by "Average grade" in
descending order.

SELECT [Student].[gender], CAST (AVG([CourseGrade].[grade] * 1.0) AS DECIMAL(4,2)) AS "Average grade", COUNT([CourseGrade].[grade]) AS "Number of grades"
FROM [Student]
JOIN [CourseGrade] ON ([Student].[student_number]  = [CourseGrade].student_number)
GROUP BY [Student].[gender]
ORDER BY [Student].[gender] DESC


-5.13. Create a Cartesian product using the tables Campus and AcademicAdvisor, without any duplicate
entries. Display campus name and teacher number. Sort the result by (campus name, teacher
number) in ascending order.

SELECT DISTINCT [Campus].[campus_name], [AcademicAdvisor].[teacher_number]
FROM [Campus]
CROSS JOIN [AcademicAdvisor]


-5.14. List the courses that students have failed due to an academic misconduct incident. Display course
code, instance number, course name, student number, surname, first name, and misconduct
description.

SELECT [MisconductIncident].[course_code], [instance_number],[Course].[course_name], [MisconductIncident].[student_number], [Student].surname, [Student].first_name, [MisconductType].[description]
FROM [MisconductIncident]
JOIN [Course] ON ([MisconductIncident].[course_code] = [Course].[course_code])
JOIN [Student] ON ([MisconductIncident].[student_number] = [Student].[student_number])
JOIN [MisconductType] ON ([MisconductIncident].[misconduct_code] = [MisconductType].[misconduct_code])


15. List all the students (student number, surname, first name, disciplinary sanction, misconduct
description) who have got a written warning due to an academic misconduct incident.

SELECT [MisconductIncident].[student_number], [surname],[first_name], [SanctionType].[description], [MisconductType].[description]
FROM [Student]
JOIN [MisconductIncident] ON ([MisconductIncident].[student_number] = [Student].[student_number])
JOIN [SanctionType] ON ([SanctionType].[sanction_code] =[MisconductIncident].[sanction_code] )
JOIN [MisconductType] ON ([MisconductType].[misconduct_code] = [MisconductIncident].[misconduct_code])
WHERE [SanctionType].[description] = 'Written warning'



16. What is the prevalence of academic misconduct at Takkula University? Find out the percentage of
students who have been penalized due to an academic misconduct incident. Display the percentage
with one decimal place. Rename the column as "Misconduct %".
Hint: When you need to use the total of students as an operand in the percentage calculation,
write a subquery in the formula.

SELECT DISTINCT CAST( ((SELECT 100.0 * COUNT (*) FROM MisconductIncident) /  (SELECT COUNT(*) FROM Student)) AS DECIMAL(4,1)) AS "Misconduct %"
FROM MisconductIncident 
JOIN Student ON (MisconductIncident.student_number = Student.student_number)


-5.17 List all the courses (course name, teacher number, teacher name) where the person in charge has
also been the teacher of an instance of the course. Concatenate surname and first name "Person in
charge teaching". Sort the result by (surname, first name, teacher number) in ascending order.

SELECT [Course].[course_name], [CourseInstance].[teacher_number], [Teacher].SURNAME + ', ' + [Teacher].[first_name] AS "Person in charge teaching"
FROM [CourseInstance]
JOIN [Teacher] ON ([Teacher].[teacher_number] = [CourseInstance].[teacher_number])
JOIN [Course] ON ([CourseInstance].[course_code] = [Course].[course_code])
WHERE [Course].[person_in_charge] = [CourseInstance].[teacher_number]
ORDER BY [Teacher].SURNAME, [Teacher].[first_name], [CourseInstance].[teacher_number]
