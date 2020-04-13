-8.1

(SELECT [surname] FROM [Student])
UNION 
(SELECT [surname] FROM [Teacher])


-8.2

(SELECT [city] FROM [Campus])
INTERSECT
(SELECT [city] FROM [Student])


-8.3

(SELECT [city] FROM [Campus])
EXCEPT
(SELECT [city] FROM [Student])


-8.4

(SELECT YEAR([birth_date]) FROM [Student])
UNION
(SELECT YEAR([birth_date]) FROM [Teacher])
ORDER BY 1 desc


-8.5

(SELECT YEAR([birth_date]) FROM [Student])
INTERSECT
(SELECT YEAR([birth_date]) FROM [Teacher])


-8.6

(SELECT YEAR([birth_date]) FROM [Teacher])
EXCEPT
(SELECT YEAR([birth_date]) FROM [Student])


-8.7

(SELECT YEAR([birth_date]) FROM Student)
EXCEPT
(SELECT YEAR([birth_date]) FROM Teacher)
ORDER BY 1 desc

