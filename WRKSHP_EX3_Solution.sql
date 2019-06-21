--Pr�klady na precvi�enie:
--Pr�ca s viacer�mi tabu�kami
--- spojenie dvoch tabuliek (join, left outer join, right outer join, full outer join)
--- cudz� k��� (references, foreign key)
--- mno�inov� oper�cie (union, union all, intersect, except)

--Spojenie dvoch tabuliek
--Spustite dan� SQL pr�kazy a zamyslite sa, ako sa zadania pr�kazov l�ia:
SELECT u.LoginName, s.DateOfShopping
FROM Customer u
INNER JOIN Shopping s on u.LoginName = s.LoginName

SELECT u.LoginName, s.DateOfShopping
FROM Customer u
LEFT JOIN Shopping s on u.LoginName = s.LoginName

SELECT u.LoginName, s.DateOfShopping
FROM Customer u
RIGHT JOIN Shopping s on u.LoginName = s.LoginName

SELECT u.LoginName, s.DateOfShopping
FROM Customer u
FULL OUTER JOIN Shopping s on u.LoginName = s.LoginName

--1. Nap�te select pr�kaz, ktor� vyp�e loginy z�kazn�kov, ktor� si nie�o k�pili.
--Zora�te v�sledky pod�a loginu zostupne..
SELECT DISTINCT c.LoginName
FROM Customer c
INNER JOIN Shopping s ON c.LoginName = s.LoginName
ORDER BY c.LoginName DESC

--2. Nap�te select pr�kaz, ktor� vyp�e loginy z�kazn�kov, ktor� si ni� nek�pili.
--Zora�te v�sledky pod�a loginu zostupne..
SELECT DISTINCT c.LoginName
FROM Customer c
LEFT JOIN Shopping s ON c.LoginName = s.LoginName
WHERE s.ProductId IS NULL
ORDER BY c.LoginName DESC

--3. Nap�te select pr�kaz, ktor� vyp�e loginy z�kazn�kov, ktor� si k�pili v�robok za menej ako 100�.
--Zora�te v�sledky pod�a loginu zostupne. Odstr��te duplicity.
SELECT DISTINCT c.LoginName
FROM Customer c
INNER JOIN Shopping s ON c.LoginName = s.LoginName
INNER JOIN Product p on s.ProductId = p.ProductId
WHERE p.Price < 100
ORDER BY c.LoginName DESC

--4. Nap�te select pr�kaz, ktor� vyp�e loginy z�kazn�kov, ktor� si k�pili v�robok, ktor�ho meno za��na na p�smeno 's'.
--Zora�te v�sledky pod�a loginu zostupne. Odstr��te duplicity.
SELECT DISTINCT c.LoginName
FROM Customer c
INNER JOIN Shopping s ON c.LoginName = s.LoginName
INNER JOIN Product p on s.ProductId = p.ProductId
WHERE p.Title LIKE 's%'
ORDER BY c.LoginName DESC

--5. Nap�te select pr�kaz, ktor� vyp�e celkov� sumu n�kupov z�kazn�ka 'vinetu'.
SELECT SUM(p.price)
FROM Customer c
INNER JOIN Shopping s ON c.LoginName = s.LoginName
INNER JOIN Product p on s.ProductId = p.ProductId
WHERE s.LoginName = 'vinetu'

--6. Nap�te select pr�kaz, ktor� vyp�e celkov� po�et nak�pen�ch v�robkov z�kazn�ka 'pepik'.
SELECT COUNT(p.price)
FROM Customer c
INNER JOIN Shopping s ON c.LoginName = s.LoginName
INNER JOIN Product p on s.ProductId = p.ProductId
WHERE s.LoginName = 'pepik'

--7. Nap�te select pr�kaz, ktor� vyp�e priemern� cenu n�kupu.
SELECT AVG(p.price)
FROM Product p
INNER JOIN Shopping s ON p.ProductId = s.PRoductId

