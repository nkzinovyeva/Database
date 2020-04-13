CREATE TABLE Team
(
 teamNumber			INTEGER			NOT NULL,
 teamName			VARCHAR(50)		NOT NULL,

 CONSTRAINT PK_Team PRIMARY KEY(teamNumber)
)

CREATE TABLE Cyclist
(
 cyclistNumber		INTEGER			NOT NULL,
 familyName			VARCHAR(50)		NOT NULL,
 givenName			VARCHAR(50)		NOT NULL,
 teamNumber			INTEGER			NOT NULL,

 CONSTRAINT PK_Cyclist PRIMARY KEY(cyclistNumber),
 CONSTRAINT FK_Cyclist_Team FOREIGN KEY(teamNumber) REFERENCES Team(teamNumber)
)

INSERT INTO Team(teamNumber, teamName) VALUES
(1, 'Stars'),
(2, 'Beatles')

INSERT INTO Cyclist(cyclistNumber, familyName, givenName, teamNumber) VALUES
(1, 'Lennon', 'John', 2),
(2, 'McCartney', 'Paul', 2),
(3, 'Harrison', 'George', 1),
(4, 'Star', 'Ringo', 1)

INSERT INTO Cyclist(cyclistNumber, familyName, givenName, teamNumber) VALUES
(5, 'Prestley', 'Elvis', 3)

SELECT teamName FROM Team ORDER BY teamName

SELECT familyName, givenName FROM Cyclist 

SELECT familyName, givenName, teamName FROM Cyclist JOIN Team ON (Cyclist.teamNumber = Team.teamNumber)