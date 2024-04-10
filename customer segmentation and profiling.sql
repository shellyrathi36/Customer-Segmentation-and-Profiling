Create database Customer_profiling;
Use Customer_profiling;


Create Table Customers(
CustomerID int primary key,
FirstName varchar(30),
LastName varchar(30),
Email varchar(30),
Gender varchar(20),
Age int,
City Varchar(30),
State Varchar(30));

Insert into Customers(CustomerID, FirstName,LastName,Email,Gender,Age,City,State) values
(101,'Shamaila','Khan','shama@gmail.com','Female',23,'Chicago','XL'),
(102, 'John', 'Doe', 'john@example.com', 'Male', 30, 'New York', 'NY'),
(103, 'Emily', 'Smith', 'emily@gmail.com', 'Female', 35, 'Los Angeles', 'CA'),
(104, 'Michael', 'Johnson', 'michael@example.com', 'Male', 28, 'Houston', 'TX'),
(105, 'Sarah', 'Brown', 'sarah@gmail.com', 'Female', 40, 'Miami', 'FL'),
(106, 'David', 'Lee', 'david@example.com', 'Male', 45, 'San Francisco', 'CA'),
(107, 'Jennifer', 'Taylor', 'jennifer@gmail.com', 'Female', 32, 'Seattle', 'WA'),
(108, 'Robert', 'Martinez', 'robert@example.com', 'Male', 27, 'Boston', 'MA'),
(109, 'Amanda', 'White', 'amanda@gmail.com', 'Female', 29, 'Dallas', 'TX'),
(110, 'Chris', 'Anderson', 'chris@example.com', 'Male', 38, 'Atlanta', 'GA'),
(111, 'Laura', 'Garcia', 'laura@gmail.com', 'Female', 25, 'Denver', 'CO'),
(112, 'James', 'Wilson', 'james@example.com', 'Male', 33, 'Phoenix', 'AZ'),
(113, 'Jessica', 'Rodriguez', 'jessica@gmail.com', 'Female', 31, 'Philadelphia', 'PA'),
(114, 'Daniel', 'Lopez', 'daniel@example.com', 'Male', 26, 'Detroit', 'MI'),
(115, 'Megan', 'Perez', 'megan@gmail.com', 'Female', 42, 'San Diego', 'CA');

Create Table Transactions(
TransactionID int primary key,
CustomerID int,
TransactionDate date,
Amount Decimal(10,2),
Product varchar(30),
Category Varchar(30));

Insert into Transactions(TransactionID,CustomerID,TransactionDate,Amount,Product,Category) values
(201,103, '2024-01-31', 100.00, 'Books', 'Education'),
(202, 104, '2024-02-15', 75.50, 'Dress', 'Fashion'),
(203,105, '2024-03-05', 50.25, 'Shoes', 'Fashion'),
(204, 105, '2024-04-10', 120.75, 'Gadgets', 'Electronics'),
(205, 111, '2024-05-20', 200.00, 'Furniture', 'Home'),
(206, 115, '2024-06-12', 30.00, 'Cosmetics', 'Beauty'),
(207, 101, '2024-07-08', 80.50, 'Tools', 'DIY'),
(208, 106, '2024-08-18', 150.25, 'Kitchen Appliances', 'Home'),
(209, 112, '2024-09-30', 65.75, 'Headphones', 'Electronics'),
(210, 104, '2024-10-05', 90.00, 'Sports Gear', 'Sports'),
(211, 103, '2024-11-15', 110.50, 'Perfume', 'Beauty'),
(212, 111, '2024-12-20', 40.25, 'Jewelry', 'Fashion'),
(213, 102, '2025-01-02', 55.75, 'Home Decor', 'Home'),
(214, 101, '2025-02-10', 70.00, 'Camera', 'Electronics'),
(215, 101, '2025-03-25', 85.50, 'Laptop', 'Electronics'),
(216,102, '2024-01-31', 100.00, 'Books', 'Education'),
(217, 107, '2024-02-15', 75.50, 'Dress', 'Fashion'),
(218,107, '2024-03-05', 50.25, 'Shoes', 'Fashion'),
(219, 108, '2024-04-10', 120.75, 'Gadgets', 'Electronics'),
(220, 113, '2024-05-20', 200.00, 'Furniture', 'Home'),
(221, 109, '2024-06-12', 30.00, 'Cosmetics', 'Beauty'),
(222, 113, '2024-07-08', 80.50, 'Tools', 'DIY');

-- this is customer Segmentation and classifying people on the basis of AGE
SELECT
  case
  when Age <25 then 'Young'
  when Age between 25 and 35 then 'Middle-Aged'
  when Age >35 then 'Aged'
  end as AgeSegment,
  Count(*) as TotalPeople
from Customers
group by AgeSegment;

-- grouping people on the basis of Gender
Select Gender, count(*) as TotalPeople
from Customers
group by Gender;

-- Estimating the average Transcation Amount of Every Customer
Select c.CustomerID, 
   AVG(Amount) as AverageTransactedAmount,
   Count(*) as TransactionCount
from Customers c
join Transactions on c.CustomerID=Transactions.CustomerID
Group by c.CustomerID;

-- Estimating the net transaction amount of every customer
-- This is Called as Customer Profiling
Select c.CustomerID, 
   SUM(Amount) as TotalTransactedAmount,
   Count(*) as TransactionCount
from Customers c
join Transactions on c.CustomerID=Transactions.CustomerID
Group by c.CustomerID
Order by TotalTransactedAmount desc;

-- Estimating the totalAmount of Every customer on a certain Category
Select c.CustomerID, c.FirstName, t.Category,
     Sum(Amount) as TotalTransactedAmount
from Customers c
join Transactions t on c.CustomerID=t.CustomerID
group by c.CustomerID,t.Category
Order by TotalTransactedAmount desc;

-- Getting the information about the transactions in the particular age groups so foremd by us only 
Select
      CASE
      when Age <28 then 'Young'
      when Age between 28 and 33 then 'Middle-Aged'
      when Age > 33 then 'Aged'
      end as AgeSegment,
      SUM(Amount) as TotalTransactedAmount,
      Count(*) as TotalTransactions
from Customers 
join Transactions on Customers.CustomerID = Transactions.CustomerID
Group  by AgeSegment
Order by TotalTransactions desc;

Select c.CustomerID,t.Year(TransactionDate),
    SUM(Amount)