--Mno�inov� oper�cie
--Pomocou mno�inov�ch oper�ci� nap�te nasleduj�ce pr�kazy:
--1. Nap�te select pr�kaz, ktor� vyp�e loginy a mest� v�etk�ch z�kazn�kov, 
--ktor� s� z mesta Bratislava a z mesta Ko�ice.
--Zora�te v�sledky pod�a loginu zostupne.
SELECT	LoginName
FROM Customer
WHERE City = 'Bratislava'
UNION
SELECT	LoginName
FROM Customer
WHERE City = 'Kosice'
   
--2. Nap�te select pr�kaz, ktor� vyp�e loginy a mest� v�etk�ch z�kazn�kov, 
--ktor� s� z mesta Bratislava a nie s� z mesta Ko�ice.
SELECT	LoginName
FROM Customer
WHERE City = 'Bratislava'
INTERSECT
SELECT	LoginName
FROM Customer
WHERE City != 'Kosice'

--3. Nap�te select pr�kaz, ktor� vyp�e loginy v�etk�ch z�kazn�kov s rokom ich narodenia, 
--ktor� sa narodili po roku 1989, ale narodili sa pred rokom 1994.
SELECT	LoginName, YearOfBirth
FROM Customer
WHERE YearOfBirth > 1989
INTERSECT
SELECT	LoginName, YearOfBirth
FROM Customer
WHERE YearOfBirth < 1994

--4. Nap�te select pr�kaz, ktor� vyp�e loginy v�etk�ch z�kazn�kov s rokom ich narodenia a mestom,
--ktor� s� z mesta Bratislava A Z�ROVE� sa narodili pred rokom 1989.
SELECT	LoginName, YearOfBirth, City
FROM Customer
WHERE City = 'Bratislava'
INTERSECT
SELECT	LoginName, YearOfBirth, City
FROM Customer
WHERE YearOfBirth < 1989

--5. Nap�te select pr�kaz, ktor� vyp�e loginy v�etk�ch z�kazn�kov s rokom ich narodenia a mestom,
--ktor� s� z mesta Bratislava ALEBO sa narodili pred rokom 1989.
--Zora�te v�sledky pod�a loginu zostupne.
SELECT	LoginName, YearOfBirth, City
FROM Customer
WHERE City = 'Bratislava'
UNION
SELECT	LoginName, YearOfBirth, City
FROM Customer
WHERE YearOfBirth < 1989

--6. Nap�te select pr�kaz, ktor� vyp�e loginy v�etk�ch z�kazn�kov s rokom ich narodenia a mestom,
--ktor� s� z mesta Ko�ice A Z�ROVE� sa narodili medzi rokmi 1989 a 1994.
--Zora�te v�sledky pod�a loginu zostupne.
SELECT	LoginName, YearOfBirth, City
FROM Customer
WHERE City = 'Kosice'
UNION
SELECT	LoginName, YearOfBirth, City
FROM Customer
WHERE YearOfBirth BETWEEN 1989 AND 1994

--7. Nap�te select pr�kaz, ktor� vyp�e n�zvy v�etk�ch polo�iek s ich cenami. 
--Vyberte tak�, ktor� s� drah�ie ako 50� A Z�ROVE� s� lacnej�ie ako 200�.
SELECT Title, Price
FROM Product
WHERE Price > 50
INTERSECT
SELECT Title, Price
FROM Product
WHERE Price < 200
   
--8. Nap�te select pr�kaz, ktor� vyp�e n�zvy v�etk�ch polo�iek s ich cenami. 
--Vyberte tak�, ktor� s� drah�ie ako 10� A Z�ROVE� s� lacnej�ie ako 200�.
--Pou�ite mno�inov� oper�ciu EXCEPT.
--Zora�te v�sledky pod�a n�zvu zostupne.
SELECT Title, Price
FROM Product
WHERE Price > 10
EXCEPT
SELECT Title, Price
FROM Product
WHERE Price > 200
ORDER BY Title DESC