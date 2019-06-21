--1. Vyp�te v�etk�ch z�kazn�kov, ktor� s� z Ostravy a urobili n�kup predmetu 'lampa'.
SELECT c.LoginName
FROM Customer c
INNER JOIN Shopping s on s.LoginName = c.LoginName
INNER JOIN Product p on s.ProductId = p.ProductId
WHERE c.City = 'Ostrava' AND p.Title = 'lampa'

--2. Vyp�te z�kazn�kov, ktor� k�pili najviac v�robkov za menej ne� 50�.
SELECT TOP 1 c.LoginName, COUNT(p.ProductId)
FROM Customer c
INNER JOIN Shopping s on s.LoginName = c.LoginName
INNER JOIN Product p on s.ProductId = p.ProductId
WHERE p.Price < 50
GROUP BY p.ProductId, c.LoginName
ORDER BY COUNT(p.ProductId) DESC

--3. Vyp�te celkov� �tratu jednotliv�ch z�kazn�kov.
SELECT c.LoginName, SUM(p.Price)
FROM Customer c 
INNER JOIN Shopping s on c.LoginName = s.LoginName
INNER JOIN Product p on s.ProductId = p.ProductId
GROUP BY c.LoginName

--4. Vyp�te, ko�ko kr�t boli v roku 2019 zak�pen� jednotliv� v�robky z�kazn�kmi naroden�mi v rokoch 1980 a 1995.
SELECT c.LoginName, COUNT(s.ProductId)
FROM Customer c
INNER JOIN Shopping s on s.LoginName = c.LoginName
INNER JOIN Product p on p.ProductId = s.ProductId
WHERE c.YearOfBirth = 1976 OR c.YearOfBirth = 1991
GROUP BY c.LoginName

--5. N�jdite v�etky v�robky, ktor� si jeden z�kazn�k k�pil aspo� dva kr�t.
SELECT c.LoginName
FROM Customer c
INNER JOIN Shopping s on s.LoginName = c.LoginName
INNER JOIN Product p on p.ProductId = s.ProductId
WHERE c.YearOfBirth = 1976 OR c.YearOfBirth = 1991
GROUP BY c.LoginName
HAVING COUNT(s.ProductId) > 2

--6. Vyp�te v�robky, ktor� si nikdy nek�pil ani "vinetu" ani "pepik". Odstr��te duplicity.
SELECT DISTINCT p.Title
FROM Customer c
INNER JOIN Shopping s on s.LoginName = c.LoginName
INNER JOIN Product p on p.ProductId = s.ProductId
WHERE c.LoginName != 'vinetu' AND c.LoginName != 'pepik'

--7. Vyp�te v�robky, ktor� kupovali v�dy len pou��vatelia z rovnak�ho mesta.
SELECT P.Title 
FROM Product p
LEFT JOIN Customer c ON s.LoginName = c.LoginName
LEFT JOIN Shopping s ON p.ProductId = s.ProductId
GROUP BY p.Title
HAVING COUNT(DISTINCT City) = 1

--8. Pre ka�d�ho z�kazn�ka vyp�te, ktor� v�robok kupoval naj�astej�ie.
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

--9. Pre ka�d� v�robok vyp�te, kto ho naj�astej�ie kupoval.
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

--10. N�jdite v�robky, ktor� kupovali z�kazn�ci, ktor� si nikdy nek�pili in� v�robok.
SELECT DISTINCT p.ProductId, p.Title
FROM Shopping s 
INNER JOIN Product p ON s.PRoductId = p.ProductId
WHERE NOT EXISTS (
		SELECT *
		FROM Shopping ss
		WHERE s.LoginName = ss.LoginName AND s.PRoductId != ss.ProductId
	)
