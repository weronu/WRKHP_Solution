--Príklady na precvièenie:
--Práca s viacerými tabu¾kami
--- spojenie dvoch tabuliek (join, left outer join, right outer join, full outer join)
--- cudzí k¾úè (references, foreign key)
--- množinové operácie (union, union all, intersect, except)

--Spojenie dvoch tabuliek
--Spustite dané SQL príkazy a zamyslite sa, ako sa zadania príkazov líšia:
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

--1. Napíšte select príkaz, ktorý vypíše loginy zákazníkov, ktorí si nieèo kúpili.
--Zoraïte výsledky pod¾a loginu zostupne..
SELECT DISTINCT c.LoginName
FROM Customer c
INNER JOIN Shopping s ON c.LoginName = s.LoginName
ORDER BY c.LoginName DESC

--2. Napíšte select príkaz, ktorý vypíše loginy zákazníkov, ktorí si niè nekúpili.
--Zoraïte výsledky pod¾a loginu zostupne..
SELECT DISTINCT c.LoginName
FROM Customer c
LEFT JOIN Shopping s ON c.LoginName = s.LoginName
WHERE s.ProductId IS NULL
ORDER BY c.LoginName DESC

--3. Napíšte select príkaz, ktorý vypíše loginy zákazníkov, ktorí si kúpili výrobok za menej ako 100€.
--Zoraïte výsledky pod¾a loginu zostupne. Odstráòte duplicity.
SELECT DISTINCT c.LoginName
FROM Customer c
INNER JOIN Shopping s ON c.LoginName = s.LoginName
INNER JOIN Product p on s.ProductId = p.ProductId
WHERE p.Price < 100
ORDER BY c.LoginName DESC

--4. Napíšte select príkaz, ktorý vypíše loginy zákazníkov, ktorí si kúpili výrobok, ktorého meno zaèína na písmeno 's'.
--Zoraïte výsledky pod¾a loginu zostupne. Odstráòte duplicity.
SELECT DISTINCT c.LoginName
FROM Customer c
INNER JOIN Shopping s ON c.LoginName = s.LoginName
INNER JOIN Product p on s.ProductId = p.ProductId
WHERE p.Title LIKE 's%'
ORDER BY c.LoginName DESC

--5. Napíšte select príkaz, ktorý vypíše celkovú sumu nákupov zákazníka 'vinetu'.
SELECT SUM(p.price)
FROM Customer c
INNER JOIN Shopping s ON c.LoginName = s.LoginName
INNER JOIN Product p on s.ProductId = p.ProductId
WHERE s.LoginName = 'vinetu'

--6. Napíšte select príkaz, ktorý vypíše celkový poèet nakúpených výrobkov zákazníka 'pepik'.
SELECT COUNT(p.price)
FROM Customer c
INNER JOIN Shopping s ON c.LoginName = s.LoginName
INNER JOIN Product p on s.ProductId = p.ProductId
WHERE s.LoginName = 'pepik'

--7. Napíšte select príkaz, ktorý vypíše priemernú cenu nákupu.
SELECT AVG(p.price)
FROM Product p
INNER JOIN Shopping s ON p.ProductId = s.PRoductId

--Množinové operácie
--Pomocou množinových operácií napíšte nasledujúce príkazy:
--1. Napíšte select príkaz, ktorý vypíše loginy a mestá všetkých zákazníkov, 
--ktorí sú z mesta Bratislava a z mesta Košice.
--Zoraïte výsledky pod¾a loginu zostupne.
SELECT	LoginName
FROM Customer
WHERE City = 'Bratislava'
UNION
SELECT	LoginName
FROM Customer
WHERE City = 'Kosice'
   
--2. Napíšte select príkaz, ktorý vypíše loginy a mestá všetkých zákazníkov, 
--ktorí sú z mesta Bratislava a nie sú z mesta Košice.
SELECT	LoginName
FROM Customer
WHERE City = 'Bratislava'
INTERSECT
SELECT	LoginName
FROM Customer
WHERE City != 'Kosice'

--3. Napíšte select príkaz, ktorý vypíše loginy všetkých zákazníkov s rokom ich narodenia, 
--ktorí sa narodili po roku 1989, ale narodili sa pred rokom 1994.
SELECT	LoginName, YearOfBirth
FROM Customer
WHERE YearOfBirth > 1989
INTERSECT
SELECT	LoginName, YearOfBirth
FROM Customer
WHERE YearOfBirth < 1994

--4. Napíšte select príkaz, ktorý vypíše loginy všetkých zákazníkov s rokom ich narodenia a mestom,
--ktorí sú z mesta Bratislava A ZÁROVEÒ sa narodili pred rokom 1989.
SELECT	LoginName, YearOfBirth, City
FROM Customer
WHERE City = 'Bratislava'
INTERSECT
SELECT	LoginName, YearOfBirth, City
FROM Customer
WHERE YearOfBirth < 1989

--5. Napíšte select príkaz, ktorý vypíše loginy všetkých zákazníkov s rokom ich narodenia a mestom,
--ktorí sú z mesta Bratislava ALEBO sa narodili pred rokom 1989.
--Zoraïte výsledky pod¾a loginu zostupne.
SELECT	LoginName, YearOfBirth, City
FROM Customer
WHERE City = 'Bratislava'
UNION
SELECT	LoginName, YearOfBirth, City
FROM Customer
WHERE YearOfBirth < 1989

--6. Napíšte select príkaz, ktorý vypíše loginy všetkých zákazníkov s rokom ich narodenia a mestom,
--ktorí sú z mesta Košice A ZÁROVEÒ sa narodili medzi rokmi 1989 a 1994.
--Zoraïte výsledky pod¾a loginu zostupne.
SELECT	LoginName, YearOfBirth, City
FROM Customer
WHERE City = 'Kosice'
UNION
SELECT	LoginName, YearOfBirth, City
FROM Customer
WHERE YearOfBirth BETWEEN 1989 AND 1994

--7. Napíšte select príkaz, ktorý vypíše názvy všetkých položiek s ich cenami. 
--Vyberte také, ktoré sú drahšie ako 50€ A ZÁROVEÒ sú lacnejšie ako 200€.
SELECT Title, Price
FROM Product
WHERE Price > 50
INTERSECT
SELECT Title, Price
FROM Product
WHERE Price < 200
   
--8. Napíšte select príkaz, ktorý vypíše názvy všetkých položiek s ich cenami. 
--Vyberte také, ktoré sú drahšie ako 10€ A ZÁROVEÒ sú lacnejšie ako 200€.
--Použite množinovú operáciu EXCEPT.
--Zoraïte výsledky pod¾a názvu zostupne.
SELECT Title, Price
FROM Product
WHERE Price > 10
EXCEPT
SELECT Title, Price
FROM Product
WHERE Price > 200
ORDER BY Title DESC