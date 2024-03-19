create database case_study1

use case_study1

create table FactTable
(
Date_ date
,ProductId int
,Profit int
,Sales int
,Margin int
,COGS int
,"Total Expenses" int
,Marketing int
,Inventory int
,"Budget Profit" int
,"Budget COGS" int
,"Budget Margin" int
,"Budget Sales" int
,"Area Code" int
)


bulk insert dbo.FactTable

from "C:\Program Files\Microsoft SQL Server\MSSQL16.DEEPAKTIWARY\MSSQL\DATA\fact.csv"
with 
(
  FORMAT = 'CSV',
  FIRSTROW = 2

  )
go

select * from FactTable

create table ProductTable
(
ProductId int
,"Product Type" varchar(50)
,Product varchar(50)
,Type_ varchar(50)
)

bulk insert dbo.ProductTable

from "C:\Program Files\Microsoft SQL Server\MSSQL16.DEEPAKTIWARY\MSSQL\DATA\Product.csv"
with 
(
  FORMAT = 'CSV',
  FIRSTROW = 2

  )
go

select * from ProductTable

create table LocationTable
(
"Area Code" int
,State_ varchar(50)
,Market varchar(50)
,"Market Size" varchar(50)
)


bulk insert dbo.LocationTable

from "C:\Program Files\Microsoft SQL Server\MSSQL16.DEEPAKTIWARY\MSSQL\DATA\Location.csv"
with 
(
  FORMAT = 'CSV',
  FIRSTROW = 2

  )
go

select * from LocationTable


-----------------------------------------------------------------------------------------------------------

--1. Display the number of states present in the LocationTable.

select count(distinct state_) from LocationTable

--2. How many products are of regular type?

select count(distinct Product) from ProductTable
where Type_ = 'Regular'

--3. How much spending has been done on marketing of product ID 1?

select sum ("Total Expenses") from FactTable
where ProductId = 1

--4. What is the minimum sales of a product?

select PT.Product, min("Sales") as MinimumSales 
from FactTable FT, ProductTable PT
where FT.ProductId = PT.ProductId
group by PT.Product

--5. Display the max Cost of Good Sold (COGS).

select max(COGS) as max_cost_of_Good_Sold 
from FactTable

--6. Display the details of the product where product type is coffee.

select * from ProductTable
where "Product Type" = 'Coffee'

--7. Display the details where total expenses are greater than 40.

select * from FactTable
where "Total Expenses" > 40

--8. What is the average sales in area code 719?

select AVG(Sales) as AverageSales from FactTable
where "Area Code" = 719


--9. Find out the total profit generated by Colorado state.

select sum(Profit) as TotalProfit
from FactTable
where "Area Code" in 
(select "Area Code" from LocationTable
where State_ = 'Colorado')

--10. Display the average inventory for each product ID. 

select ProductId, avg(inventory) as AverageInventory
from FactTable
group by ProductId
order by ProductId

--11. Display state in a sequential order in a Location Table.

select distinct State_ from LocationTable
order by State_

--12. Display the average budget of the Product where the average budget margin should be greater than 100.

select PT.Product, 
avg("Budget Margin") as AverageBudgetMargin,
avg("Budget Sales") as AverageBudgetSales,
avg("Budget Profit") as AverageBudgetProfit,
avg("Budget Sales") as AverageBudgetSales
from FactTable FT, ProductTable PT
where FT.ProductId = PT.ProductId
group by PT.Product
having avg("Budget Margin") > 100

--13. What is the total sales done on date 2010-01-01?

select sum(Sales) as TotalSales
from FactTable
where Date_ = '2010-01-01'

--14. Display the average total expense of each product ID on an individual date. 

select ProductId, Date_, avg("Total Expenses") as AverageTotalExpense
from FactTable
group by ProductId, Date_
order by ProductId, Date_


--15. Display the table with the following attributes such as date, productID, product_type, product, sales, profit, state, area_code.

