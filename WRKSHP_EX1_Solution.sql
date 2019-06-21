--Pr�klady na precvi�enie:
--Manipul�cia s�tabu�kou����������������������������������������������
--- vytvorenie tabu�ky (create)
--- integritn� obmedzenia (primary key, not nul, unique, check)
--- manipul�cie s d�tami tabu�ky (insert, update, delete)
--- modifik�cia �trukt�ry tabu�ky (alter table, alter column, add column)

--1. Vytvorte �ubovo�n� datab�zov� tabu�ku, 
--ktor� bude obsahova� prim�rny k���, kontrolu na NULL hodnoty, unique a check constraint.
CREATE TABLE Pacient (
Id int NOT NULL PRIMARY KEY, 
Meno NVARCHAR(50) NOT NULL, 
Priezvisko NVARCHAR(50) NOT NULL,
RodneCislo NVARCHAR(11) NOT NULL UNIQUE,
DatumNarodenia DATE NOT NULL,
Vek INT NOT NULL,
CHECK (Vek<=110)
)

--2. Vlo�te do tejto tabu�ky minim�lne 10 z�znamov.
INSERT INTO Pacient
VALUES(1, 'Veronika', 'Uhrova', '943456/7812', '2.3.1994', 25) 
INSERT INTO Pacient
VALUES(2, 'Janko', 'Mrkvi�ka', '583456/7830', '5.8.1958', 63)
INSERT INTO Pacient 
VALUES(3, 'Marek', 'Fekete', '673456/7590', '1.7.1967', 52) 
INSERT INTO Pacient
VALUES(4, 'Andrej', 'Danko', '893456/7850', '5.7.1989', 30) 
INSERT INTO Pacient
VALUES(5, 'R�bert', 'Fico', '703456/7850', '3.12.1970', 49) 
INSERT INTO Pacient
VALUES(6, 'R�bert', 'Kali��k', '712356/7861', '3.10.1970', 49) 
INSERT INTO Pacient
VALUES(7, 'Eva', 'Nov�', '603456/7850', '3.12.1960', 59) 
INSERT INTO Pacient
VALUES(8, 'Janka', 'Star�', '503456/7850', '3.07.1950', 69) 
INSERT INTO Pacient
VALUES(9, 'Silvester', 'Adam', '003456/7850', '3.12.2000', 18)
INSERT INTO Pacient
VALUES(10, 'Oto', 'Vajda', '703456/7852', '10.09.2005', 14)  

--3. Nap�te 3 pr�kazy pre editovanie z�znamov.
UPDATE Pacient
SET DatumNarodenia = '12.12.2015'
WHERE Id = 10

UPDATE Pacient
SET Vek = 25
WHERE Id = 9

UPDATE Pacient
SET Priezvisko = 'Nov�kov�'
WHERE Id = 8


--4. Vyma�te 3 z�znamy.
DELETE FROM Pacient
WHERE Id = 10

DELETE FROM Pacient
WHERE Id = 9

DELETE FROM Pacient
WHERE Id = 8


--5. Pridajte do tabu�ky nov� st�pec.
ALTER TABLE Pacient
ADD Pohlavie NVARCHAR(10)

--6. Vlo�te/Editujte hodnoty v novom st�pci.
UPDATE Pacient
SET Pohlavie = 'Mu�'
WHERE Id = 6

UPDATE Pacient
SET Pohlavie = '�ena'
WHERE Id = 7

--7. Preve�te zmenu nad nejak�m st�pcom.
ALTER TABLE Pacient
ALTER COLUMN Pohlavie NVARCHAR(5)


