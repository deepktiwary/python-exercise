
create database assignment3

use assignment3

create table JomatoData
(
OrderId INTEGER
,RestaurantName VARCHAR(200)
,RestaurantType VARCHAR(200)
,Rating FLOAT
,No_of_Rating INTEGER
,AverageCost FLOAT
,OnlineOrder VARCHAR(200)
,TableBooking VARCHAR(200)
,CuisinesType VARCHAR(200)
,Area VARCHAR(200)
,LocalAddress VARCHAR(200)
,"Delivery time" INTEGER
)



SELECT * FROM JomatoData


bulk insert dbo.JomatoData

from "C:\Program Files\Microsoft SQL Server\MSSQL16.DEEPAKTIWARY\MSSQL\DATA\JomatoData.csv"
with 
(
  FORMAT = 'CSV',
  FIRSTROW = 2

  )
go


--1. Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.
create or alter procedure table_booking_not_zero
@TableBooking varchar(50)
as
select RestaurantName, RestaurantType, CuisinesType
from JomatoData
where TableBooking = @TableBooking

GO

EXEC table_booking_not_zero @TableBooking = 'Yes'

--Or it can be created like below also:

create or alter procedure table_booking_not_zero_one_more_example
as
select RestaurantName, RestaurantType, CuisinesType
from JomatoData
where TableBooking = 'Yes'

EXEC table_booking_not_zero_one_more_example

--2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.


DECLARE @UpdateStatement VARCHAR(20) = 'FirstUpdate';

BEGIN TRAN @UpdateStatement

update JomatoData set CuisinesType = 'Cafeteria' where CuisinesType = 'Cafe';
select * from JomatoData where CuisinesType like '%Cafe%';

Rollback TRAN @UpdateStatement;


select * from JomatoData where CuisinesType like '%Cafe%';
--3. Generate a row number column and find the top 5 areas with the highest rating of restaurants.

with HighestRatingRestaurantsByArea as
(
select Area, Rating, ROW_NUMBER() over(order by Rating desc) as "row number"
from JomatoData
)

select Area from HighestRatingRestaurantsByArea
where "row number" <=5


--4. Use the while loop to display the 1 to 50.

DECLARE @start int = 1

While @start<=50
Begin
print @start
set @start = @start + 1

End
--5. Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.

Create view FiveHighestRatingOfRestaurants as
(
select *, ROW_NUMBER() over(order by Rating desc) as "row number"
from JomatoData
)

select * from FiveHighestRatingOfRestaurants
where "row number" <=5


--6. Write a trigger that sends an email notification to the restaurant owner whenever a new record is inserted.create trigger email_notification_for_insert
on JomatoData
for
insert
as 
print 'New Records are Inserted'
