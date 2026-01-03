# Number 1
INSERT INTO Stock (StockID, StockDescription, StockPrice)
VALUE ('42131A', 'GREEN SHOES',  7.95);

# Number 2
BEGIN;

INSERT INTO InvoiceHeader (InvoiceID, InvoiceDate, CustomerID)
VALUES  ('56789', '2025-10-12 12:51:00', 17364);

INSERT INTO InvoiceDetail (InvoiceID, StockID, InvoiceQuantity)
VALUES ('56789', '22119', 10);

INSERT INTO InvoiceDetail (InvoiceID, StockID, InvoiceQuantity)
VALUES ('56789', '90003D', 5);

UPDATE Stock
SET StockQuantity = StockQuantity - 10
WHERE StockID = '22119';

UPDATE Stock
SET StockQuantity = StockQuantity - 5
WHERE StockID = '90003D';

COMMIT;

# Number 3
BEGIN;

INSERT INTO ReturnHeader
VALUES ('C54321', '2025-10-12');

INSERT INTO ReturnDetail
VALUES ('C54321', '90003D', -5);

UPDATE Stock
SET StockQuantity = StockQuantity + 5
WHERE StockID = '90003D';

COMMIT;

# Number 4
SELECT c.CustomerID, c.CountryID, SUM(p.StockPrice * i2.InvoiceQuantity) AS total_spending
FROM Customer c
JOIN invoiceheader i1 ON i1.CustomerID = c.CustomerID
JOIN InvoiceDetail i2 ON i2.InvoiceID = i1.InvoiceID
JOIN Stock p ON p.StockID = i2.StockID
GROUP BY c.CustomerID, c.CountryID
ORDER BY total_spending DESC
LIMIT 10;

# Number 5
SELECT MONTH(i1.InvoiceDate) AS Month_Highest_Spending,  MAX(p.StockPrice * i2.InvoiceQuantity) AS Highest_spending
FROM Stock p
JOIN InvoiceDetail i2 ON p.StockID = i2.StockID
JOIN InvoiceHeader i1 ON i1.InvoiceID = i2.InvoiceID
WHERE YEAR(i1.InvoiceDate) = 2011
GROUP BY MONTH(i1.InvoiceDate)
ORDER BY Highest_spending DESC
LIMIT 1;