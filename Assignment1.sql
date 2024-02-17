create database assignment
use assignment

CREATE TABLE Salesman (
    SalesmanId INT,
    Name VARCHAR(255),
    Commission DECIMAL(10, 2),
    City VARCHAR(255),
    Age INT
);

INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
VALUES
    (101, 'Joe', 50, 'California', 17),
    (102, 'Simon', 75, 'Texas', 25),
    (103, 'Jessie', 105, 'Florida', 35),
    (104, 'Danny', 100, 'Texas', 22),
    (105, 'Lia', 65, 'New Jersey', 30);



CREATE TABLE Customer (
    SalesmanId INT,
    CustomerId INT,
    CustomerName VARCHAR(255),
    PurchaseAmount INT,
    );

INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
    (101, 2345, 'Andrew', 550),
    (103, 1575, 'Lucky', 4500),
    (104, 2345, 'Andrew', 4000),
    (107, 3747, 'Remona', 2700),
    (110, 4004, 'Julia', 4545);

CREATE TABLE Orders (OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount money)

INSERT INTO Orders Values 
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500)


--Insert a new record in your Orders table.INSERT INTO Orders Values 
(5005,9658,103,'2024-02-01',5590)

--Add Primary key constraint for SalesmanId column in Salesman table

ALTER TABLE Salesman ALTER COLUMN SalesmanId INT NOT NULL

ALTER TABLE Salesman ADD PRIMARY KEY (SalesmanId)

-- Add default constraint for City column in Salesman table

ALTER TABLE Salesman ADD CONSTRAINT default_constraint DEFAULT 'Pune' for City

--Add Foreign key constraint for SalesmanId column in Customer table


INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
    (102, 2905, 'Deepak', 550),
    (105, 1895, 'Tiwary', 4500)

INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
VALUES
    (107, 'Dipak', 50, 'California', 17),
    (110, 'Tiwari', 75, 'Texas', 25)

ALTER TABLE Customer ADD CONSTRAINT for_key FOREIGN KEY (SalesmanId) REFERENCES Salesman(SalesmanId)

-- Add not null constraint in Customer_name column for the Customer table

ALTER TABLE Customer ALTER COLUMN CustomerName VARCHAR(255) NOT NULL

--Fetch the data where the Customer’s name is ending with ‘N’ also get the purchase amount value greater than 500


SELECT * FROM Customer 
where CustomerName like '%N'
and CustomerId in (
SELECT CustomerId FROM Orders 
where PurchaseAmount > 500)

--Using SET operators, retrieve the first result with unique SalesmanId values from two
--tables, and the other result containing SalesmanId with duplicates from two tables.--UniqueSELECT SalesmanId FROM SalesmanunionSELECT SalesmanId FROM Customer--DuplicatesSELECT SalesmanId FROM Salesmanunion allSELECT SalesmanId FROM Customer--Display the below columns which has the matching data.
--Orderdate, Salesman Name, Customer Name, Commission, and City which has the
--range of Purchase Amount between 500 to 1500

SELECT Orderdate, Name, CustomerName, Commission, City
FROM Salesman s
INNER JOIN Customer c
INNER JOIN Orders o
ON o.CustomerId = c.CustomerId
ON o.SalesmanId = s.SalesmanId
WHERE PurchaseAmount between 500 and 1500

--Using right join fetch all the results from Salesman and Orders table.select * from Orders sRIGHT JOIN Salesman oON o.SalesmanId = s.SalesmanId