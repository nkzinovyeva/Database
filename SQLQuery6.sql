-6.1. List all the courses (surname, first name, teacher number, course name) that have been given by the
teacher whose teacher number is 'h303'. Sort the result by course name in ascending order.

select distinct [Teacher].surname, [Teacher].first_name, [Teacher].teacher_number,
[Course].course_name from [CourseInstance]
join [Course] on ([CourseInstance].course_code = [Course].course_code)
join [Teacher] on ([CourseInstance].teacher_number = [Teacher].teacher_number)
where [CourseInstance].teacher_number = 'h303'
order by [Course].course_name


-6.2. List all the teachers (surname, first name, teacher number, course name). If a teacher is in charge of
a course, then also the course name should be shown. Sort the result by (surname, first name,
teacher number, course name) in ascending order.

select [Teacher].surname, Teacher.first_name, Teacher.teacher_number, Course.course_name from Teacher
left outer join Course on (Teacher.teacher_number = Course.person_in_charge)
order by  [Teacher].surname, Teacher.first_name, Teacher.teacher_number, Course.course_name



-6.3. List all the course instances (course code, instance number, start date, surname, first name, teacher
number) that have started in 2008. Concatenate surname and first name as "Teacher". Sort the
result by (course code, instance number) in ascending order.

select CourseInstance.course_code, CourseInstance.instance_number, CourseInstance.start_date, Teacher.surname + ', ' + Teacher.first_name AS 'Teacher' from CourseInstance
left outer JOIN Teacher ON (CourseInstance.teacher_number = Teacher.teacher_number)
WHERE YEAR(CourseInstance.start_date) = '2008'



-6.4. List all the teachers (campus name, surname, first name, teacher number, course name). If the
teacher is in charge of a course, then also the course name should be shown. Sort the result by
(campus name, surname, first name, teacher number, course name) in ascending order.


select Teacher.campus_code, Teacher.surname, Teacher.first_name, Teacher.teacher_number, Course.course_name
from Teacher
LEFT OUTER JOIN Course ON (Teacher.teacher_number = Course.[person_in_charge])
order by Teacher.campus_code, Teacher.surname, Teacher.first_name, Teacher.teacher_number, Course.course_name



-6.5. List the number of teachers per each campus (campus name, "Number of teachers"). Sort the result
by campus name in ascending order.

select Campus.campus_name, COUNT(Teacher.teacher_number) as "Number of Teachers" from Campus
LEFT OUTER JOIN Teacher ON (Campus.campus_code = Teacher.campus_code)
GROUP BY Campus.campus_name
ORDER BY  Campus.campus_name


-6.6. Time dimension considerations: List all the teachers (surname, first name, teacher number, start
date, end date) who have been working as academic advisors in 2010 (at least for one day). Sort the
result by (surname, first name, teacher number) in ascending order.


select Teacher.surname, Teacher.first_name, Teacher.teacher_number, AcademicAdvisor.start_date, AcademicAdvisor.end_date
FROM AcademicAdvisor
JOIN Teacher on (AcademicAdvisor.teacher_number = Teacher.teacher_number)
WHERE (YEAR([start_date]) = '2010' OR YEAR([end_date]) = '2010') AND DATEDIFF(DAY, [start_date],[end_date]) >= 1
ORDER BY Teacher.surname, Teacher.first_name, Teacher.teacher_number


OPTIONAL TASKS (... Case expressions needed here ...)
-6.7. List all the teachers (surname, first name, teacher number, course name). If the teacher is in charge
of a course, display also the name of the course; otherwise leave the course name column totally
empty. Sort the result by (surname, first name, teacher number) in ascending order.

select [Teacher].surname, Teacher.first_name, Teacher.teacher_number, ISNULL(Course.course_name, ' ') AS 'course_name'
from Teacher
left outer join Course on (Teacher.teacher_number = Course.person_in_charge)
order by  [Teacher].surname, Teacher.first_name, Teacher.teacher_number, Course.course_name



-6.8. List all the teachers (surname, first name, teacher number, "Comment") without any duplicate
entries. If the teacher is also an academic advisor, show the text 'academic advisor' in the
"Comment" column, otherwise leave the column totally empty. Sort the result by (surname, first
name, teacher number) in ascending order.

select distinct Teacher.surname, Teacher.first_name, Teacher.teacher_number, 
(case When AcademicAdvisor.teacher_number is not null then 'academic advisor'
else ' ' end) AS 'Comment'
from Teacher
left outer join AcademicAdvisor on (Teacher.teacher_number = AcademicAdvisor.teacher_number)
order by  [Teacher].surname, Teacher.first_name, Teacher.teacher_number



-6.9. How many teachers in charge of a course there are at each campus? Display campus name and the
number of teachers in charge of a course. Rename the second column as "Number of teachers in
charge of a course". Sort the result by campus name in ascending order.

WITH Temptable (teacherID, chargePerson, campus_code)
AS (SELECT DISTINCT Teacher.teacher_number, Course.person_in_charge, Teacher.campus_code
FROM Teacher LEFT OUTER JOIN Course ON (Teacher.teacher_number = Course.person_in_charge))
SELECT Campus.campus_name, COUNT(Temptable.chargePerson) AS "Number of teachers in
charge of a course" FROM Campus
LEFT OUTER JOIN Temptable ON (Campus.campus_code = Temptable.campus_code)
GROUP BY Campus.campus_name
ORDER BY Campus.campus_name


