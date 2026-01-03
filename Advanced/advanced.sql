# trigger
DELIMITER $$
CREATE TRIGGER Return_Stock
AFTER INSERT ON ReturnDetail
FOR EACH ROW
BEGIN
    UPDATE Stock
    SET StockQuantity = StockQuantity - NEW.ReturnQuantity
    WHERE StockID = NEW.StockID;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER Sales_Stock
AFTER INSERT ON InvoiceDetail
FOR EACH ROW
BEGIN
    UPDATE Stock
    SET StockQuantity = StockQuantity - NEW.InvoiceQuantity
    WHERE StockID = NEW.StockID;
END $$
DELIMITER ;

# stored procedure
DELIMITER $$

CREATE PROCEDURE GetCustomerInvoiceHistory (
    p_CustomerID INT
)

BEGIN

SELECT c.CustomerID, i1.InvoicesDate, SUM(s.StockPrice * i2.InvoiceQuantity) as total_spending
FROM Customer c
JOIN InvoiceHeader i1 ON i1.CustomerID = c.CustomerID
JOIN InvoiceDetail i2 ON i1.InvoiceID = i2.InvoiceID
JOIN Stock s ON s.StockID = i2.StockID
WHERE c.CustomerID = p_CustomerID
GROUP BY c.CustomerID, i1.InvoiceDate;

END$$

DELIMITER ;