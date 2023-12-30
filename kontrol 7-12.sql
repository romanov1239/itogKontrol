CREATE DATABASE ДрузьяЧеловека;
USE ДрузьяЧеловека;
CREATE TABLE Животные
(
Animal_id INT AUTO_INCREMENT PRIMARY KEY,
Animal_type VARCHAR(20) NOT NULL
);

INSERT INTO Животные (Animal_type)
VALUES
('Собака'),
('Собака'),
('Хомяк'),
('Кошка'),
('Лошадь'),
('Верблюд'),
('Осел');
SELECT * FROM Животные;

DROP TABLE IF EXISTS Животные;
CREATE TABLE Домашние
(
Animal_id INT,
Pet_id INT PRIMARY KEY,
Pet_type VARCHAR(20) NOT NULL,
Pet_name VARCHAR(20) NOT NULL,
Pet_birthdate date,
FOREIGN KEY (Animal_id) REFERENCES Животные (Animal_id) 
);

CREATE TABLE Вьючные
(
Animal_id INT,
Pack_id INT PRIMARY KEY,
Pack_type VARCHAR(20) NOT NULL,
Pack_name VARCHAR(20) NOT NULL,
Pack_birthdate date,
FOREIGN KEY (Animal_id) REFERENCES Животные (Animal_id) 
);
CREATE TABLE Команды
(
Pet_id INT,
Pack_id INT,
Command VARCHAR(20) NOT NULL,
FOREIGN KEY (Pet_id) REFERENCES Домашние (Pet_id) ON DELETE CASCADE,
FOREIGN KEY (Pack_id) REFERENCES Вьючные (Pack_id) ON DELETE CASCADE
);

INSERT INTO Домашние (Animal_id, Pet_id,Pet_type, Pet_Name, Pet_Birthdate)
VALUES
('1','1', 'Собака','Бобик', '2021-04-16'),
('2','2', 'Собака','Шарик', '2018-11-08'),
('3','3', 'Хомяк','Федор', '2023-02-07'),
('4','4', 'Кошка','Мурка', '2022-05-28');

INSERT INTO Вьючные (Animal_id, Pack_id,Pack_type, Pack_Name, Pack_Birthdate)
VALUES
('5','1', 'Лошадь','Звёздочка', '2021-06-14'),
('6','2', 'Верблюд','Шалун', '2017-08-23'),
('7','3', 'Осел','Богатырь', '2016-01-11');

INSERT INTO Команды (Pet_id, Pack_id, Command)
VALUES
('1',null, 'лежать'),
('1',null, 'голос'),
('1',null, 'сидеть'),
('2',null, 'лежать'),
('2',null, 'голос'),
('3',null, 'крутить колесо'),
('4',null, 'лежать'),
(null,'1', 'голоп'),
(null,'1', 'шагом'),
(null,'2', 'идти'),
(null,'2', 'лечь'),
(null,'3', 'идти'),
(null,'3', 'голос');

SET SQL_SAFE_UPDATES = 0;
SELECT * FROM МолодыеЖивотные;

DELETE FROM Вьючные WHERE Pack_type = 'верблюд';

CREATE TABLE МолодыеЖивотные
  SELECT * FROM Pets where YEAR(CURRENT_TIMESTAMP) - YEAR(Pet_birthdate) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(Pet_birthdate, 5))>1 and YEAR(CURRENT_TIMESTAMP) - YEAR(Pet_birthdate) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(Pet_birthdate, 5))<3  
    UNION
  SELECT * FROM Вьючные WHERE YEAR(CURRENT_TIMESTAMP) - YEAR(Pack_birthdate) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(Pack_birthdate, 5))>1 and YEAR(CURRENT_TIMESTAMP) - YEAR(Pack_birthdate) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(Pack_birthdate, 5))<3;

SELECT *, (TIMESTAMPDIFF(MONTH, Pet_birthdate, curdate())) as month_age  FROM МолодыеЖивотные;

SELECT * FROM Домашние JOIN Вьючные JOIN МолодыеЖивотные;

SELECT * FROM Домашние JOIN Команды
	UNION
SELECT * FROM Вьючные JOIN Команды;