select FT.Date_, FT.ProductId, PT."Product Type", FT.Sales, FT.profit, LT.State_, LT."Area Code"
from FactTable FT, ProductTable PT, LocationTable LT
where FT.ProductId = PT.ProductId
and FT.[Area Code] = LT.[Area Code]

--16. Display the rank without any gap to show the sales wise rank. 

select PT.Product, Date_, sales, DENSE_RANK() over (order by sales desc) as SalesRank
from FactTable FT, ProductTable PT
where FT.ProductId = PT.ProductId
group by PT.Product, Sales, Date_

--17. Find the state wise profit and sales. 

select LT.State_, 
sum(FT.Sales) as StateWiseSales, 
sum(FT.profit) as StateWiseProfit
from FactTable FT, LocationTable LT
where FT.[Area Code] = LT.[Area Code]
group by State_
order by State_

--18. Find the state wise profit and sales along with the productname. 

select LT.State_, PT.Product,
sum(FT.Sales) as StateWiseSales, 
sum(FT.profit) as StateWiseProfit
from FactTable FT, ProductTable PT, LocationTable LT
where FT.[Area Code] = LT.[Area Code]
and FT.ProductId = PT.ProductId
group by State_, Product
order by State_, Product


--19. If there is an increase in sales of 5%, calculate the increasedsales. 

select *, Sales * 1.05 as IncreasedSales 
from FactTable

--20. Find the maximum profit along with the product ID and producttype.

select FT.ProductId, PT.[product type], product, max(profit) as MaximumProfit
from FactTable FT, ProductTable PT
where FT.ProductId = PT.ProductId
group by FT.ProductId, PT.[product type], product

--21. Create a stored procedure to fetch the result according to the product typefrom Product Table. 

create or alter procedure fetch_result_according_to_product_type
@ProductType varchar(50)
as
select * from ProductTable
where "Product Type" = @ProductType

--22. Write a query by creating a condition in which if the total expenses is less than 60 then it is a profit or else loss. 

select *, 
case 
when "total expenses" < 60 then 'Profit'
else 'loss'
end as profit_or_loss
from FactTable

--23. Give the total weekly sales value with the date and product ID details. Useroll-up to pull the data in hierarchical order.

select DATEPART(wk, Date_) as WeekOfTheMonth,
Date_,
productid,
sum(sales) TotalWeeklySales
from FactTable
group by rollup (DATEPART(wk, Date_), Date_, productid)

--24. Apply union and intersection operator on the tables which consist of attribute area code. 

select "area code" from FactTable
union
select "area code" from LocationTable

select "area code" from FactTable
intersection
select "area code" from LocationTable

--25. Create a user-defined function for the product table to fetch a particular product type based upon the user�s preference.

create or alter function dbo.fetch_particular_product_type(@Product_Id int)
returns table
as
return
select "product type" from ProductTable
where ProductId = @Product_Id;

--26. Change the product type from coffee to tea where product IDis 1 and undo it. 

declare @changeTheProductType varchar(50) = 'Coffe to Tea Update'

BEGIN TRAN @changeTheProductType

select * from ProductTable
where "ProductId" = 1;

update ProductTable 
set "Product Type" = 'Tea'
where "ProductId" = 1;

select * from ProductTable
where "ProductId" = 1;

Rollback TRAN @changeTheProductType;

select * from ProductTable
where "ProductId" = 1;

--27. Display the date, product ID and sales where total expenses are between 100 to 200.

select Date_, ProductId, Sales
from FactTable
where "Total Expenses" between 100 and 200

--28. Delete the records in the Product Table for regular type.

delete from ProductTable
where Type_ = 'Regular'

--29. Display the ASCII value of the fifth character from the column Product

select product, ascii(SUBSTRING(Product, 5, 1))as Ascii_Value_of_fifth_char
from ProductTable
