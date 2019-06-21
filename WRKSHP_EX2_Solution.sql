--RIEŠENIE--
--Príklady na precvičenie:
--Výber dát z tabuľky
--- dopytovania (select)
--- dopytovania na základe podmienok (where)
--- agregácií (count, distinct, min, max, avg, group by, having)

--Príkaz SELECT
--1. Napíšte select príkaz, 
--ktorý vypíše loginy všetkých zákazníkov.
--Zoraďte výsledky podľa loginu zostupne.
SELECT LoginName
FROM Customer
ORDER BY LoginName DESC

--2. Napíšte select príkaz, 
--ktorý vypíše loginy všetkých zákazníkov s rokom ich narodenia.
--Zoraďte výsledky podľa loginu vzostupne.
SELECT LoginName, YearOfBirth
FROM Customer
ORDER BY LoginName ASC

--3. Napíšte select príkaz, 
--ktorý vypíše názvy všetkých výrobkov.
--Zoraďte výsledky podľa názvu zostupne.
SELECT Title
FROM Product
ORDER BY Title DESC

--4. Napíšte select príkaz, 
--ktorý vypíše názvy všetkých výrobkov s ich cenami.
--Zoraďte výsledky podľa názvu vzostupne.
SELECT Title, Price
FROM Product
ORDER BY Title ASC

--Podmienka WHERE
--1. Napíšte select príkaz, ktorý vypíše loginy všetkých zákazníkov, 
--ktorí sú z mesta Bratislava.
SELECT LoginName
FROM Customer
WHERE City = 'Bratislava'

--2. Napíšte select príkaz, ktorý vypíše loginy všetkých zákazníkov s rokom ich narodenia, 
--ktorí sa narodili po roku 1989.
--Zoraďte výsledky podľa loginu vzostupne.
SELECT LoginName
FROM Customer
WHERE YearOfBirth > 1989
ORDER BY LoginName ASC

--3. Napíšte select príkaz, ktorý vypíše loginy všetkých zákazníkov s rokom ich narodenia a mestom,
--ktorí sú z mesta Bratislava A ZÁROVEŇ sa narodili pred rokom 1989.
--Zoraďte výsledky podľa loginu vzostupne.
SELECT LoginName, YearOfBirth, City
FROM Customer
WHERE City = 'Bratislava' AND YearOfBirth < 1989
ORDER BY LoginName ASC 

--4. Napíšte select príkaz, ktorý vypíše loginy všetkých zákazníkov s rokom ich narodenia a mestom,
--ktorí sú z mesta Bratislava ALEBO sa narodili pred rokom 1989.
--Zoraďte výsledky podľa loginu zostupne.
SELECT LoginName, YearOfBirth, City
FROM Customer
WHERE City = 'Bratislava' OR YearOfBirth < 1989
ORDER BY LoginName ASC 

--5. Napíšte select príkaz, ktorý vypíše loginy všetkých zákazníkov s rokom ich narodenia a mestom,
--ktorí sú z mesta Košice a narodili sa medzi rokmi 1989 a 1994.
SELECT LoginName, YearOfBirth, City
FROM Customer
WHERE City = 'Kosice' AND YearOfBirth BETWEEN 1989 AND 1994
ORDER BY LoginName ASC 

--6. Napíšte select príkaz, 
--ktorý vypíše loginy všetkých zákazníkov s rokom ich narodenia a mestom.
--Vyberte len takých, ktorí majú zadané mesto.
--Zoraďte výsledky podľa loginu zostupne.
SELECT LoginName, YearOfBirth, City
FROM Customer
WHERE City IS NOT NULL
ORDER BY LoginName DESC

--7. Napíšte select príkaz, 
--ktorý vypíše loginy všetkých zákazníkov s rokom ich narodenia a mestom.
--Vyberte len takých, ktorých login začína na písmeno 's'.
--Zoraďte výsledky podľa loginu zostupne.
SELECT LoginName, YearOfBirth, City
FROM Customer
WHERE LoginName LIKE 's%'
ORDER BY LoginName DESC

--8. Napíšte select príkaz, 
--ktorý vypíše loginy všetkých zákazníkov s rokom ich narodenia a mestom.
--Vyberte len takých, ktorých mesto sa nachádza v (Bratislava, Kosice, Praha)
--Zoraďte výsledky podľa loginu zostupne.
SELECT LoginName, YearOfBirth, City
FROM Customer
WHERE City IN ('Bratislava', 'Kosice', 'Praha')
ORDER BY LoginName DESC


--9. Napíšte select príkaz, ktorý vypíše názvy všetkých výrobkov s ich cenami. 
--Vyberte také, ktoré sú drahšie ako 50€.
--Zoraďte výsledky podľa názvu zostupne.
SELECT Title, Price
FROM Product
WHERE Price > 50
ORDER BY Title DESC
 
--10. Napíšte select príkaz, ktorý vypíše názvy všetkých výrobkov s ich cenami. 
--Vyberte také, ktoré sú drahšie ako 50€, ale sú lacnejšie ako 300€.
--Zoraďte výsledky podľa názvu zostupne.
SELECT Title, Price
FROM Product
WHERE Price > 50 AND Price < 300
ORDER BY Title DESC
   
--11. Napíšte select príkaz, ktorý vypíše názvy všetkých výrobkov s ich cenami. 
--Vyberte také, ktoré sú stoja medzi 20€ a 150€.
--Zoraďte výsledky podľa názvu vzostupne.
SELECT Title, Price
FROM Product
WHERE Price BETWEEN 20 AND 150
ORDER BY Title ASC

--12. Napíšte select príkaz, ktorý vypíše názvy všetkých výrobkov s ich cenami. 
--Vyberte také, ktorých názov začína na 'p'.
--Zoraďte výsledky podľa názvu vzostupne.
SELECT Title, Price
FROM Product
WHERE Title LIKE 's%'
ORDER BY Title ASC

--AGREGÁCIE
--1. Napíšte select príkaz, ktorý vypíše počet všetkých zákazníkov, 
--ktorí sú z mesta Bratislava.
SELECT COUNT(*)
FROM Customer
WHERE City = 'Bratislava'

--2. Napíšte select príkaz, ktorý vypíše rok narodenia zákazníka, ktorý je najnižší.
SELECT MIN(YearOfBirth)
FROM Customer
     
--3. Napíšte select príkaz, ktorý vypíše rok narodenia zákazníka, ktorý je najvyšší.
SELECT MAX(YearOfBirth)
FROM Customer

--4. Napíšte select príkaz, ktorý vypíše všetky mestá bez duplicít.
SELECT DISTINCT City
FROM Customer
   
--5. Napíšte select príkaz, ktorý vypíše priemerný rok narodenia všetkých zákazníkov.
SELECT AVG(YearOfBirth)
FROM Customer

--6. Napíšte select príkaz, ktorý vypíše počet všekých výrobkov.
SELECT COUNT(*)
FROM Product

--7. Napíšte select príkaz, ktorý vypíše najnižšiu cenu výrobku.
SELECT MIN(Price)
FROM Product

--8. Napíšte select príkaz, ktorý vypíše najvyššiu cenu výrobku.
SELECT MAX(Price)
FROM Product 

--9. Napíšte select príkaz, ktorý vypíše priemernú cenu všetkých výrobkov.
SELECT AVG(Price)
FROM Product 

--10. Napíšte select príkaz, ktorý vypíše celkovú cenu cenu všetkých výrobkov.
SELECT SUM(Price)
FROM Product 

