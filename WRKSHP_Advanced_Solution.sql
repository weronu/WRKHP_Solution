--1. Vypíšte všetkých zákazníkov, ktorí sú z Ostravy a urobili nákup predmetu 'lampa'.
SELECT c.LoginName
FROM Customer c
INNER JOIN Shopping s on s.LoginName = c.LoginName
INNER JOIN Product p on s.ProductId = p.ProductId
WHERE c.City = 'Ostrava' AND p.Title = 'lampa'

--2. Vypíšte zákazníkov, ktorí kúpili najviac výrobkov za menej než 50€.
SELECT TOP 1 c.LoginName, COUNT(p.ProductId)
FROM Customer c
INNER JOIN Shopping s on s.LoginName = c.LoginName
INNER JOIN Product p on s.ProductId = p.ProductId
WHERE p.Price < 50
GROUP BY p.ProductId, c.LoginName
ORDER BY COUNT(p.ProductId) DESC

--3. Vypíšte celkovú útratu jednotlivých zákazníkov.
SELECT c.LoginName, SUM(p.Price)
FROM Customer c 
INNER JOIN Shopping s on c.LoginName = s.LoginName
INNER JOIN Product p on s.ProductId = p.ProductId
GROUP BY c.LoginName

--4. Vypíšte, ko¾ko krát boli v roku 2019 zakúpené jednotlivé výrobky zákazníkmi narodenými v rokoch 1980 a 1995.
SELECT c.LoginName, COUNT(s.ProductId)
FROM Customer c
INNER JOIN Shopping s on s.LoginName = c.LoginName
INNER JOIN Product p on p.ProductId = s.ProductId
WHERE c.YearOfBirth = 1976 OR c.YearOfBirth = 1991
GROUP BY c.LoginName

--5. Nájdite všetky výrobky, ktoré si jeden zákazník kúpil aspoò dva krát.
SELECT c.LoginName
FROM Customer c
INNER JOIN Shopping s on s.LoginName = c.LoginName
INNER JOIN Product p on p.ProductId = s.ProductId
WHERE c.YearOfBirth = 1976 OR c.YearOfBirth = 1991
GROUP BY c.LoginName
HAVING COUNT(s.ProductId) > 2

--6. Vypíšte výrobky, ktoré si nikdy nekúpil ani "vinetu" ani "pepik". Odstráòte duplicity.
SELECT DISTINCT p.Title
FROM Customer c
INNER JOIN Shopping s on s.LoginName = c.LoginName
INNER JOIN Product p on p.ProductId = s.ProductId
WHERE c.LoginName != 'vinetu' AND c.LoginName != 'pepik'

--7. Vypíšte výrobky, ktoré kupovali vždy len používatelia z rovnakého mesta.
SELECT P.Title 
FROM Product p
LEFT JOIN Customer c ON s.LoginName = c.LoginName
LEFT JOIN Shopping s ON p.ProductId = s.ProductId
GROUP BY p.Title
HAVING COUNT(DISTINCT City) = 1

--8. Pre každého zákazníka vypíšte, ktorý výrobok kupoval najèastejšie.
SELECT DISTINCT	c.LoginName, p.Title, COUNT(s.ProductId)
FROM Customer c
INNER JOIN Shopping s ON c.LoginName = s.LoginName
INNER JOIN Product p ON s.ProductId = p.ProductId
GROUP BY c.LoginName, p.ProductId, p.Title
HAVING
	COUNT(s.ProductId) >= ALL
	(
		SELECT COUNT(ProductId)
		FROM Shopping s
		WHERE LoginName = c.LoginName
		GROUP BY ProductId
	)

--9. Pre každý výrobok vypíšte, kto ho najèastejšie kupoval.
SELECT p.Title, c.LoginName, COUNT(s.ProductId)
FROM Product p
LEFT JOIN Customer c ON s.LoginName = c.LoginName
LEFT JOIN Shopping s ON p.ProductId = s.ProductId
GROUP BY p.ProductId, p.Title, c.LoginName
HAVING
	COUNT(s.ProductId) >= ALL
	(
		SELECT COUNT(ProductId)
		FROM Shopping
		WHERE ProductId = p.ProductId
		GROUP BY LoginName
	)

--10. Nájdite výrobky, ktoré kupovali zákazníci, ktorí si nikdy nekúpili iný výrobok.
SELECT DISTINCT p.ProductId, p.Title
FROM Shopping s 
INNER JOIN Product p ON s.PRoductId = p.ProductId
WHERE NOT EXISTS (
		SELECT *
		FROM Shopping ss
		WHERE s.LoginName = ss.LoginName AND s.PRoductId != ss.ProductId
	)
