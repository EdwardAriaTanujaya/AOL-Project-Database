CREATE TABLE Country(
  CountryID INT NOT NULL PRIMARY KEY,
  CountryName VARCHAR(25) NOT NULL UNIQUE
);

CREATE TABLE Customer (
  CustomerID INT NOT NULL PRIMARY KEY,
  CountryID INT NOT NULL,
  CONSTRAINT fk_Customer
        FOREIGN KEY (CountryID)
        REFERENCES Country(CountryID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Stock (
  StockID VARCHAR(10) NOT NULL PRIMARY KEY,
  StockDescription TEXT NOT NULL,
  StockQuantity INT NOT NULL CHECK (StockQuantity >= 0),
  StockPrice DECIMAL(5,2) NOT NULL
);

CREATE TABLE InvoiceHeader (
  InvoiceID VARCHAR(10) PRIMARY KEY NOT NULL,
  InvoiceDate DATETIME,
  CustomerID INT NOT NULL,
  CONSTRAINT fk_invoice
    FOREIGN KEY (CustomerID)
    REFERENCES Customer(CustomerID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE ReturnHeader(
  ReturnID VARCHAR(10) NOT NULL PRIMARY KEY,
  ReturnDate DATETIME
);

CREATE TABLE InvoiceDetail(
  InvoiceID VARCHAR(10) NOT NULL,
  StockID VARCHAR(10) NOT NULL,
  InvoiceQuantity INT NOT NULL CHECK (InvoiceQuantity >= 0),

  CONSTRAINT pk_invoice_detail
    PRIMARY KEY (InvoiceID, StockID),
 
  CONSTRAINT fk_invoiceid_invoice_detail
    FOREIGN KEY (InvoiceID)
    REFERENCES InvoiceHeader(InvoiceID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
 
  CONSTRAINT fk_StockID_invoice_detail
    FOREIGN KEY (StockID)
    REFERENCES Stock(StockID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE ReturnDetail (
  ReturnID VARCHAR(10) NOT NULL,
  StockID VARCHAR(10) NOT NULL,
  ReturnQuantity INT NOT NULL CHECK (ReturnQuantity < 0),
  CONSTRAINT pk_return_quantity
    PRIMARY KEY (ReturnID, StockID),

  CONSTRAINT fk_ReturnID_return_detail
    FOREIGN KEY (ReturnID)
    REFERENCES ReturnHeader(ReturnID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
 
  CONSTRAINT fk_StockID_return_detail
    FOREIGN KEY (StockID)
    REFERENCES Stock(StockID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);